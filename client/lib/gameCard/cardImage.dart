import 'package:flutter/material.dart';

bool isRemoteImagePath(String imagePath) => imagePath.startsWith('http');

bool isEmbeddedImagePath(String imagePath) => imagePath.startsWith('data:');

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
    return Image.network(
      imagePath,
      fit: fit,
      width: width,
      height: height,
      alignment: alignment,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return placeholder();
      },
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
