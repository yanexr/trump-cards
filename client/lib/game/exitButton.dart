import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ExitButton extends StatelessWidget {
  final double size;
  const ExitButton({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10)),
      child: IconButton(
        icon: const Icon(Icons.exit_to_app_rounded),
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) {
                return const ExitDialog();
              });
        },
      ),
    );
  }
}

class ExitDialog extends StatelessWidget {
  const ExitDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      title: Row(children: [
        const Icon(Icons.exit_to_app_rounded),
        const SizedBox(
          width: 10,
        ),
        Text(tr('exitGame'))
      ]),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Text(tr('exitGameMessage')),
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
          child: Text(tr('exit').toUpperCase(),
              style: const TextStyle(color: Colors.white)),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/',
              (Route<dynamic> route) => false,
            );
          },
        ),
      ],
    );
  }
}
