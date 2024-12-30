import 'package:flutter/material.dart';

class Player {
  String name;
  int numberOfCards;
  bool isTurn;
  Player({required this.name, this.numberOfCards = 0, this.isTurn = false});
}

class PlayerInfoWidget extends StatefulWidget {
  final Player player;
  final double height;
  final Function? send;

  const PlayerInfoWidget(
      {super.key, required this.player, required this.height, this.send});

  @override
  _PlayerInfoWidgetState createState() => _PlayerInfoWidgetState();
}

class _PlayerInfoWidgetState extends State<PlayerInfoWidget> {
  late bool includeSendButton;
  @override
  void initState() {
    super.initState();
    includeSendButton = widget.send != null;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: widget.height,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: widget.player.isTurn
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
                width: widget.player.isTurn ? 5 : 0,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const RotatedBox(quarterTurns: 2, child: Icon(Icons.style)),
                    const SizedBox(width: 5),
                    Text(widget.player.numberOfCards.toString())
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  widget.player.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          includeSendButton
              ? MaterialButton(
                  color: Theme.of(context).colorScheme.primary,
                  disabledColor: Colors.grey,
                  height: 40,
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: widget.player.numberOfCards > 0
                      ? () {
                          widget.send!(widget.player.name);
                        }
                      : null,
                  child: const RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ))
              : const SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }
}
