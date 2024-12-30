import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NotEnoughCardsDialog extends StatelessWidget {
  const NotEnoughCardsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
      contentPadding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: const Text("8+"),
      content: Text(
        tr('notEnoughCards', args: ['8']),
      ),
    );
  }
}
