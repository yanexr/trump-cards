import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/game/network.dart';
import 'package:trump_cards/game/messageList.dart';

import 'gameEndedDialog.dart';
import 'playerInfo.dart';
import '../game/exitButton.dart';
import '../gameCard/animatedCardStack.dart';
import '../app.dart';
import '../gameCard/cards.dart';

class MultiPlayerOnline extends StatefulWidget {
  final NetworkHandler networkHandler;
  final List<GameCard> stackUser;
  final List<Player> players;
  final GameCardDeck cardDeck;

  const MultiPlayerOnline(
      {super.key,
      required this.cardDeck,
      required this.players,
      required this.stackUser,
      required this.networkHandler});

  @override
  _MultiPlayerOnlineState createState() => _MultiPlayerOnlineState();
}

class _MultiPlayerOnlineState extends State<MultiPlayerOnline> {
  late Player thisPlayer;
  bool isSendingInProgress = false;
  late int points;

  final GlobalKey<AnimatedCardStackState> _animatedCardStackKey =
      GlobalKey<AnimatedCardStackState>();

  final GlobalKey<MessageListState> _messageList =
      GlobalKey<MessageListState>();

  @override
  void initState() {
    super.initState();
    points = widget.cardDeck.cards.length * 2;
    thisPlayer =
        widget.players.firstWhere((player) => player.name == App.username);

    widget.networkHandler.listenForMessages((msg) {
      NetworkMessage message = NetworkMessage.fromJson(jsonDecode(msg));
      if (message is SendCardSuccessMessage) {
        int cardId = message.cardId;
        GameCard card =
            widget.cardDeck.cards.firstWhere((card) => card.id == cardId);
        Player sendFrom = widget.players
            .firstWhere((player) => player.name == message.fromUsername);
        Player sendTo = widget.players
            .firstWhere((player) => player.name == message.toUsername);

        setState(() {
          if (sendFrom == thisPlayer && sendTo == thisPlayer) {
            // User kept card
            _animatedCardStackKey.currentState!.keepCardAnimation(() {
              widget.stackUser.add(widget.stackUser.removeAt(0));
              isSendingInProgress = false;
            });
            _messageList.currentState!.addMessage(Message(
                tr('nameKeptCard', args: [sendTo.name, card.name]),
                Colors.green));
          } else if (sendFrom == thisPlayer) {
            // User sent card to opponent
            points--;
            _animatedCardStackKey.currentState!.loseCardAnimation(() {
              if (thisPlayer.numberOfCards > 0) {
                widget.stackUser.removeAt(0);
              } else {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return const GameEndedDialog(points: 0, win: false);
                    });
              }
              isSendingInProgress = false;
            });
            _messageList.currentState!.addMessage(Message(
                tr('nameReceivedCardFromName',
                    args: [sendTo.name, card.name, sendFrom.name]),
                Colors.red));
          } else if (sendTo == thisPlayer) {
            // User received card from opponent
            widget.stackUser.add(card);
            _messageList.currentState!.addMessage(Message(
                tr('nameReceivedCardFromName',
                    args: [sendTo.name, card.name, sendFrom.name]),
                Colors.green));
          } else {
            // Other player sent card to other player
            if (sendFrom == sendTo) {
              _messageList.currentState!.addMessage(Message(
                  tr('nameKeptCard', args: [sendTo.name, card.name]),
                  Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black));
            } else {
              _messageList.currentState!.addMessage(Message(
                  tr('nameReceivedCardFromName',
                      args: [sendTo.name, card.name, sendFrom.name]),
                  Theme.of(context).textTheme.bodyMedium?.color ??
                      Colors.black));
            }
          }
          sendTo.numberOfCards++;
          sendFrom.numberOfCards--;
        });

        // check if thisPlayer is the only one with more than 0 cards
        if (widget.players.where((player) => player.numberOfCards > 0).length ==
                1 &&
            thisPlayer.numberOfCards > 0) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                if (points < 1) points = 1;
                return GameEndedDialog(points: points, win: true);
              });
        }
      }
    });
  }

  void send(String sendTo) {
    if (isSendingInProgress) return;
    NetworkMessage message =
        SendCardMessage(widget.stackUser[0].id, thisPlayer.name, sendTo);
    widget.networkHandler.webSocketChannel!.sink.add(jsonEncode(message));
    isSendingInProgress = true;
  }

  List<Widget> topRowWidget() {
    List<Widget> topRow = [];
    topRow.addAll([
      PlayerInfoWidget(
        player: thisPlayer,
        height: 75,
        send: send,
      ),
      const SizedBox(width: 10),
      const ExitButton(size: 75),
    ]);

    for (Player player in widget.players) {
      if (player.name != thisPlayer.name) {
        topRow.addAll([
          const SizedBox(width: 10),
          PlayerInfoWidget(
            player: player,
            height: 75,
            send: send,
          )
        ]);
      }
    }
    return topRow;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Stack(children: [
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
              margin: const EdgeInsets.all(15),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...topRowWidget()],
                ),
                const SizedBox(height: 10),
                AnimatedCardStack(
                  key: _animatedCardStackKey,
                  cardStack: widget.stackUser,
                  deck: widget.cardDeck,
                ),
                const SizedBox(height: 10),
              ]),
            ))
          ],
        ),
      ),
      IgnorePointer(
        child: MessageList(key: _messageList),
      ),
    ]))));
  }
}
