import 'dart:async';

import 'package:flutter/material.dart';

class Message {
  final String text;
  final Color color;
  Message(this.text, this.color);
}

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  MessageListState createState() => MessageListState();
}

class MessageListState extends State<MessageList> {
  final List<Message> _messages = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
  }

  void addMessage(Message message) {
    _messages.add(message);
    _listKey.currentState?.insertItem(_messages.length - 1);
    Timer(const Duration(seconds: 3), removeMessage);
  }

  void removeMessage() {
    Message message = _messages[0];
    _messages.removeAt(0);
    _listKey.currentState?.removeItem(
        0,
        (context, animation) => SizeTransition(
            sizeFactor: animation, child: Toast(message: message)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: AnimatedList(
            key: _listKey,
            reverse: true,
            initialItemCount: 0,
            itemBuilder: (context, index, animation) => SizeTransition(
                sizeFactor: animation,
                child: Toast(message: _messages[index]))));
  }
}

class Toast extends StatelessWidget {
  final Message message;
  const Toast({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //constraints: const BoxConstraints(maxWidth: 800),
      margin: const EdgeInsets.fromLTRB(20, 4, 20, 4),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
          child: Text(message.text, style: TextStyle(color: message.color))),
    );
  }
}
