import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DeleteDialog extends StatelessWidget {
  final Function deleteFunction;
  final String name;
  final String title;
  const DeleteDialog(
      {Key? key,
      required this.deleteFunction,
      required this.name,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      title: Text(title),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(tr('Are you sure you want to delete the following:')),
        const SizedBox(height: 10),
        Text("'$name'", style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
      ]),
      actions: [
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
            Text(tr('delete').toUpperCase(),
                style: const TextStyle(color: Colors.white)),
            const Icon(
              Icons.delete_rounded,
              color: Colors.white,
            )
          ]),
          onPressed: () {
            deleteFunction();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
