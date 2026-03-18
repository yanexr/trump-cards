import 'package:flutter/material.dart';
import 'package:trump_cards/gameCard/cards.dart';
import 'app.dart';
import 'settings/settingsController.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This migration updates Wikimedia thumbnail URLs from 640px to 960px in the user's saved game data.
// Todo: Remove in the future
Future<void> migrateLegacyWikimedia640pxThumbnails() async {
  const migrationDoneKey = 'migration_wikimedia_thumbnail_640_to_960_done';
  const legacyThumbnailSegment = '/640px-';
  const updatedThumbnailSegment = '/960px-';
  final prefs = await SharedPreferences.getInstance();
  if (prefs.getBool(migrationDoneKey) ?? false) {
    return;
  }

  final keysToMigrate = prefs.getKeys().where(
        (key) => key.startsWith('gameCardDeck') || key.startsWith('gameCards'),
      );

  for (final key in keysToMigrate) {
    final value = prefs.getString(key);
    if (value == null || !value.contains(legacyThumbnailSegment)) {
      continue;
    }

    await prefs.setString(
      key,
      value.replaceAll(legacyThumbnailSegment, updatedThumbnailSegment),
    );
  }

  await prefs.setBool(migrationDoneKey, true);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Load persistent data from shared preferences
  await SettingsController.instance.loadSettings();
  App.loadUserProfile();
  await migrateLegacyWikimedia640pxThumbnails();

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
          Locale('uk'), // Ukrainian
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        useOnlyLangCode: true,
        child: const App()),
  );
}
