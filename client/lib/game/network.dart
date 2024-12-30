import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';

class NetworkHandler {
  WebSocketChannel? webSocketChannel;
  StreamController<String>? _streamController;

  NetworkHandler() {
    webSocketChannel = WebSocketChannel.connect(Uri.parse(
        const String.fromEnvironment("WS_URL",
            defaultValue: 'ws://localhost:8000')));
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

enum MessageType {
  createGame,
  createGameSuccess,
  joinGame,
  joinGameSuccess,
  newUserJoined,
  startGame,
  startGameSuccess,
  sendCard,
  sendCardSuccess,
  error
}

// Base class for network messages
abstract class NetworkMessage {
  final MessageType type;

  NetworkMessage(this.type);

  Map<String, dynamic> toJson();

  factory NetworkMessage.fromJson(Map<String, dynamic> json) {
    final type = MessageType.values.firstWhere((e) => e.name == json['type']);
    switch (type) {
      case MessageType.createGame:
        return CreateGameMessage.fromJson(json);
      case MessageType.createGameSuccess:
        return CreateGameSuccessMessage.fromJson(json);
      case MessageType.joinGame:
        return JoinGameMessage.fromJson(json);
      case MessageType.joinGameSuccess:
        return JoinGameSuccessMessage.fromJson(json);
      case MessageType.newUserJoined:
        return NewUserJoinedMessage.fromJson(json);
      case MessageType.startGame:
        return StartGameMessage.fromJson(json);
      case MessageType.startGameSuccess:
        return StartGameSuccessMessage.fromJson(json);
      case MessageType.sendCard:
        return SendCardMessage.fromJson(json);
      case MessageType.sendCardSuccess:
        return SendCardSuccessMessage.fromJson(json);
      case MessageType.error:
        return ErrorMessage.fromJson(json);
    }
  }
}

// Message: Create Game
class CreateGameMessage extends NetworkMessage {
  final String username;

  CreateGameMessage(this.username) : super(MessageType.createGame);

  @override
  Map<String, dynamic> toJson() => {'type': type.name, 'username': username};

  factory CreateGameMessage.fromJson(Map<String, dynamic> json) {
    return CreateGameMessage(json['username']);
  }
}

// Message: Create Game Success
class CreateGameSuccessMessage extends NetworkMessage {
  final String gameCode;

  CreateGameSuccessMessage(this.gameCode)
      : super(MessageType.createGameSuccess);

  @override
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'gameCode': gameCode,
      };

  factory CreateGameSuccessMessage.fromJson(Map<String, dynamic> json) {
    return CreateGameSuccessMessage(json['gameCode']);
  }
}

// Message: Join Game
class JoinGameMessage extends NetworkMessage {
  final String gameCode;
  final String username;

  JoinGameMessage(this.gameCode, this.username) : super(MessageType.joinGame);

  @override
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'gameCode': gameCode,
        'username': username,
      };

  factory JoinGameMessage.fromJson(Map<String, dynamic> json) {
    return JoinGameMessage(json['gameCode'], json['username']);
  }
}

// Message: Join Game Success
class JoinGameSuccessMessage extends NetworkMessage {
  final List<String> usernames;

  JoinGameSuccessMessage(this.usernames) : super(MessageType.joinGameSuccess);

  @override
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'usernames': usernames,
      };

  factory JoinGameSuccessMessage.fromJson(Map<String, dynamic> json) {
    return JoinGameSuccessMessage(List<String>.from(json['usernames']));
  }
}

// Message: New User Joined
class NewUserJoinedMessage extends NetworkMessage {
  final String username;

  NewUserJoinedMessage(this.username) : super(MessageType.newUserJoined);

  @override
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'username': username,
      };

  factory NewUserJoinedMessage.fromJson(Map<String, dynamic> json) {
    return NewUserJoinedMessage(json['username']);
  }
}

// Message: Start Game
class StartGameMessage extends NetworkMessage {
  final List<List<int>> cardIds;
  final String cardDeckJson;

  StartGameMessage(this.cardIds, this.cardDeckJson)
      : super(MessageType.startGame);

  @override
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'cardIds': cardIds,
        'cardDeckJson': cardDeckJson,
      };

  factory StartGameMessage.fromJson(Map<String, dynamic> json) {
    return StartGameMessage(
        List<List<int>>.from(json['cardIds']), json['cardDeckJson']);
  }
}

// Message: Start Game Success
class StartGameSuccessMessage extends NetworkMessage {
  final List<int> cardIds;
  final String cardDeckJson;

  StartGameSuccessMessage(this.cardIds, this.cardDeckJson)
      : super(MessageType.startGameSuccess);

  @override
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'cardIds': cardIds,
        'cardDeckJson': cardDeckJson,
      };

  factory StartGameSuccessMessage.fromJson(Map<String, dynamic> json) {
    return StartGameSuccessMessage(
        List<int>.from(json['cardIds']), json['cardDeckJson']);
  }
}

// Message: Send Card
class SendCardMessage extends NetworkMessage {
  final int cardId;
  final String fromUsername;
  final String toUsername;

  SendCardMessage(this.cardId, this.fromUsername, this.toUsername)
      : super(MessageType.sendCard);

  @override
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'cardId': cardId,
        'fromUsername': fromUsername,
        'toUsername': toUsername,
      };

  factory SendCardMessage.fromJson(Map<String, dynamic> json) {
    return SendCardMessage(
        json['cardId'], json['fromUsername'], json['toUsername']);
  }
}

// Message: Send Card Success
class SendCardSuccessMessage extends NetworkMessage {
  final int cardId;
  final String fromUsername;
  final String toUsername;

  SendCardSuccessMessage(this.cardId, this.fromUsername, this.toUsername)
      : super(MessageType.sendCardSuccess);

  @override
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'cardId': cardId,
        'fromUsername': fromUsername,
        'toUsername': toUsername,
      };

  factory SendCardSuccessMessage.fromJson(Map<String, dynamic> json) {
    return SendCardSuccessMessage(
        json['cardId'], json['fromUsername'], json['toUsername']);
  }
}

// Message: Error
class ErrorMessage extends NetworkMessage {
  final String failureReason;

  ErrorMessage(this.failureReason) : super(MessageType.error);

  @override
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'failureReason': failureReason,
      };

  factory ErrorMessage.fromJson(Map<String, dynamic> json) {
    return ErrorMessage(json['failureReason']);
  }
}
