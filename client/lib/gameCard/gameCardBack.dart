import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trump_cards/gameCard/gameCardWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import '../gameCard/cards.dart';
import '../app.dart';

class GameCardBack extends StatefulWidget {
  final GameCard gameCard;
  final Function flipCard;
  final bool elevation;
  final String languageCode;
  const GameCardBack(
      {super.key,
      required this.gameCard,
      required this.flipCard,
      required this.elevation,
      this.languageCode = 'en'});

  @override
  _GameCardBackState createState() => _GameCardBackState();
}

class _GameCardBackState extends State<GameCardBack> {
  late final Future<WikipediaArticle> future;

  @override
  void initState() {
    super.initState();
    future = getData(widget.gameCard, widget.languageCode);
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 8,
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (GameCardStyle.style.borderContainerGradient == null &&
                  GameCardStyle.style.borderContainerImage == null)
              ? Theme.of(context).colorScheme.surface
              : null,
          gradient: GameCardStyle.style.borderContainerGradient,
          image: GameCardStyle.style.borderContainerImage,
          borderRadius: BorderRadius.all(Radius.circular(
              GameCardStyle.style.borderRadius == null
                  ? 28
                  : GameCardStyle.style.borderRadius! * (4 / 3))),
          boxShadow: (widget.elevation && GameCardStyle.style.hasShadow)
              ? [
                  const BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0, 0),
                      blurRadius: 15.0,
                      spreadRadius: -5.0)
                ]
              : [],
        ),
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: GameCardStyle.style.innerContainerGradient == null
                  ? Theme.of(context).scaffoldBackgroundColor
                  : null,
              gradient: GameCardStyle.style.innerContainerGradient,
              image: GameCardStyle.style.innerContainerImage,
              borderRadius: BorderRadius.all(
                  Radius.circular(GameCardStyle.style.borderRadius ?? 20)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: GameCardStyle.style.title?.color ??
                            Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.all(Radius.circular(
                            GameCardStyle.style.borderRadius == 0 ? 0 : 90)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: Semantics(
                        button: true,
                        label: tr('back'),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          tooltip: tr('back'),
                          color: Colors.white,
                          onPressed: () {
                            widget.flipCard();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: Text(
                      widget.gameCard.name,
                      softWrap: true,
                      style: TextStyle(
                        fontSize: 20,
                        color: GameCardStyle.style.title?.color,
                        fontFamily: GameCardStyle.style.title?.fontFamily,
                      ),
                    ))
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                    child: FutureBuilder<WikipediaArticle>(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                          child: Column(children: [
                        Text(
                          snapshot.data!.text,
                          style: TextStyle(
                            fontSize: 16,
                            color: GameCardStyle.style.text?.color,
                            fontFamily: GameCardStyle.style.text?.fontFamily,
                          ),
                        ),
                        const SizedBox(height: 25),
                        snapshot.data!.url != ''
                            ? OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () {
                                  launchUrl(Uri.parse(snapshot.data!.url));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      tr('readMoreOnWikipedia'),
                                      style: TextStyle(
                                        color: GameCardStyle.style.title?.color,
                                        fontFamily: GameCardStyle
                                            .style.title?.fontFamily,
                                      ),
                                    ),
                                    Icon(Icons.open_in_new_rounded,
                                        size: 14,
                                        color:
                                            GameCardStyle.style.title?.color),
                                  ],
                                ))
                            : const SizedBox(height: 0),
                        const SizedBox(height: 10),
                        snapshot.data!.url != ''
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${tr('textUnder')} ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                              GameCardStyle.style.text?.color)),
                                  MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                          onTap: () {
                                            launchUrl(Uri.parse(
                                                'https://creativecommons.org/licenses/by-sa/3.0/'));
                                          },
                                          child: Text(
                                            tr('ccbysaLicense'),
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: GameCardStyle
                                                  .style.text?.color,
                                              decoration:
                                                  TextDecoration.underline,
                                              decorationColor: GameCardStyle
                                                  .style.text?.color,
                                            ),
                                          )))
                                ],
                              )
                            : const SizedBox(height: 0),
                        const SizedBox(height: 10),
                      ]));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ))
              ],
            )),
      ),
    );
  }
}

class WikipediaArticle {
  String title;
  String url;
  String text;
  WikipediaArticle(this.title, this.url, this.text);
}

Future<WikipediaArticle> getData(GameCard gameCard, String languageCode) async {
  String key = '${App.selectedCardDeck}${gameCard.id}';
  // check if data is already cached
  if (App.wikipediaCache.containsKey(key)) {
    return Future.value(App.wikipediaCache[key]);
  }

  // otherwise, search, fetch and cache wikipedia article
  try {
    SearchResult searchResult =
        await wikipediaSearch(gameCard.name, languageCode);
    String wikipediaText =
        await getWikipediaText(searchResult.title, languageCode);
    WikipediaArticle wikipediaArticle =
        WikipediaArticle(searchResult.title, searchResult.url, wikipediaText);

    App.wikipediaCache[key] = wikipediaArticle;

    return wikipediaArticle;
  } catch (e) {
    return WikipediaArticle('Error', '', e.toString());
  }
}

class SearchResult {
  String title;
  String url;
  SearchResult(this.title, this.url);
}

Future<SearchResult> wikipediaSearch(
    String searchQuery, String languageCode) async {
  String language = languageCode;
  final Map<String, dynamic> queryParameters = {
    'action': 'opensearch',
    'search': searchQuery,
    'limit': '1',
    'format': 'json',
    'origin': '*',
  };
  Uri url = Uri.https('$language.wikipedia.org', '/w/api.php', queryParameters);

  final response = await http.get(url);
  var data = jsonDecode(response.body.toString());

  try {
    String wikipediaTitle = data[1][0];
    String wikipediaUrl = data[3][0];
    return SearchResult(wikipediaTitle, wikipediaUrl);
  } on RangeError {
    // if no article is found, try again with the last word removed
    if (searchQuery.contains(' ')) {
      String newSearchQuery =
          searchQuery.substring(0, searchQuery.lastIndexOf(' '));
      return await wikipediaSearch(newSearchQuery, languageCode);
    } else {
      throw Exception('No Wikipedia article found');
    }
  }
}

Future<String> getWikipediaText(
    String wikipediaTitle, String languageCode) async {
  String language = languageCode;
  final Map<String, dynamic> queryParameters = {
    'action': 'query',
    'prop': 'extracts',
    'redirects': '1',
    'format': 'json',
    'exintro': null,
    'explaintext': null,
    'titles': wikipediaTitle,
    'origin': '*',
  };
  Uri url = Uri.https('$language.wikipedia.org', '/w/api.php', queryParameters);

  final response = await http.get(url);
  var data = jsonDecode(response.body.toString());

  String result = data['query']['pages'].values.first['extract'];
  return result;
}
