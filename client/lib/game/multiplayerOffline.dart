import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/gameCard/animatedCardStack.dart';
import '../game/exitButton.dart';
import '../game/gameEndedDialog.dart';
import 'playerInfo.dart';
import '../gameCard/gameCardWidget.dart';

import '../app.dart';
import '../data/cardDecks.dart';
import '../gameCard/cards.dart';

class MultiplayerOffline extends StatefulWidget {
  const MultiplayerOffline({super.key, required});

  @override
  _MultiplayerOfflineState createState() => _MultiplayerOfflineState();
}

class _MultiplayerOfflineState extends State<MultiplayerOffline> {
  late List<GameCard> stackUser = [];
  int points = App.numberOfCardsMultiplayer * 2;
  late bool areButtonsEnabled;
  late bool isCardSelectable;
  Player thisPlayer = Player(name: App.username);
  Player opponent = Player(name: tr('opponents'));
  SelectedCharacteristic selectedCharacteristic = SelectedCharacteristic.none;

  final GlobalKey<AnimatedCardStackState> _animatedCardStackKey =
      GlobalKey<AnimatedCardStackState>();

  @override
  void initState() {
    super.initState();

    List<GameCard> list = cardDecks[App.selectedCardDeck].cards +
        cardDecks[App.selectedCardDeck].userCreatedCards;
    list.shuffle();
    thisPlayer.numberOfCards = App.numberOfCardsMultiplayer;
    opponent.numberOfCards = App.numberOfCardsMultiplayer;
    stackUser.addAll(list.getRange(0, App.numberOfCardsMultiplayer));
    thisPlayer.isTurn = App.isBeginning;
    opponent.isTurn = !App.isBeginning;
    areButtonsEnabled = !App.isBeginning;
    isCardSelectable = App.isBeginning;
  }

  void onCardClicked(SelectedCharacteristic characteristic) {
    if (isCardSelectable) {
      setState(() {
        isCardSelectable = false;
        areButtonsEnabled = true;
        selectedCharacteristic = characteristic;
      });
    }
  }

  void keepCard() {
    setState(() {
      selectedCharacteristic = SelectedCharacteristic.none;
      opponent.numberOfCards--;
      isCardSelectable = true;
      areButtonsEnabled = false;
      stackUser.add(stackUser.removeAt(0));
      opponent.isTurn = false;
      thisPlayer.isTurn = true;
      // Player wins if the opponent(s) have 3 cards left
      if (opponent.numberOfCards == 3) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              if (points < 1) points = 1;
              return GameEndedDialog(points: points, win: true);
            });
      }
    });
  }

  void loseCard() {
    setState(() {
      selectedCharacteristic = SelectedCharacteristic.none;
      stackUser.removeAt(0);
      thisPlayer.numberOfCards--;
      thisPlayer.isTurn = false;
      opponent.isTurn = true;
      points--;
      // User loses if he has 3 cards left
      if (stackUser.length == 3) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return const GameEndedDialog(points: 0, win: false);
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
                child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              margin: const EdgeInsets.all(10),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PlayerInfoWidget(
                      player: thisPlayer,
                      height: 75,
                    ),
                    const SizedBox(width: 10),
                    const ExitButton(size: 75),
                    const SizedBox(width: 10),
                    PlayerInfoWidget(
                      player: opponent,
                      height: 75,
                    )
                  ],
                ),
                AnimatedCardStack(
                  key: _animatedCardStackKey,
                  cardStack: stackUser,
                  onCardClicked: onCardClicked,
                  isCardSelectable: isCardSelectable,
                  selectedCharacteristic: selectedCharacteristic,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        color: Colors.green,
                        disabledColor: Colors.grey,
                        height: 65,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: areButtonsEnabled
                            ? () {
                                _animatedCardStackKey.currentState!
                                    .keepCardAnimation(keepCard);
                              }
                            : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr('keepTheCard'),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const Icon(
                              Icons.navigate_next_rounded,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                        child: MaterialButton(
                      color: Colors.red,
                      disabledColor: Colors.grey,
                      height: 65,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: areButtonsEnabled
                          ? () {
                              _animatedCardStackKey.currentState!
                                  .loseCardAnimation(loseCard);
                            }
                          : null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr('loseTheCard'),
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const Icon(
                            Icons.navigate_next_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ]),
            ))
          ],
        ),
      ),
    ));
  }
}
