import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../settings/settingsController.dart';

class ThemeDropdown extends StatelessWidget {
  const ThemeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const Icon(Icons.brightness_4_rounded),
              const SizedBox(width: 20),
              
              Text(
                tr('appearance'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              DropdownButton<ThemeMode>(
                padding: const EdgeInsets.only(left: 10, right: 10),
                borderRadius: BorderRadius.circular(10),
                value: SettingsController.instance.themeMode,
                onChanged: SettingsController.instance.updateThemeMode,
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(tr('systemTheme'), overflow: TextOverflow.ellipsis),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(tr('lightTheme'),),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(tr('darkTheme')),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
