import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.language),
              const SizedBox(width: 20),
              Text(
                tr('language'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              DropdownButton<String>(
                padding: const EdgeInsets.only(left: 10, right: 10),
                borderRadius: BorderRadius.circular(10),
                value: context.locale.toString(),
                onChanged: (value) {
                  context.setLocale(Locale(value ?? 'en'));
                },
                items: const [
                  DropdownMenuItem(
                    value: 'en',
                    child: Text('English'),
                  ),
                  DropdownMenuItem(
                    value: 'ar',
                    child: Text('Arabic'),
                  ),
                  DropdownMenuItem(
                    value: 'zh',
                    child: Text('Chinese'),
                  ),
                  DropdownMenuItem(
                    value: 'fr',
                    child: Text('French'),
                  ),
                  DropdownMenuItem(
                    value: 'de',
                    child: Text('German'),
                  ),
                  DropdownMenuItem(
                    value: 'hi',
                    child: Text('Hindi'),
                  ),
                  DropdownMenuItem(
                    value: 'ja',
                    child: Text('Japanese'),
                  ),
                  DropdownMenuItem(
                    value: 'ko',
                    child: Text('Korean'),
                  ),
                  DropdownMenuItem(
                    value: 'pt',
                    child: Text('Portuguese'),
                  ),
                  DropdownMenuItem(
                    value: 'ru',
                    child: Text('Russian'),
                  ),
                  DropdownMenuItem(
                    value: 'es',
                    child: Text('Spanish'),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
