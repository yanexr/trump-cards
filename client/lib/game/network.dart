import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class NetworkHandler {
  WebSocketChannel? webSocketChannel;
  StreamController<String>? _streamController;

  NetworkHandler() {
    webSocketChannel =
        WebSocketChannel.connect(Uri.parse(const String.fromEnvironment("WS_URL", defaultValue: 'wss://trump-cards-l5uoqynpia-ey.a.run.app')));
  }

  void close() {
    webSocketChannel!.sink.close();
    if (_streamController != null) _streamController!.close();
  }

  void listenForMessages(Function(String) onMessageReceived) {
    if (_streamController != null) {
      _streamController!.stream.listen((message) {
        onMessageReceived(message);
      });
    } else {
      _streamController = StreamController<String>.broadcast();
      webSocketChannel!.stream.listen((message) {
        _streamController!.add(message);
      });
      _streamController!.stream.listen((message) {
        onMessageReceived(message);
      });
    }
  }
}
