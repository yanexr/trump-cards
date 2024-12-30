import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:trump_cards/gameCard/measurementUnits.dart';

import '../app.dart';
import '../gameCard/cards.dart';

class CardEditor extends StatefulWidget {
  final GameCard? gameCard;
  const CardEditor({super.key, this.gameCard});

  static const routeName = '/card-editor';

  @override
  _CardEditorState createState() => _CardEditorState();

  static Future<void> deleteCard(int id) async {
    App.selectedCardDeck!.cards.removeWhere((element) => element.id == id);
    if (App.selectedCardDeck!.isUserCreated) {
      saveGameCardDeck("gameCardDeck${App.selectedCardDeck!.id}",
          App.selectedCardDeck!);
    } else {
      var allCards = [...App.selectedCardDeck!.cards]; // Create a copy
      List<GameCard> userCreatedCards = allCards
          .where((element) => element.id <= 0)
          .toList();
      saveGameCards("gameCards${App.selectedCardDeck!.id}",
          userCreatedCards);
    }
  }
}

class _CardEditorState extends State<CardEditor> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String subtitle = '';
  String imageUrl = '';
  String imageAttribution = '';
  String imageLicenseLink = '';
  late List<num> valuesInput;

  @override
  void initState() {
    super.initState();
    final deck = App.selectedCardDeck!;
    valuesInput = List.filled(deck.characteristics.length, 0);

    if (widget.gameCard != null) {
      final card = widget.gameCard!;
      name = card.name;
      subtitle = card.subtitle;
      imageUrl = card.imagePath;
      imageAttribution = card.imageAttr;
      imageLicenseLink = card.imageLic;

      // Convert values to user-preferred units
      for (int i = 0; i < deck.characteristics.length; i++) {
        final mType = deck.characteristics[i].measurementType;
        valuesInput[i] = Measurements.convert(card.values[i], mType);
      }
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
    if (_formKey.currentState!.validate()) {
      // get id
      int id = 0;
      if (widget.gameCard != null) {
        id = widget.gameCard!.id;
      } else {
        List<int> ids = App.selectedCardDeck!.cards.map((e) => e.id).toList();
        id = ids.isEmpty ? 0 : ids.reduce((value, element) => value < element ? value : element) - 1;
      }

      // add an image if none is provided
      if (imageUrl.isEmpty) {
        WikimediaImage? wikimediaImage = await getWikimediaImage(name);
        if (wikimediaImage != null) {
          imageUrl = wikimediaImage.imageUrl;
          imageAttribution = 'via Wikimedia Commons';
          imageLicenseLink = wikimediaImage.descriptionUrl;
        } else{
          imageUrl = 'https';
        }
      }

      // Convert values back
      List<num> convertedValues = [];
      for (int i = 0; i < App.selectedCardDeck!.characteristics.length; i++) {
        final mType = App.selectedCardDeck!.characteristics[i].measurementType;
        convertedValues.add(Measurements.convertBack(valuesInput[i], mType));
      }

      // create new card
      GameCard newCard = GameCard(
        id,
        name,
        subtitle,
        imageUrl,
        imageAttribution,
        imageLicenseLink,
        convertedValues,
      );

      // add new card to the card deck
      setState(() {
        if (widget.gameCard != null) {
          App.selectedCardDeck!.cards.removeWhere((element) => element.id == id);
        }
        App.selectedCardDeck!.cards.add(newCard);
      });

      // save
      if (App.selectedCardDeck!.isUserCreated) {
        saveGameCardDeck("gameCardDeck${App.selectedCardDeck!.id}",
            App.selectedCardDeck!);
      } else {
        List<GameCard> userCreatedCards = App.selectedCardDeck!.cards
            .where((element) => element.id <= 0)
            .toList();
        saveGameCards("gameCards${App.selectedCardDeck!.id}",
            userCreatedCards);
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            content: Text(
              '✔ ${tr('cardSavedSuccessfully')}',
              style: const TextStyle(color: Colors.white),
            )),
      );
      Navigator.pop(context);
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
    final deck = App.selectedCardDeck!;

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
                                initialValue: name,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return tr('pleaseEnterSomeText');
                                  }
                                  return null;
                                },
                                maxLength: 50,
                                decoration: InputDecoration(
                                  labelText: tr('title'),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    name = value;
                                  });
                                },
                              ),
                              TextFormField(
                                initialValue: subtitle,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return tr('pleaseEnterSomeText');
                                  }
                                  return null;
                                },
                                maxLength: 250,
                                decoration: InputDecoration(
                                  labelText: tr('Subtitle'),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    subtitle = value;
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
                          children: List.generate(deck.characteristics.length,
                              (index) {
                            final characteristic = deck.characteristics[index];
                            return Padding(
                              padding:
                                  EdgeInsets.only(top: index == 0 ? 0 : 10),
                              child: TextFormField(
                                initialValue: widget.gameCard == null
                                    ? null
                                    : valuesInput[index].toString(),
                                keyboardType: TextInputType.number,
                                validator: numberValidator,
                                decoration: InputDecoration(
                                  labelText: Characteristic.getLabelAndSymbol(
                                      characteristic),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    if (num.tryParse(value) != null) {
                                      valuesInput[index] = num.parse(value);
                                    }
                                  });
                                },
                              ),
                            );
                          }),
                        ),
                      ))),
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
                          tr('Save'),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  )),
                  const SizedBox(height: 50),
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

Future<WikimediaImage?> getWikimediaImage(String searchQuery) async {
  final Map<String, dynamic> queryParameters = {
    'q': searchQuery,
    'limit': '1',
  };
  Uri url = Uri.https(
      'commons.wikimedia.org', '/w/rest.php/v1/search/page', queryParameters);
  final response = await http.get(url);
  var data = jsonDecode(response.body.toString());

  if (data['pages'] == null || data['pages'].isEmpty) {
    return null;
  }
  String imageUrl = data['pages'][0]['thumbnail']['url'] ?? '';
  imageUrl = imageUrl.replaceAll('60px', '640px');
  String key = data['pages'][0]['key'] ?? '';
  String descriptionUrl = 'https://commons.wikimedia.org/wiki/$key';
  return WikimediaImage(imageUrl, descriptionUrl);
}
