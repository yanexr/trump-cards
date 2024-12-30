import 'dart:convert';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../game/multiplayerOnline.dart';
import '../game/network.dart';
import '../game/playerInfo.dart';
import '../gameCard/cards.dart';
import '../home/multiPlayerDialogOnline.dart';
import '../app.dart';

class ConnectDialog extends StatefulWidget {
  const ConnectDialog({super.key});

  @override
  _ConnectDialog createState() => _ConnectDialog();
}

class _ConnectDialog extends State<ConnectDialog> {
  NetworkHandler networkHandler = NetworkHandler();
  String statusMessage = tr('connecting');
  String errorMessage = '';
  List<Player> players = [];
  bool isStartButtonEnabled = false;
  GameCardDeck? cardDeck;

  @override
  void initState() {
    super.initState();

    networkHandler.listenForMessages((msg) {
      NetworkMessage message = NetworkMessage.fromJson(jsonDecode(msg));
      if (message is CreateGameSuccessMessage) {
        setState(() {
          App.gameCode = message.gameCode;
          statusMessage = tr('waitingForPlayers');
          players.add(Player(name: App.username));
        });
      } else if (message is JoinGameSuccessMessage) {
        List<String> usernames = message.usernames;
        setState(() {
          statusMessage = tr('waitingForName', args: [usernames[0]]);
          for (String username in usernames) {
            players.add(Player(name: username));
          }
        });
      } else if (message is NewUserJoinedMessage) {
        setState(() {
          players.add(Player(name: message.username));
        });
      } else if (message is StartGameSuccessMessage) {
        cardDeck = GameCardDeck.fromJson(jsonDecode(message.cardDeckJson));
        List<int> cardIDs = message.cardIds;
        for (Player player in players) {
          player.numberOfCards = cardIDs.length;
        }
        List<GameCard> gameCardList = cardIDs.map((id) {
          return cardDeck!.cards.firstWhere((gameCard) => gameCard.id == id);
        }).toList();

        return Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MultiPlayerOnline(
                    cardDeck: cardDeck!,
                    players: players,
                    stackUser: gameCardList,
                    networkHandler: networkHandler)));
      } else if (message is ErrorMessage) {
        setState(() {
          errorMessage = message.failureReason;
        });
      }
    });

    if (App.gameCode == '') {
      isStartButtonEnabled = true;
      NetworkMessage createGameMessage = CreateGameMessage(App.username);
      networkHandler.webSocketChannel!.sink.add(jsonEncode(createGameMessage));
    } else {
      isStartButtonEnabled = false;
      NetworkMessage joinGameMessage =
          JoinGameMessage(App.gameCode, App.username);
      networkHandler.webSocketChannel!.sink.add(jsonEncode(joinGameMessage));
    }
  }

  void _startGame() {
    List<int> cardIDs =
        App.selectedCardDeck!.cards.map((card) => card.id).toList();
    cardIDs.shuffle();

    // Each player gets the same number of cards
    int numberOfCards = cardIDs.length ~/ players.length;
    // Limit the number of cards per player
    if (players.length == 2) {
      numberOfCards = min(numberOfCards, 15);
    }
    if (players.length == 3) {
      numberOfCards = min(numberOfCards, 11);
    }
    if (players.length == 4) {
      numberOfCards = min(numberOfCards, 11);
    }

    List<List<int>> cardDeckIds = [];
    for (int i = 0; i < players.length; i++) {
      int startIndex = i * numberOfCards;
      int endIndex = startIndex + numberOfCards;
      cardDeckIds.add(cardIDs.sublist(startIndex, endIndex));
    }

    // Copy the card deck to avoid modifying the original deck
    cardDeck =
        GameCardDeck.fromJson(jsonDecode(jsonEncode(App.selectedCardDeck)));

    // Remove unused cards from the card deck
    cardDeck!.cards.retainWhere(
        (card) => cardDeckIds.any((deck) => deck.contains(card.id)));

    NetworkMessage startGameMessage =
        StartGameMessage(cardDeckIds, jsonEncode(cardDeck));
    networkHandler.webSocketChannel!.sink.add(jsonEncode(startGameMessage));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Container(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              Text(
                App.gameCode.isNotEmpty ? App.gameCode : '...',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              errorMessage.isEmpty
                  ? Column(
                      children: [
                        const CupertinoActivityIndicator(),
                        const SizedBox(height: 20),
                        Text(statusMessage),
                        Container(
                          margin: const EdgeInsets.only(top: 20),
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          decoration: BoxDecoration(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Text(tr('connectedPlayers')),
                              const SizedBox(height: 10),
                              for (Player player in players)
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(player.name,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary)),
                                      ],
                                    ))
                            ],
                          ),
                        ),
                      ],
                    )
                  : Text(errorMessage,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 10),
            ],
          )),
      actions: <Widget>[
        MaterialButton(
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(tr('back').toUpperCase()),
          onPressed: () {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (_) {
                  return const MultiPlayerDialogOnline();
                });
          },
        ),
        isStartButtonEnabled
            ? MaterialButton(
                height: 40,
                color: Theme.of(context).colorScheme.primary,
                disabledColor: Colors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                onPressed: players.length > 1
                    ? () {
                        _startGame();
                        setState(() {
                          statusMessage = tr('startingGame');
                        });
                      }
                    : null,
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(tr('play').toUpperCase(),
                      style: const TextStyle(color: Colors.white)),
                  const Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                  )
                ]),
              )
            : const SizedBox(width: 0, height: 0)
      ],
    );
  }

  @override
  void dispose() {
    networkHandler.close();
    super.dispose();
  }
}
