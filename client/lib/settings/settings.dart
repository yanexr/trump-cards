import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../settings/UnitsDropdown.dart';
import '../settings/languageDropdown.dart';
import '../settings/themeDropdown.dart';
import 'settingsController.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(tr('settings')),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: const  Column(
                      children: [
                        ThemeDropdown(),
                        LanguageDropdown(),
                        UnitsDropdown(),
                        SizedBox(height: 20),
                      ],
                    )))));
  }
}
