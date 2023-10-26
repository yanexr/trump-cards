import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../game/singleplayer.dart';
import '../app.dart';

class SinglePlayerDialog extends StatefulWidget {
  const SinglePlayerDialog({Key? key}) : super(key: key);

  @override
  _SinglePlayerDialogState createState() => _SinglePlayerDialogState();
}

class _SinglePlayerDialogState extends State<SinglePlayerDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      title: Row(children: [
        const Icon(Icons.person),
        const SizedBox(
          width: 10,
        ),
        Text(tr('singleplayerMode'))
      ]),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Container(
          constraints: const BoxConstraints(maxWidth: 350),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(
                    child: Text(
                      tr('gameDescription1'),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(
                    child: Text(
                      tr('gameDescription2'),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(
                    child: Text(
                      tr('gameDescription3'),
                    ),
                  )
                ],
              ),
              const Divider(height: 40),
              Center(
                child: Text(
                  tr('levelOfDifficulty'),
                ),
              ),
              const SizedBox(height: 10),
              Slider(
                  value: App.difficulty,
                  min: 0,
                  max: 4,
                  divisions: 4,
                  label: (() {
                    switch (App.difficulty.toInt()) {
                      case 0:
                        return tr('easy');
                      case 1:
                        return '${tr('easy')}/${tr('medium')}';
                      case 2:
                        return tr('medium');
                      case 3:
                        return '${tr('medium')}/${tr('hard')}';
                      case 4:
                        return tr('hard');
                    }
                  }()),
                  onChanged: (double value) {
                    setState(() {
                      App.difficulty = value;
                    });
                  }),
              Container(
                transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(tr('easy'),
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(
                          tr('hard'),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    )),
              ),
              const Divider(height: 40),
              Center(
                child: Text(
                  tr('numberOfCardsPerPlayer'),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Slider(
                    value: App.numberofCardsSingleplayer.toDouble(),
                    min: 7,
                    max: 15,
                    divisions: 8,
                    label: App.numberofCardsSingleplayer.toString(),
                    onChanged: (double value) {
                      setState(() {
                        App.numberofCardsSingleplayer = value.toInt();
                      });
                    }),
              ),
              Container(
                  transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('7',
                              style: Theme.of(context).textTheme.bodySmall),
                          Text(
                            '15',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ))),
            ],
          )),
      actions: <Widget>[
        MaterialButton(
          height: 40,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(tr('cancel').toUpperCase()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          height: 40,
          color: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Text(tr('play').toUpperCase(),
                style: const TextStyle(color: Colors.white)),
            const Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
            )
          ]),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Singleplayer()));
          },
        ),
      ],
    );
  }
}
