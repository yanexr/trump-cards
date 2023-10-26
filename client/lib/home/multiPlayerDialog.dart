import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../app.dart';
import 'multiPlayerDialogOffline.dart';
import 'multiPlayerDialogOnline.dart';

class MultiPlayerDialog extends StatefulWidget {
  const MultiPlayerDialog({Key? key}) : super(key: key);

  @override
  _MultiPlayerDialogState createState() => _MultiPlayerDialogState();
}

class _MultiPlayerDialogState extends State<MultiPlayerDialog> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = App.username;
    return AlertDialog(
      scrollable: true,
      actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      title: Row(children: [
        const Icon(Icons.group_add_rounded),
        const SizedBox(
          width: 10,
        ),
        Text(tr('multiplayerMode'))
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
              const SizedBox(height: 10),
              TextField(
                maxLength: 8,
                controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: tr('username'),
                ),
                onChanged: (value) {
                  App.username = value;
                  App.updateUsername();
                },
              ),
              const Divider(),
              const SizedBox(height: 20),
              Text(tr('onlineOrOffline')),
              const SizedBox(height: 10),
              MaterialButton(
                height: 50,
                color: Theme.of(context).colorScheme.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.wifi_off_rounded, size: 20),
                        const SizedBox(width: 10),
                        Text(tr('offline')),
                      ]),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                      )
                    ]),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const MultiPlayerDialogOffline();
                      });
                },
              ),
              const SizedBox(height: 10),
              MaterialButton(
                height: 50,
                color: Theme.of(context).colorScheme.background,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(Icons.wifi_rounded, size: 20),
                        const SizedBox(width: 10),
                        Text(tr('online')),
                      ]),
                      const Icon(Icons.arrow_forward_ios_rounded, size: 18)
                    ]),
                onPressed: () {
                  Navigator.of(context).pop();
                  showDialog(
                      context: context,
                      builder: (_) {
                        return const MultiPlayerDialogOnline();
                      });
                },
              ),
            ],
          )),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
