import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../home/connectDialog.dart';
import '../app.dart';
import 'multiPlayerDialog.dart';

class MultiPlayerDialogOnline extends StatefulWidget {
  const MultiPlayerDialogOnline({Key? key}) : super(key: key);

  @override
  _MultiPlayerDialogOnline createState() => _MultiPlayerDialogOnline();
}

class _MultiPlayerDialogOnline extends State<MultiPlayerDialogOnline> {
  @override
  void initState() {
    super.initState();
    App.gameCode = '';
  }

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
        Text('${tr('multiplayer')} ${tr('online')}')
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
                      tr('gameDescription6'),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                tr('enterGameCode'),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 5,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: tr('gameCode'),
                      ),
                      onChanged: (value) {
                        setState(() {
                          App.gameCode = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  MaterialButton(
                    height: 60,
                    color: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    child: Text(tr('join').toUpperCase(),
                        style: const TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (App.gameCode.length == 5) {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (_) {
                              return const ConnectDialog();
                            });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            tr('wrongGameCode'),
                            style: const TextStyle(color: Colors.white),
                          ),
                          duration: const Duration(seconds: 3),
                        ));
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                tr('createNewGameDescription'),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                height: 40,
                color: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(tr('createNewGame').toUpperCase(),
                    style: const TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pop();
                  App.gameCode = '';
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const ConnectDialog();
                      });
                },
              ),
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
      ],
    );
  }
}
