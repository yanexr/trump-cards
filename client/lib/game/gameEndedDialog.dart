import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app.dart';

class GameEndedDialog extends StatefulWidget {
  final int points;
  final bool win;
  const GameEndedDialog({Key? key, required this.points, required this.win})
      : super(key: key);

  @override
  _GameEndedDialogState createState() => _GameEndedDialogState();
}

class _GameEndedDialogState extends State<GameEndedDialog> {
  bool isHighscore = false;
  @override
  void initState() {
    super.initState();
    if (widget.points > App.pointsHighest) {
      isHighscore = true;
      App.pointsHighest = widget.points;
    }
    App.pointsTotal += widget.points;
    if (widget.win) {
      App.wins++;
    } else {
      App.losses++;
    }
    App.updateGameStats();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          scrollable: true,
          actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          content: Column(
            children: [
              Image.asset(
                  widget.win
                      ? 'assets/images/trophy.webp'
                      : 'assets/images/game-over.png',
                  height: 200,
                  fit: BoxFit.cover),
                Text(
                  widget.win
                    ? tr('youWon').toUpperCase()
                    : tr('youLost').toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                  )),
              const SizedBox(height: 10),
              Text('${tr('points')}: ${widget.points}'),
              const SizedBox(height: 5),
              isHighscore
                  ? Text(tr('newHighscore').toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ))
                  : Text('(${tr('highscore')}: ${App.pointsHighest})'),
              const SizedBox(height: 30),
              MaterialButton(
                height: 40,
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  tr('mainMenu'),
                  style: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/',
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            ],
          ),
        ));
  }
}
