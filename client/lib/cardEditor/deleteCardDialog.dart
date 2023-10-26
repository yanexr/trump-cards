import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class DeleteCardDialog extends StatelessWidget {
  final Function deleteCard;
  const DeleteCardDialog(
      {Key? key, required this.deleteCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      title: Text(tr('deleteCard')),
      content: Text(tr('deleteCardMessage')),
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
            deleteCard();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
