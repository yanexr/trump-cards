import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'appBar.dart';
import 'multiPlayerDialog.dart';
import '../home/singlePlayerDialog.dart';
import '../app.dart';
import '../data/cardDecks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const routeName = '/';

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: MyAppBar(),
        ),
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/images/${cardDecks[App.selectedCardDeck].name}/background.jpg'),
                    fit: BoxFit.cover)),
            child: CustomScrollView(scrollDirection: Axis.vertical, slivers: [
              SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Image(
                                image: AssetImage(
                                    'assets/images/trump-cards-logo-shadow.png'),
                                height: 190),
                            const SizedBox(height: 10),
                            CupertinoSlidingSegmentedControl<int>(
                                backgroundColor: Colors.black45,
                                onValueChanged: (int? value) {
                                  setState(() {
                                    App.selectedCardDeck = value!;
                                  });
                                },
                                thumbColor:
                                    Theme.of(context).colorScheme.primary,
                                groupValue: App.selectedCardDeck,
                                children: cardDecks.asMap().map(
                                    (key, cardDeck) => MapEntry(
                                        key,
                                        Container(
                                            padding: const EdgeInsets.all(7.0),
                                            child: cardDeck.icon)))),
                            const SizedBox(height: 10),
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
                                  const SizedBox(
                                    width: 10,
                                  ),
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
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const SinglePlayerDialog();
                                    });
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
                                  const Icon(
                                    Icons.group_add_rounded,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
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
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return const MultiPlayerDialog();
                                    });
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
                                      child: Icon(Icons.style,
                                          color: Colors.white)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    tr('viewCards'),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context, '/view-cards');
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                      ]))
            ])));
  }
}
