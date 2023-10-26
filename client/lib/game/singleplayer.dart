import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/gameCard/animatedCardStack.dart';
import 'package:trump_cards/gameCard/measurementUnits.dart';
import 'gameEndedDialog.dart';
import 'playerInfo.dart';
import '../game/exitButton.dart';
import '../gameCard/gameCardWidget.dart';
import '../app.dart';
import '../data/cardDecks.dart';
import '../gameCard/cards.dart';

class Singleplayer extends StatefulWidget {
  @override
  _SingleplayerState createState() => _SingleplayerState();
}

class _SingleplayerState extends State<Singleplayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late List<GameCard> stackUser = [];
  late List<GameCard> stackComputer = [];
  late Player thisPlayer;
  late Player opponent;

  Color selectionColor = Colors.green;
  int points = App.numberofCardsSingleplayer * 2;
  bool isButtonEnabled = false;
  bool isCardSelectable = true;
  SelectedCharacteristic selectedCharacteristic = SelectedCharacteristic.none;
  bool userWinsRound = true;

  late num averageV1 = 0;
  late num averageV2 = 0;
  late num averageV3 = 0;
  late num averageV4 = 0;
  late num averageV5 = 0;

  final GlobalKey<AnimatedCardStackState> _animatedCardStackKey =
      GlobalKey<AnimatedCardStackState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.decelerate));

    List<GameCard> list = cardDecks[App.selectedCardDeck].cards +
        cardDecks[App.selectedCardDeck].userCreatedCards;
    list.shuffle();
    stackUser.addAll(list.getRange(0, App.numberofCardsSingleplayer));
    stackComputer.addAll(list.getRange(
        App.numberofCardsSingleplayer, App.numberofCardsSingleplayer * 2));
    thisPlayer = Player(
        name: App.username, isTurn: true, numberOfCards: stackUser.length);
    opponent = Player(
        name: tr('computer'),
        isTurn: false,
        numberOfCards: stackComputer.length);

    for (GameCard g in stackUser + stackComputer) {
      averageV1 += g.value1;
      averageV2 += g.value2;
      averageV3 += g.value3;
      averageV4 += g.value4;
      averageV5 += g.value5;
    }
    averageV1 = averageV1 / (App.numberofCardsSingleplayer * 2);
    averageV2 = averageV2 / (App.numberofCardsSingleplayer * 2);
    averageV3 = averageV3 / (App.numberofCardsSingleplayer * 2);
    averageV4 = averageV4 / (App.numberofCardsSingleplayer * 2);
    averageV5 = averageV5 / (App.numberofCardsSingleplayer * 2);
  }

  void onCardClicked(SelectedCharacteristic characteristic) {
    if (isCardSelectable) {
      setState(() {
        _animationController.forward();
        isCardSelectable = false;
        isButtonEnabled = true;
        selectedCharacteristic = characteristic;

        switch (characteristic) {
          case SelectedCharacteristic.v1:
            if (!((stackUser[0].value1 > stackComputer[0].value1) ^
                cardDecks[App.selectedCardDeck].c1.isHigherBetter)) {
              userWinsRound = true;
            } else {
              userWinsRound = false;
            }
            break;
          case SelectedCharacteristic.v2:
            if (!((stackUser[0].value2 > stackComputer[0].value2) ^
                cardDecks[App.selectedCardDeck].c2.isHigherBetter)) {
              userWinsRound = true;
            } else {
              userWinsRound = false;
            }
            break;
          case SelectedCharacteristic.v3:
            if (!((stackUser[0].value3 > stackComputer[0].value3) ^
                cardDecks[App.selectedCardDeck].c3.isHigherBetter)) {
              userWinsRound = true;
            } else {
              userWinsRound = false;
            }
            break;
          case SelectedCharacteristic.v4:
            if (!((stackUser[0].value4 > stackComputer[0].value4) ^
                cardDecks[App.selectedCardDeck].c4.isHigherBetter)) {
              userWinsRound = true;
            } else {
              userWinsRound = false;
            }
            break;
          case SelectedCharacteristic.v5:
            if (!((stackUser[0].value5 > stackComputer[0].value5) ^
                cardDecks[App.selectedCardDeck].c5.isHigherBetter)) {
              userWinsRound = true;
            } else {
              userWinsRound = false;
            }
            break;
          default:
            userWinsRound = true;
        }

        if (userWinsRound) {
          selectionColor = Colors.green;
        } else {
          selectionColor = Colors.red;
          points--;
        }
      });
    }
  }

  void keepCard() {
    setState(() {
      selectedCharacteristic = SelectedCharacteristic.none;
      stackUser.add(stackUser.removeAt(0));
      stackUser.add(stackComputer.removeAt(0));
      thisPlayer.isTurn = true;
      opponent.isTurn = false;
      isCardSelectable = true;
      thisPlayer.numberOfCards++;
      opponent.numberOfCards--;
      // Player wins if the opponent has 0 cards left
      if (opponent.numberOfCards == 0) {
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
      stackComputer.add(stackComputer.removeAt(0));
      stackComputer.add(stackUser.removeAt(0));
      thisPlayer.isTurn = false;
      opponent.isTurn = true;
      isCardSelectable = false;
      opponent.numberOfCards++;
      thisPlayer.numberOfCards--;
      // User loses if he has 0 cards left
      if (stackUser.isEmpty) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) {
              return const GameEndedDialog(points: 0, win: false);
            });
      } else {
        // bot select next characteristic
        isCardSelectable = true;
        var random = Random();
        switch (App.difficulty) {
          case 0:
            selectedCharacteristic = findLosingProperty();
            break;
          case 1:
            selectedCharacteristic = findRandomProperty();
            break;
          case 2:
            selectedCharacteristic =
                random.nextBool() ? findBestProperty() : findRandomProperty();
            break;
          case 3:
            selectedCharacteristic = findBestProperty();
            break;
          case 4:
            selectedCharacteristic = findWinningProperty();
            break;
          default:
        }
        onCardClicked(selectedCharacteristic);
      }
    });
  }

  SelectedCharacteristic findBestProperty() {
    GameCard c = stackComputer[0];
    List<num> values = [c.value1, c.value2, c.value3, c.value4, c.value5];
    List<num> averages = [
      averageV1,
      averageV2,
      averageV3,
      averageV4,
      averageV5
    ];
    List<bool> g = [
      cardDecks[App.selectedCardDeck].c1.isHigherBetter,
      cardDecks[App.selectedCardDeck].c2.isHigherBetter,
      cardDecks[App.selectedCardDeck].c3.isHigherBetter,
      cardDecks[App.selectedCardDeck].c4.isHigherBetter,
      cardDecks[App.selectedCardDeck].c5.isHigherBetter
    ];
    List<int> valueIndices = [0, 1, 2, 3, 4];
    valueIndices.shuffle();

    num max = 0;
    int index = 0;
    for (int i = 0; i < values.length; i++) {
      num p;
      if (g[i]) {
        p = values[i] / averages[i];
      } else {
        p = averages[i] / values[i];
      }
      if (p > max) {
        max = p;
        index = i;
      }
    }
    return SelectedCharacteristic.values[index];
  }

  SelectedCharacteristic findWinningProperty() {
    GameCard c = stackComputer[0];
    GameCard u = stackUser[0];
    List<num> valuesC = [c.value1, c.value2, c.value3, c.value4, c.value5];
    List<num> valuesU = [u.value1, u.value2, u.value3, u.value4, u.value5];
    List<bool> g = [
      cardDecks[App.selectedCardDeck].c1.isHigherBetter,
      cardDecks[App.selectedCardDeck].c2.isHigherBetter,
      cardDecks[App.selectedCardDeck].c3.isHigherBetter,
      cardDecks[App.selectedCardDeck].c4.isHigherBetter,
      cardDecks[App.selectedCardDeck].c5.isHigherBetter
    ];

    for (int i = 0; i < valuesC.length; i++) {
      if (g[i]) {
        if (valuesC[i] > valuesU[i]) {
          return SelectedCharacteristic.values[i];
        }
      } else {
        if (valuesC[i] < valuesU[i]) {
          return SelectedCharacteristic.values[i];
        }
      }
    }
    return findRandomProperty();
  }

  SelectedCharacteristic findLosingProperty() {
    GameCard c = stackComputer[0];
    GameCard u = stackUser[0];
    List<num> valuesC = [c.value1, c.value2, c.value3, c.value4, c.value5];
    List<num> valuesU = [u.value1, u.value2, u.value3, u.value4, u.value5];
    List<bool> g = [
      cardDecks[App.selectedCardDeck].c1.isHigherBetter,
      cardDecks[App.selectedCardDeck].c2.isHigherBetter,
      cardDecks[App.selectedCardDeck].c3.isHigherBetter,
      cardDecks[App.selectedCardDeck].c4.isHigherBetter,
      cardDecks[App.selectedCardDeck].c5.isHigherBetter
    ];

    for (int i = 0; i < valuesC.length; i++) {
      if (g[i]) {
        if (valuesC[i] < valuesU[i]) {
          return SelectedCharacteristic.values[i];
        }
      } else {
        if (valuesC[i] > valuesU[i]) {
          return SelectedCharacteristic.values[i];
        }
      }
    }
    return findRandomProperty();
  }

  SelectedCharacteristic findRandomProperty() {
    List<SelectedCharacteristic> list = [
      SelectedCharacteristic.v1,
      SelectedCharacteristic.v2,
      SelectedCharacteristic.v3,
      SelectedCharacteristic.v4,
      SelectedCharacteristic.v5
    ];
    list.shuffle();
    return list[0];
  }

  void nextCard() {
    setState(() {
      isButtonEnabled = false;
      _animationController.reverse();
    });
    if (userWinsRound) {
      _animatedCardStackKey.currentState!.keepAndGetCardAnimation(() {
        keepCard();
      }, stackComputer[0]);
    } else {
      _animatedCardStackKey.currentState!.loseCardAnimation(() {
        loseCard();
      });
    }
  }

  TextSpan getSelectedCharacteristicValueOpponent() {
    num v = 0;
    MeasurementType m;
    switch (selectedCharacteristic) {
      case SelectedCharacteristic.v1:
        v = stackComputer[0].value1;
        m = cardDecks[App.selectedCardDeck].c1.measurementType;
      case SelectedCharacteristic.v2:
        v = stackComputer[0].value2;
        m = cardDecks[App.selectedCardDeck].c2.measurementType;
      case SelectedCharacteristic.v3:
        v = stackComputer[0].value3;
        m = cardDecks[App.selectedCardDeck].c3.measurementType;
      case SelectedCharacteristic.v4:
        v = stackComputer[0].value4;
        m = cardDecks[App.selectedCardDeck].c4.measurementType;
      case SelectedCharacteristic.v5:
        v = stackComputer[0].value5;
        m = cardDecks[App.selectedCardDeck].c5.measurementType;
      default:
        v = 0;
        m = cardDecks[App.selectedCardDeck].c1.measurementType;
    }

    return Measurements.getValueAndUnit(v, m);
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
              constraints: const BoxConstraints(maxWidth: 500),
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
                  selectionColor: selectionColor,
                ),
                
                FadeTransition(
                  opacity: _animation,
                  child: stackComputer.isNotEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: selectionColor,
                                  width: 4,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(180),
                                child: SizedBox.fromSize(
                                  child: stackComputer[0].id > 0
                                      ? Image.asset(
                                          'assets/images/${cardDecks[App.selectedCardDeck].name}/${stackComputer[0].imagePath}',
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50,
                                        )
                                      : Image.network(
                                          stackComputer[0].imagePath,
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50, errorBuilder:
                                              (BuildContext context,
                                                  Object exception,
                                                  StackTrace? stackTrace) {
                                          return Image.asset(
                                              'assets/images/placeholder.png',
                                              fit: BoxFit.cover,
                                              height: 50,
                                              width: 50);
                                        }),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text.rich(
                              TextSpan(
                                text: (userWinsRound
                                    ? '${tr('youWonAgainst')}\n'
                                    : '${tr('youLostAgainst')}\n'),
                                style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                ),
                                children: [
                                  TextSpan(
                                      text: stackComputer[0].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          height: 1.5),
                                      children: [
                                        const TextSpan(text: ' ('),
                                        getSelectedCharacteristicValueOpponent(),
                                        const TextSpan(text: ')'),
                                      ]),
                                ],
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(
                          height: 0,
                        ),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  disabledColor: Colors.grey,
                  height: 50,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: isButtonEnabled
                      ? () {
                          nextCard();
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tr('nextCard'),
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
                )
              ]),
            ))
          ],
        ),
      ),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
