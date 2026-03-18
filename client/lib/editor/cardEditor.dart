import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:trump_cards/gameCard/cardImage.dart';
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
      saveGameCardDeck(
          "gameCardDeck${App.selectedCardDeck!.id}", App.selectedCardDeck!);
    } else {
      var allCards = [...App.selectedCardDeck!.cards]; // Create a copy
      List<GameCard> userCreatedCards =
          allCards.where((element) => element.id <= 0).toList();
      saveGameCards("gameCards${App.selectedCardDeck!.id}", userCreatedCards);
    }
  }
}

class _CardEditorState extends State<CardEditor> {
  final _formKey = GlobalKey<FormState>();
  static const _maxPickedImageWidth = 512;
  static const _pickedImageQuality = 70;

  String name = '';
  String subtitle = '';
  String imageUrl = '';
  String imageAttribution = '';
  String imageLicenseLink = '';
  late List<num> valuesInput;
  late final TextEditingController _imageUrlController;

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

    _imageUrlController = TextEditingController(text: imageUrl);
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    super.dispose();
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

  img.Image _flattenImage(img.Image image) {
    final background = img.Image(width: image.width, height: image.height);
    background.clear(img.ColorRgb8(255, 255, 255));
    return img.compositeImage(background, image);
  }

  String _encodePickedImage(Uint8List bytes) {
    final decodedImage = img.decodeImage(bytes);
    if (decodedImage == null) {
      throw const FormatException('Unsupported image file.');
    }

    final normalizedImage = img.bakeOrientation(decodedImage);
    final resizedImage = normalizedImage.width > _maxPickedImageWidth
        ? img.copyResize(normalizedImage, width: _maxPickedImageWidth)
        : normalizedImage;
    final outputImage = resizedImage.hasAlpha
        ? _flattenImage(resizedImage)
        : resizedImage.convert(numChannels: 3);
    final encodedImage =
        img.encodeJpg(outputImage, quality: _pickedImageQuality);

    return 'data:image/jpeg;base64,${base64Encode(encodedImage)}';
  }

  void _showImageErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          'Unable to process the selected image.',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        withData: true,
      );

      if (result == null || result.files.isEmpty) {
        return;
      }

      final imageBytes = result.files.first.bytes;
      if (imageBytes == null) {
        throw const FormatException('Unable to read the selected image.');
      }

      final dataUrl = _encodePickedImage(imageBytes);

      if (!mounted) {
        return;
      }

      setState(() {
        imageUrl = dataUrl;
        imageAttribution = '';
        imageLicenseLink = '';
        _imageUrlController.text = dataUrl;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      _showImageErrorSnackBar();
    }
  }

  void _clearImage() {
    setState(() {
      imageUrl = '';
      imageAttribution = '';
      imageLicenseLink = '';
      _imageUrlController.clear();
    });
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      // get id
      int id = 0;
      if (widget.gameCard != null) {
        id = widget.gameCard!.id;
      } else {
        List<int> ids = App.selectedCardDeck!.cards.map((e) => e.id).toList();
        id = ids.isEmpty
            ? 0
            : ids.reduce(
                    (value, element) => value < element ? value : element) -
                1;
      }

      // add an image if none is provided
      if (imageUrl.isEmpty) {
        WikimediaImage? wikimediaImage = await getWikimediaImage(name);
        if (wikimediaImage != null) {
          imageUrl = wikimediaImage.imageUrl;
          imageAttribution = 'via Wikimedia Commons';
          imageLicenseLink = wikimediaImage.descriptionUrl;
        } else {
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
          App.selectedCardDeck!.cards
              .removeWhere((element) => element.id == id);
        }
        App.selectedCardDeck!.cards.add(newCard);
      });

      // save
      if (App.selectedCardDeck!.isUserCreated) {
        saveGameCardDeck(
            "gameCardDeck${App.selectedCardDeck!.id}", App.selectedCardDeck!);
      } else {
        List<GameCard> userCreatedCards = App.selectedCardDeck!.cards
            .where((element) => element.id <= 0)
            .toList();
        saveGameCards("gameCards${App.selectedCardDeck!.id}", userCreatedCards);
      }

      if (!mounted) {
        return;
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
                        child: buildCardImage(
                          imagePath: imageUrl,
                          deckName: deck.name,
                          fit: BoxFit.cover,
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
                                controller: _imageUrlController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return null;
                                  }
                                  if (!value.startsWith('http') &&
                                      !value.startsWith('data:')) {
                                    return tr('urlIsNotValid');
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.url,
                                decoration: InputDecoration(
                                  labelText: tr('imageUrlOptional'),
                                  suffixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (imageUrl.isNotEmpty)
                                        IconButton(
                                          tooltip: 'Clear image',
                                          onPressed: _clearImage,
                                          icon: const Icon(Icons.clear),
                                        ),
                                      IconButton(
                                        tooltip: 'Choose image',
                                        onPressed: _pickImage,
                                        icon: const Icon(
                                          Icons.upload_file_rounded,
                                        ),
                                      ),
                                    ],
                                  ),
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
  imageUrl = imageUrl.replaceAll('60px', '960px');
  String key = data['pages'][0]['key'] ?? '';
  String descriptionUrl = 'https://commons.wikimedia.org/wiki/$key';
  return WikimediaImage(imageUrl, descriptionUrl);
}
