import 'package:flutter/material.dart';
import 'package:trump_cards/gameCard/cards.dart';
import 'app.dart';
import 'settings/settingsController.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Load persistent data from shared preferences
  await SettingsController.instance.loadSettings();
  App.loadUserProfile();
  
  App.selectedCardDeck = await loadGameCardDeck('assets/carddecks/cars.json');
  App.selectedCardDeck!.addUserCreatedCards();

  runApp(
    EasyLocalization(
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'), // Arabic
          Locale('zh'), // Chinese
          Locale('fr'), // French
          Locale('de'), // German
          Locale('hi'), // Hindi
          Locale('it'), // Italian
          Locale('ja'), // Japanese
          Locale('ko'), // Korean
          Locale('pt'), // Portuguese
          Locale('ru'), // Russian
          Locale('es'), // Spanish
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: const App()),
  );
}
