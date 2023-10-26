import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../gameCard/cards.dart';
import '../gameCard/gameCardBack.dart';
import 'gameCardFront.dart';


enum SelectedCharacteristic { v1, v2, v3, v4, v5, none }

/// Displays a list of SampleItems.
class GameCardWidget extends StatefulWidget {
  final GameCard gameCard;
  final bool isSelectable;
  final SelectedCharacteristic selectedCharacteristic;
  final Color selectionColor;
  final Function(SelectedCharacteristic) onClick;
  final bool elevation;

  const GameCardWidget(
      {super.key,
      required this.gameCard,
      this.isSelectable = false,
      this.selectedCharacteristic = SelectedCharacteristic.none,
      this.selectionColor = Colors.blue,
      this.onClick = _doNothing,
      this.elevation = true});

  static void _doNothing(SelectedCharacteristic s) {}

  @override
  _GameCardWidgetState createState() => _GameCardWidgetState();
}

class _GameCardWidgetState extends State<GameCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
  }

  void flipCard() {
    if (!_animationController.isAnimating) {
      if (_animationController.value < .5) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Align(
            child: AnimatedBuilder(
      animation: _animationController,
      builder: ((context, child) {
        return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // add a small perspective effect
              ..rotateY(3.14159 * _animation.value), // rotate around the Y-axis
            alignment: Alignment.center,
            child: _animationController.value < .5
                ? GameCardFront(
                    gameCard: widget.gameCard,
                    flipCard: flipCard,
                    isSelectable: widget.isSelectable,
                    selectedCharacteristic: widget.selectedCharacteristic,
                    selectionColor: widget.selectionColor,
                    onClick: widget.onClick,
                    elevation: widget.elevation,
                  )
                : Transform.flip(
                    flipX: true,
                    child: GameCardBack(
                        gameCard: widget.gameCard, flipCard: flipCard, elevation: widget.elevation, languageCode: context.locale.languageCode)));
      }),
    )));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
