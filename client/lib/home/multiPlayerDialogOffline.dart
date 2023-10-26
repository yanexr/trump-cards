import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../game/multiplayerOffline.dart';
import '../app.dart';
import 'multiPlayerDialog.dart';

class MultiPlayerDialogOffline extends StatefulWidget {
  const MultiPlayerDialogOffline({Key? key}) : super(key: key);

  @override
  _MultiPlayerDialogOfflineState createState() =>
      _MultiPlayerDialogOfflineState();
}

class _MultiPlayerDialogOfflineState extends State<MultiPlayerDialogOffline> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      title: Row(children: [
        const Icon(Icons.group_add_rounded),
        const SizedBox(
          width: 10,
        ),
        Text('${tr('multiplayer')} ${tr('offline')}')
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
                      tr('gameDescription4'),
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
                      tr('gameDescription5'),
                    ),
                  )
                ],
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
                    value: App.numberOfCardsMultiplayer.toDouble(),
                    min: 7,
                    max: 30,
                    divisions: 23,
                    label: App.numberOfCardsMultiplayer.toString(),
                    onChanged: (double value) {
                      setState(() {
                        App.numberOfCardsMultiplayer = value.toInt();
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
                            '30',
                            style: Theme.of(context).textTheme.bodySmall,
                          )
                        ],
                      ))),
              const Divider(height: 40),
              Center(
                child: Text(
                  tr('selectWhoBegins'),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: SegmentedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context).colorScheme.primary;
                      }
                      return Colors.black26;
                    }),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  segments: <ButtonSegment>[
                    ButtonSegment(
                      value: true,
                      label: Text(tr('you')),
                    ),
                    ButtonSegment(
                      value: false,
                      label: Text(tr('opponent')),
                    ),
                  ],
                  selected: {App.isBeginning},
                  onSelectionChanged: (Set newSelection) {
                    setState(() {
                      App.isBeginning = newSelection.first;
                    });
                  },
                ),
              )
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
                  return const MultiPlayerDialog();
                });
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
                MaterialPageRoute(builder: (context) => const MultiplayerOffline()));
          },
        ),
      ],
    );
  }
}
