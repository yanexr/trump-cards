import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/gameCard/cards.dart';
import 'package:trump_cards/home/notEnoughCardsDialog.dart';

import 'appBar.dart';
import 'multiPlayerDialog.dart';
import '../home/singlePlayerDialog.dart';
import '../app.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const routeName = '/';

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final backgroundIsNetworkImage =
        App.selectedCardDeck!.backgroundPath.startsWith('http');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const MyAppBar(),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: backgroundIsNetworkImage
                  ? Image.network(
                      App.selectedCardDeck!.backgroundPath,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Image.asset(
                          'assets/images/colored.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Image.asset(
                      'assets/images/${App.selectedCardDeck!.backgroundPath}',
                      fit: BoxFit.cover,
                    ),
            ),

            // Main content
            CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          // Logo
                          const Image(
                            image: AssetImage(
                                'assets/images/trump-cards-logo-shadow.png'),
                            height: 190,
                          ),
                          const SizedBox(height: 30),
                          // Card deck selection
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 16),
                            child: TextButton(
                              onPressed: () async {
                                final result = await Navigator.pushNamed(
                                    context, '/card-deck-library');

                                if (result != null && result is GameCardDeck) {
                                  setState(() {
                                    App.selectedCardDeck = result;
                                  });
                                }
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 500),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: SizedBox.fromSize(
                                        child: App
                                                .selectedCardDeck!.thumbnailPath
                                                .startsWith('http')
                                            ? Image.network(
                                                App.selectedCardDeck!
                                                    .thumbnailPath,
                                                fit: BoxFit.cover,
                                                height: 64,
                                                width: 64,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  return Image.asset(
                                                    'assets/images/placeholder.png',
                                                    fit: BoxFit.cover,
                                                    height: 64,
                                                    width: 64,
                                                  );
                                                },
                                              )
                                            : Image.asset(
                                                'assets/images/${App.selectedCardDeck!.thumbnailPath}',
                                                fit: BoxFit.cover,
                                                height: 64,
                                                width: 64,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            tr(App.selectedCardDeck!.name),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.black87,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 2),
                                          Text(
                                            tr('Tap to change Card Deck'),
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const SizedBox(
                                      height: 64,
                                      child: VerticalDivider(
                                        color: Colors.black38,
                                        thickness: 1,
                                        width: 1,
                                        indent: 4,
                                        endIndent: 4,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const Icon(
                                      Icons.autorenew,
                                      color: Colors.black87,
                                      size: 28,
                                    ),
                                    const SizedBox(width: 8),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 0),
                        ],
                      ),
                      Column(
                        children: [
                          // singleplayer button
                          MaterialButton(
                            color: Colors.blue,
                            height: 65,
                            minWidth: 300,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.person, color: Colors.white),
                                const SizedBox(width: 10),
                                Text(
                                  tr('singleplayer'),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            onPressed: () {
                              if (App.selectedCardDeck!.cards.length < 8) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const NotEnoughCardsDialog();
                                    });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return const SinglePlayerDialog();
                                  },
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          // multiplayer button
                          MaterialButton(
                            color: Colors.blue,
                            height: 65,
                            minWidth: 300,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.group_add_rounded,
                                    color: Colors.white),
                                const SizedBox(width: 10),
                                Text(
                                  tr('multiplayer'),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            onPressed: () {
                              if (App.selectedCardDeck!.cards.length < 8) {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const NotEnoughCardsDialog();
                                    });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) {
                                    return const MultiPlayerDialog();
                                  },
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          // view cards button
                          MaterialButton(
                            color: Colors.blue,
                            height: 65,
                            minWidth: 300,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const RotatedBox(
                                    quarterTurns: 2,
                                    child:
                                        Icon(Icons.style, color: Colors.white)),
                                const SizedBox(width: 10),
                                Text(
                                  tr('Cards'),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, '/cards');
                            },
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
