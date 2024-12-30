import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/game/cardComparisonView.dart';
import 'package:trump_cards/gameCard/animatedCardStack.dart';
import 'package:trump_cards/gameCard/measurementUnits.dart';
import 'gameEndedDialog.dart';
import 'playerInfo.dart';
import '../game/exitButton.dart';
import '../app.dart';
import '../gameCard/cards.dart';

class Singleplayer extends StatefulWidget {
  const Singleplayer({super.key});

  @override
  _SingleplayerState createState() => _SingleplayerState();
}

class _SingleplayerState extends State<Singleplayer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  late List<GameCard> stackUser = [];
  late List<GameCard> stackComputer = [];
  late Player thisPlayer;
  late Player opponent;

  Color selectionColor = Colors.green;
  int points = App.numberofCardsSingleplayer * 2;
  bool isButtonEnabled = false;
  bool isCardSelectable = true;
  int selectedCharacteristic = -1; // -1 means none selected
  bool userWinsRound = true;

  late List<num> averages = [];

  final GlobalKey<AnimatedCardStackState> _animatedCardStackKey =
      GlobalKey<AnimatedCardStackState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final deck = App.selectedCardDeck!;
    List<GameCard> list = deck.cards;
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

    // Compute averages for each characteristic
    int totalCards = App.numberofCardsSingleplayer * 2;
    averages = List.filled(deck.characteristics.length, 0);
    for (GameCard g in stackUser) {
      for (int i = 0; i < g.values.length; i++) {
        averages[i] += g.values[i];
      }
    }
    for (GameCard g in stackComputer) {
      for (int i = 0; i < g.values.length; i++) {
        averages[i] += g.values[i];
      }
    }
    for (int i = 0; i < averages.length; i++) {
      averages[i] = averages[i] / totalCards;
    }
  }

  void onCardClicked(int characteristicIndex) {
    if (isCardSelectable) {
      setState(() {
        _animationController.forward();
        isCardSelectable = false;
        isButtonEnabled = true;
        selectedCharacteristic = characteristicIndex;

        final deck = App.selectedCardDeck!;
        final isHigherBetter =
            deck.characteristics[characteristicIndex].isHigherBetter;
        final userVal = stackUser[0].values[characteristicIndex];
        final compVal = stackComputer[0].values[characteristicIndex];

        userWinsRound = ((userVal > compVal) == isHigherBetter);

        selectionColor = userWinsRound ? Colors.green : Colors.red;
        if (!userWinsRound) {
          points--;
        }
      });
    }
  }

  void keepCard() {
    setState(() {
      selectedCharacteristic = -1;
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
      selectedCharacteristic = -1;
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
        // bot selects next characteristic
        isCardSelectable = true;
        int cIndex;
        switch (App.difficulty) {
          case 0:
            cIndex = findLosingProperty();
            break;
          case 1:
            cIndex = findRandomProperty();
            break;
          case 2:
            cIndex =
                Random().nextBool() ? findBestProperty() : findRandomProperty();
            break;
          case 3:
            cIndex = findBestProperty();
            break;
          case 4:
            cIndex = findWinningProperty();
            break;
          default:
            cIndex = findRandomProperty();
        }
        onCardClicked(cIndex);
      }
    });
  }

  int findBestProperty() {
    final deck = App.selectedCardDeck!;
    final c = stackComputer[0];
    final valuesC = c.values;

    num maxRatio = -1;
    int bestIndex = 0;

    for (int i = 0; i < valuesC.length; i++) {
      final characteristic = deck.characteristics[i];
      final val = valuesC[i];
      final avg = averages[i];
      num p = characteristic.isHigherBetter ? (val / avg) : (avg / val);
      if (p > maxRatio) {
        maxRatio = p;
        bestIndex = i;
      }
    }
    return bestIndex;
  }

  int findWinningProperty() {
    final deck = App.selectedCardDeck!;
    final c = stackComputer[0];
    final u = stackUser[0];
    final valuesC = c.values;
    final valuesU = u.values;

    for (int i = 0; i < valuesC.length; i++) {
      final isHigherBetter = deck.characteristics[i].isHigherBetter;
      if (isHigherBetter && valuesC[i] > valuesU[i]) {
        return i;
      } else if (!isHigherBetter && valuesC[i] < valuesU[i]) {
        return i;
      }
    }
    return findRandomProperty();
  }

  int findLosingProperty() {
    final deck = App.selectedCardDeck!;
    final c = stackComputer[0];
    final u = stackUser[0];
    final valuesC = c.values;
    final valuesU = u.values;

    for (int i = 0; i < valuesC.length; i++) {
      final isHigherBetter = deck.characteristics[i].isHigherBetter;
      if (isHigherBetter && valuesC[i] < valuesU[i]) {
        return i;
      } else if (!isHigherBetter && valuesC[i] > valuesU[i]) {
        return i;
      }
    }
    return findRandomProperty();
  }

  int findRandomProperty() {
    final deck = App.selectedCardDeck!;
    List<int> indices = List.generate(deck.characteristics.length, (i) => i);
    indices.shuffle();
    return indices.first;
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
    final deck = App.selectedCardDeck!;
    if (selectedCharacteristic == -1 || stackComputer.isEmpty) {
      return const TextSpan(text: '');
    }

    final i = selectedCharacteristic;
    final v = stackComputer[0].values[i];
    final m = deck.characteristics[i].measurementType;

    return Measurements.getValueAndUnit(v, m);
  }

  @override
  Widget build(BuildContext context) {
    final deck = App.selectedCardDeck!;
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
                stackComputer.isNotEmpty
                    ? SizedBox(
                        height: 80,
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                scale: animation, child: child);
                          },
                          child: isCardSelectable
                              ? Padding(
                                  key: ValueKey<String>(
                                      'secondChild-${opponent.numberOfCards}'),
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    tr('Your turn! Select an attribute.'),
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : TextButton(
                                  key: ValueKey<String>(
                                      'firstChild-${opponent.numberOfCards}'),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CardComparisonView(
                                                    firstCard: stackComputer[0],
                                                    secondCard: stackUser[0])));
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.surface,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    foregroundColor:
                                        Theme.of(context).colorScheme.onSurface,
                                    overlayColor: Colors.transparent,
                                  ),
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 500),
                                    padding: const EdgeInsets.all(11),
                                    child: Row(
                                      children: [
                                        // Rounded image on the left
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: selectionColor,
                                              width: 4,
                                            ),
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(180),
                                            child: SizedBox.fromSize(
                                              child: !stackComputer[0]
                                                      .imagePath
                                                      .startsWith('http')
                                                  ? Image.asset(
                                                      'assets/images/${deck.name}/${stackComputer[0].imagePath}',
                                                      fit: BoxFit.cover,
                                                      height: 50,
                                                      width: 50,
                                                    )
                                                  : Image.network(
                                                      stackComputer[0]
                                                          .imagePath,
                                                      fit: BoxFit.cover,
                                                      height: 50,
                                                      width: 50,
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object exception,
                                                              StackTrace?
                                                                  stackTrace) {
                                                        return Image.asset(
                                                            'assets/images/placeholder.png',
                                                            fit: BoxFit.cover,
                                                            height: 50,
                                                            width: 50);
                                                      },
                                                    ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        // Text in the middle
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  AutoSizeText(
                                                    userWinsRound
                                                        ? tr('youWonAgainst')
                                                        : tr('youLostAgainst'),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                                    maxLines: 1,
                                                    minFontSize: 8,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  AutoSizeText.rich(
                                                    TextSpan(
                                                      text:
                                                          stackComputer[0].name,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        height: 1.2,
                                                      ),
                                                      children: [
                                                        const TextSpan(
                                                            text: ' ('),
                                                        getSelectedCharacteristicValueOpponent(),
                                                        const TextSpan(
                                                            text: ')'),
                                                      ],
                                                    ),
                                                    maxLines: 2,
                                                    minFontSize: 10,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        // continue button on the right
                                        TextButton(
                                          onPressed: () {
                                            if (isButtonEnabled) {
                                              nextCard();
                                            }
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            minimumSize: const Size(96, 64),
                                          ),
                                          child: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ))
                    : const SizedBox(
                        height: 0,
                      ),
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
