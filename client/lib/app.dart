import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import 'gameCard/gameCardBack.dart';
import 'home/home.dart';
import 'cardEditor/cardEditor.dart';
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
  static int selectedCardDeck = 0;
  static Map<String, WikipediaArticle> apiCache = {};

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

          onGenerateTitle: (context) => tr('appTitle'),
          
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: SettingsController.instance.themeMode,

          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case Home.routeName:
                    return const Home();
                  case ViewCards.routeName:
                    return const ViewCards();
                  case CardEditor.routeName:
                    return const CardEditor();
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
