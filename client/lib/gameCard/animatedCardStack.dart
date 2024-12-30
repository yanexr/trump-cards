import 'package:flutter/material.dart';
import 'package:indexed/indexed.dart';
import 'package:trump_cards/app.dart';

import 'cards.dart';
import 'gameCardWidget.dart';

class AnimatedCardStack extends StatefulWidget {
  final List<GameCard> cardStack;
  final bool isCardSelectable;
  final int selectedCharacteristic;
  final Color selectionColor;
  final Function(int) onCardClicked;
  final GameCardDeck? deck;

  const AnimatedCardStack(
      {super.key,
      required this.cardStack,
      this.isCardSelectable = false,
      this.selectedCharacteristic = -1,
      this.selectionColor = Colors.blue,
      this.onCardClicked = _doNothing,
      this.deck});

  static void _doNothing(int s) {}

  @override
  AnimatedCardStackState createState() => AnimatedCardStackState();
}

class AnimatedCardStackState extends State<AnimatedCardStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  int animationType = 0;
  int cardZIndex = 1;
  Curve curve = Curves.easeOutSine;
  GameCard? newCard;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _animationController, curve: curve));
  }

  void keepCardAnimation(Function whenComplete) {
    animationType = 0;
    _animationController.duration = const Duration(milliseconds: 300);
    _animationController.forward().whenComplete(() {
      setState(() {
        cardZIndex = -1;
      });
      _animationController.reverse().whenComplete(() {
        whenComplete();
        setState(() {
          cardZIndex = 1;
        });
      });
    });
  }

  void keepAndGetCardAnimation(Function whenComplete, GameCard newCard) {
    animationType = 0;
    _animationController.duration = const Duration(milliseconds: 300);
    _animationController.forward().whenComplete(() {
      setState(() {
        cardZIndex = -1;
      });
      _animationController.reverse().whenComplete(() {
        // start animation of pushing new card on stack
        setState(() {
          this.newCard = newCard;
        });
        animationType = 1;
        _animationController.duration = const Duration(milliseconds: 400);
        curve = Curves.easeInQuint;
        _animationController.reverse(from: 1).whenComplete(() {
          _animationController.reset();
          whenComplete();
          setState(() {
            this.newCard = null;
            cardZIndex = 1;
          });
          curve = Curves.easeOutSine;
        });
      });
    });
  }

  void loseCardAnimation(Function whenComplete) {
    animationType = 1;
    _animationController.duration = const Duration(milliseconds: 500);
    _animationController.forward().whenComplete(() {
      _animationController.reset();
      whenComplete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AnimatedBuilder(
      animation: _animationController,
      builder: ((context, child) {
        return Indexer(children: [
          Indexed(
              index: cardZIndex,
              child: Column(
                children: [
                  Expanded(
                      child: Transform(
                          transform: Matrix4.identity()
                            ..translate(
                                _animation.value *
                                    (animationType == 0 ? 500 : 400),
                                _animation.value * animationType * -400,
                                0.0)
                            ..scale(
                                1 - (_animation.value * animationType * 0.3),
                                1 - (_animation.value * animationType * 0.3))
                            ..setEntry(3, 2, 0.0001)
                            ..rotateX(_animation.value * animationType * -1),
                          alignment: Alignment.topCenter,
                          child: Column(children: [
                            widget.cardStack.isNotEmpty
                                ? GameCardWidget(
                                    gameCard: newCard ?? widget.cardStack[0],
                                    onClick: widget.onCardClicked,
                                    isSelectable: widget.isCardSelectable,
                                    selectedCharacteristic:
                                        widget.selectedCharacteristic,
                                    selectionColor: widget.selectionColor,
                                    elevation: false,
                                    deck: widget.deck ?? App.selectedCardDeck,
                                  )
                                : const SizedBox(height: 0)
                          ]))),
                ],
              )),
          Indexed(
              index: 0,
              child: Column(children: [
                widget.cardStack.length > 1
                    ? GameCardWidget(
                        gameCard: widget.cardStack[1],
                        deck: widget.deck ?? App.selectedCardDeck,
                      )
                    : const SizedBox(height: 0)
              ])),
        ]);
      }),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
