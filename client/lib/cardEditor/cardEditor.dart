import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:trump_cards/gameCard/measurementUnits.dart';

import '../app.dart';
import '../gameCard/cards.dart';
import '../data/cardDecks.dart';

class CardEditor extends StatefulWidget {
  final GameCard? gameCard;
  const CardEditor({super.key, this.gameCard});

  static const routeName = '/card-editor';

  @override
  _CardEditorState createState() => _CardEditorState();

  static Future<void> loadUserCreatedCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringIds = prefs.getStringList('userCreatedCardIds') ?? [];
    if (stringIds.isEmpty) return;
    List<String> cardData = [];
    for (String stringId in stringIds) {
      cardData = prefs.getStringList(stringId) ?? [];
      if (cardData.isEmpty) continue;
      cardDecks[int.parse(cardData[0])].userCreatedCards.add(GameCard(
            int.parse(stringId),
            cardData[1],
            cardData[2],
            cardData[3],
            cardData[4],
            cardData[5],
            num.parse(cardData[6]),
            num.parse(cardData[7]),
            num.parse(cardData[8]),
            num.parse(cardData[9]),
            num.parse(cardData[10]),
          ));
    }
  }

  static Future<int> getNextId() async {
    // returns the next id that is one lower than the currently lowest id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringIds = prefs.getStringList('userCreatedCardIds') ?? [];
    if (stringIds.isEmpty) {
      return -1;
    }
    List<int> ids = stringIds.map((e) => int.parse(e)).toList();
    return ids.reduce((id1, id2) => id1 < id2 ? id1 : id2) - 1;
  }

  static Future<void> addId(int id) async {
    // adds the id to the list of ids
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringIds = prefs.getStringList('userCreatedCardIds') ?? [];
    stringIds.add(id.toString());
    await prefs.setStringList('userCreatedCardIds', stringIds);
  }

  static Future<void> deleteCard(int id) async {
    // delete card from the user created cards list
    cardDecks[App.selectedCardDeck]
        .userCreatedCards
        .removeWhere((element) => element.id == id);
    // delete card from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> stringIds = prefs.getStringList('userCreatedCardIds') ?? [];
    stringIds.remove(id.toString());
    await prefs.setStringList('userCreatedCardIds', stringIds);
    await prefs.remove('$id');
  }
}

class _CardEditorState extends State<CardEditor> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String year = '';
  String imageUrl = '';
  String imageAttribution = '';
  String imageLicenseLink = '';
  num v1 = 0;
  num v2 = 0;
  num v3 = 0;
  num v4 = 0;
  num v5 = 0;

  @override
  void initState() {
    super.initState();
    if (widget.gameCard != null) {
      title = widget.gameCard!.title;
      year = widget.gameCard!.subtitle;
      imageUrl = widget.gameCard!.imagePath;
      imageAttribution = widget.gameCard!.imageAttribution;
      imageLicenseLink = widget.gameCard!.imageLicenseLink;
      v1 = Measurements.convert(widget.gameCard!.value1, cardDecks[App.selectedCardDeck].c1.measurementType);
      v2 = Measurements.convert(widget.gameCard!.value2, cardDecks[App.selectedCardDeck].c2.measurementType);
      v3 = Measurements.convert(widget.gameCard!.value3, cardDecks[App.selectedCardDeck].c3.measurementType);
      v4 = Measurements.convert(widget.gameCard!.value4, cardDecks[App.selectedCardDeck].c4.measurementType);
      v5 = Measurements.convert(widget.gameCard!.value5, cardDecks[App.selectedCardDeck].c5.measurementType);
    }
  }

  String? numberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return tr('pleaseEnterANumber');
    }
    if (num.tryParse(value) == null) {
      return tr('pleaseEnterAValidNumber');
    }
    return null;
  }

  Future<void> save() async {
    int id = 0;
    if (_formKey.currentState!.validate()) {
      if (widget.gameCard == null) {
        id = await CardEditor.getNextId();
      } else {
        id = widget.gameCard!.id;
      }

      if (imageUrl == '') {
        WikimediaImage wikimediaImage = await getWikimediaImage(title);
        imageUrl = wikimediaImage.imageUrl;
        imageAttribution = 'via Wikimedia Commons';
        imageLicenseLink = wikimediaImage.descriptionUrl;
      }
      num newV1 = Measurements.convertBack(v1, cardDecks[App.selectedCardDeck].c1.measurementType);
      num newV2 = Measurements.convertBack(v2, cardDecks[App.selectedCardDeck].c2.measurementType);
      num newV3 = Measurements.convertBack(v3, cardDecks[App.selectedCardDeck].c3.measurementType);
      num newV4 = Measurements.convertBack(v4, cardDecks[App.selectedCardDeck].c4.measurementType);
      num newV5 = Measurements.convertBack(v5, cardDecks[App.selectedCardDeck].c5.measurementType);
      GameCard newCard = GameCard(id, title, year, imageUrl, imageAttribution,
          imageLicenseLink, newV1, newV2, newV3, newV4, newV5);

      setState(() {
        if (widget.gameCard == null) {
          cardDecks[App.selectedCardDeck].userCreatedCards.add(newCard);
        } else {
          cardDecks[App.selectedCardDeck]
              .userCreatedCards
              .removeWhere((element) => element.id == id);
          cardDecks[App.selectedCardDeck].userCreatedCards.add(newCard);
        }
      });

      // save card deck id and card data to shared preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('$id', [
        App.selectedCardDeck.toString(),
        title,
        year,
        imageUrl,
        imageAttribution,
        imageLicenseLink,
        v1.toString(),
        v2.toString(),
        v3.toString(),
        v4.toString(),
        v5.toString()
      ]);
      if (widget.gameCard == null) {
        await CardEditor.addId(id);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              '✔ ${tr('cardSavedSuccessfully')}',
              style: TextStyle(color: Colors.white),
            )),
      );
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              '✗ ${tr('pleaseFixInvalidFields')}',
              style: const TextStyle(color: Colors.white),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(tr('cardEditor')),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: AspectRatio(
                      aspectRatio: 16 / 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: SizedBox.fromSize(
                          child: Image.network(imageUrl, fit: BoxFit.cover,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                            return Image.asset('assets/images/placeholder.png',
                                fit: BoxFit.cover);
                          }),
                        ),
                      ),
                    ),
                  )),
              Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue: title,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return tr('pleaseEnterSomeText');
                                  }
                                  return null;
                                },
                                maxLength: 30,
                                decoration: InputDecoration(
                                  labelText: tr('title'),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    title = value;
                                  });
                                },
                              ),
                              TextFormField(
                                initialValue: year,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return tr('pleaseEnterTheYear');
                                  }
                                  return null;
                                },
                                maxLength: 4,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  labelText: tr('year'),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    year = value;
                                  });
                                },
                              ),
                              TextFormField(
                                initialValue: imageUrl,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null;
                                  }
                                  if (!value.startsWith('http')) {
                                    return tr('urlIsNotValid');
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: tr('imageUrlOptional'),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    imageUrl = value;
                                  });
                                },
                              ),
                            ],
                          )))),
              Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              TextFormField(
                                initialValue: widget.gameCard == null
                                    ? null
                                    : v1.toString(),
                                keyboardType: TextInputType.number,
                                validator: numberValidator,
                                decoration: InputDecoration(
                                  labelText: Characteristic.getLabelAndSymbol(
                                      cardDecks[App.selectedCardDeck].c1),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (num.tryParse(value) != null) {
                                      v1 = num.parse(value);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                initialValue: widget.gameCard == null
                                    ? null
                                    : v2.toString(),
                                keyboardType: TextInputType.number,
                                validator: numberValidator,
                                decoration: InputDecoration(
                                  labelText: Characteristic.getLabelAndSymbol(
                                      cardDecks[App.selectedCardDeck].c2),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (num.tryParse(value) != null) {
                                      v2 = num.parse(value);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                initialValue: widget.gameCard == null
                                    ? null
                                    : v3.toString(),
                                keyboardType: TextInputType.number,
                                validator: numberValidator,
                                decoration: InputDecoration(
                                  labelText: Characteristic.getLabelAndSymbol(
                                      cardDecks[App.selectedCardDeck].c3),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (num.tryParse(value) != null) {
                                      v3 = num.parse(value);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                initialValue: widget.gameCard == null
                                    ? null
                                    : v4.toString(),
                                keyboardType: TextInputType.number,
                                validator: numberValidator,
                                decoration: InputDecoration(
                                  labelText: Characteristic.getLabelAndSymbol(
                                      cardDecks[App.selectedCardDeck].c4),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (num.tryParse(value) != null) {
                                      v4 = num.parse(value);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                initialValue: widget.gameCard == null
                                    ? null
                                    : v5.toString(),
                                keyboardType: TextInputType.number,
                                validator: numberValidator,
                                decoration: InputDecoration(
                                  labelText: Characteristic.getLabelAndSymbol(
                                      cardDecks[App.selectedCardDeck].c5),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (num.tryParse(value) != null) {
                                      v5 = num.parse(value);
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          )))),
              Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    height: 65,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: save,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          tr('saveAndExit'),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ))));
  }
}

class WikimediaImage {
  String imageUrl;
  String descriptionUrl;

  WikimediaImage(this.imageUrl, this.descriptionUrl);
}

Future<WikimediaImage> getWikimediaImage(String searchQuery) async {
  final Map<String, dynamic> queryParameters = {
    'q': searchQuery,
    'limit': '1',
  };
  Uri url = Uri.https(
      'commons.wikimedia.org', '/w/rest.php/v1/search/page', queryParameters);
  final response = await http.get(url);
  var data = jsonDecode(response.body.toString());

  String imageUrl = data['pages'][0]['thumbnail']['url'] ?? '';
  imageUrl = imageUrl.replaceAll('60px', '640px');
  String key = data['pages'][0]['key'] ?? '';
  String descriptionUrl = 'https://commons.wikimedia.org/wiki/$key';
  return WikimediaImage(imageUrl, descriptionUrl);
}
