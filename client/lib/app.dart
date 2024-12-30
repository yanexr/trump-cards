import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:trump_cards/editor/cardDeckEditor.dart';
import 'package:trump_cards/gameCard/cardDeckLibrary.dart';
import 'package:trump_cards/gameCard/cards.dart';

import 'gameCard/gameCardBack.dart';
import 'home/home.dart';
import 'editor/cardEditor.dart';
import 'about.dart';
import 'settings/settingsController.dart';
import 'settings/settings.dart';
import 'statistics.dart';
import 'viewCards/viewCards.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  static double difficulty = 2;
  static int numberOfCardsMultiplayer = 15;
  static int numberofCardsSingleplayer = 11;
  static bool isBeginning = false;
  static String gameCode = '';
  static GameCardDeck? selectedCardDeck;
  static Map<String, WikipediaArticle> wikipediaCache = {};

  // persistent user data
  static String username = 'player1';
  static int pointsTotal = 0;
  static int pointsHighest = 0;
  static int wins = 0;
  static int losses = 0;

  static Future<void> loadUserProfile() async {
    // load persistent user data from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username') ?? 'player1';
    pointsTotal = prefs.getInt('points') ?? 0;
    pointsHighest = prefs.getInt('highscore') ?? 0;
    wins = prefs.getInt('wonGames') ?? 0;
    losses = prefs.getInt('lostGames') ?? 0;
  }

  static Future<void> updateUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', username);
  }

  static Future<void> updateGameStats() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('points', pointsTotal);
    prefs.setInt('highscore', pointsHighest);
    prefs.setInt('wonGames', wins);
    prefs.setInt('lostGames', losses);
  }

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ).copyWith(
      primary: Colors.blue,
      onPrimary: Colors.white,
      surface: Colors.white,
      onSurface: Colors.black,
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 237, 239, 241),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.7),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    cardColor: Colors.white,
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: Colors.white,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.dark,
    ).copyWith(
      primary: Colors.blue,
      onPrimary: Colors.white,
      surface: Colors.grey[850],
      onSurface: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.7),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.blue,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    cardColor: Colors.grey[850],
    listTileTheme: ListTileThemeData(
      tileColor: Colors.grey[850],
    ),
    cardTheme: CardTheme(
      color: Colors.grey[850],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: SettingsController.instance,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateTitle: (context) => 'Trump Cards',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: SettingsController.instance.themeMode,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case Home.routeName:
                    return const Home();
                  case Carddecklibrary.routeName:
                    return const Carddecklibrary();
                  case ViewCards.routeName:
                    return const ViewCards();
                  case CardEditor.routeName:
                    return const CardEditor();
                  case CardDeckEditor.routeName:
                    return const CardDeckEditor();
                  case About.routeName:
                    return const About();
                  case Statistics.routeName:
                    return const Statistics();
                  case SettingsView.routeName:
                    return SettingsView(
                        controller: SettingsController.instance);
                  default:
                    return const Home();
                }
              },
            );
          },
        );
      },
    );
  }
}
