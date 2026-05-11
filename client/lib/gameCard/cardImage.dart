import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const remoteImageHeaders = {
  'User-Agent': 'TrumpCardsApp/1.4 (https://github.com/yanexr/trump-cards)',
};

const _maxConcurrentRemoteImageLoads = 4;

final Queue<_RemoteImageLoadTask> _remoteImageLoadQueue =
    Queue<_RemoteImageLoadTask>();
final Map<String, Uint8List> _remoteImageBytesCache = {};
final Map<String, Future<Uint8List>> _remoteImageLoadsInProgress = {};

int _activeRemoteImageLoads = 0;

bool isRemoteImagePath(String imagePath) => imagePath.startsWith('http');

bool isEmbeddedImagePath(String imagePath) => imagePath.startsWith('data:');

Widget buildRemoteImage({
  required String imagePath,
  required Widget Function() placeholderBuilder,
  BoxFit fit = BoxFit.cover,
  double? width,
  double? height,
  AlignmentGeometry alignment = Alignment.center,
}) {
  if (kIsWeb) {
    return Image.network(
      imagePath,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return placeholderBuilder();
      },
    );
  }

  return _QueuedRemoteImage(
    imagePath: imagePath,
    placeholderBuilder: placeholderBuilder,
    fit: fit,
    width: width,
    height: height,
    alignment: alignment,
  );
}

Widget buildCardImage({
  required String imagePath,
  String? deckName,
  BoxFit fit = BoxFit.cover,
  double? width,
  double? height,
  AlignmentGeometry alignment = Alignment.center,
}) {
  Widget placeholder() {
    return Image.asset(
      'assets/images/placeholder.png',
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
    );
  }

  if (imagePath.isEmpty) {
    return placeholder();
  }

  if (isRemoteImagePath(imagePath)) {
    return buildRemoteImage(
      imagePath: imagePath,
      placeholderBuilder: placeholder,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
    );
  }

  if (isEmbeddedImagePath(imagePath)) {
    try {
      final bytes = UriData.parse(imagePath).contentAsBytes();
      return Image.memory(
        bytes,
        fit: fit,
        width: width,
        height: height,
        alignment: alignment,
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          return placeholder();
        },
      );
    } catch (_) {
      return placeholder();
    }
  }

  if (deckName == null || deckName.isEmpty) {
    return placeholder();
  }

  return Image.asset(
    'assets/images/$deckName/$imagePath',
    fit: fit,
    width: width,
    height: height,
    alignment: alignment,
    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
      return placeholder();
    },
  );
}

class _QueuedRemoteImage extends StatefulWidget {
  final String imagePath;
  final Widget Function() placeholderBuilder;
  final BoxFit fit;
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;

  const _QueuedRemoteImage({
    required this.imagePath,
    required this.placeholderBuilder,
    required this.fit,
    required this.width,
    required this.height,
    required this.alignment,
  });

  @override
  State<_QueuedRemoteImage> createState() => _QueuedRemoteImageState();
}

class _QueuedRemoteImageState extends State<_QueuedRemoteImage> {
  late Future<Uint8List> _imageLoad;

  @override
  void initState() {
    super.initState();
    _imageLoad = _loadRemoteImageBytes(widget.imagePath);
  }

  @override
  void didUpdateWidget(_QueuedRemoteImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imagePath != widget.imagePath) {
      _imageLoad = _loadRemoteImageBytes(widget.imagePath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _imageLoad,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Image.memory(
            snapshot.data!,
            fit: widget.fit,
            width: widget.width,
            height: widget.height,
            alignment: widget.alignment,
            gaplessPlayback: true,
            errorBuilder: (context, error, stackTrace) {
              return widget.placeholderBuilder();
            },
          );
        }

        return widget.placeholderBuilder();
      },
    );
  }
}

class _RemoteImageLoadTask {
  final Future<Uint8List> Function() load;
  final Completer<Uint8List> completer = Completer<Uint8List>();

  _RemoteImageLoadTask(this.load);
}

Future<Uint8List> _loadRemoteImageBytes(String imagePath) {
  final cachedBytes = _remoteImageBytesCache[imagePath];
  if (cachedBytes != null) {
    return Future.value(cachedBytes);
  }

  final inProgressLoad = _remoteImageLoadsInProgress[imagePath];
  if (inProgressLoad != null) {
    return inProgressLoad;
  }

  final load = _scheduleRemoteImageLoad(imagePath).then((bytes) {
    _remoteImageBytesCache[imagePath] = bytes;
    return bytes;
  }).whenComplete(() {
    _remoteImageLoadsInProgress.remove(imagePath);
  });

  _remoteImageLoadsInProgress[imagePath] = load;
  return load;
}

Future<Uint8List> _scheduleRemoteImageLoad(String imagePath) {
  final task = _RemoteImageLoadTask(() => _fetchRemoteImageBytes(imagePath));
  _remoteImageLoadQueue.add(task);
  _drainRemoteImageLoadQueue();
  return task.completer.future;
}

void _drainRemoteImageLoadQueue() {
  while (_activeRemoteImageLoads < _maxConcurrentRemoteImageLoads &&
      _remoteImageLoadQueue.isNotEmpty) {
    final task = _remoteImageLoadQueue.removeFirst();
    _activeRemoteImageLoads++;

    task.load().then(task.completer.complete).catchError((Object error) {
      task.completer.completeError(error);
    }).whenComplete(() {
      _activeRemoteImageLoads--;
      _drainRemoteImageLoadQueue();
    });
  }
}

Future<Uint8List> _fetchRemoteImageBytes(String imagePath) async {
  final response = await http.get(Uri.parse(imagePath),
      headers: remoteImageHeaders);

  if (response.statusCode == 200) {
    return response.bodyBytes;
  }

  throw Exception(
      'Failed to load remote image ($imagePath): HTTP ${response.statusCode}');
}
