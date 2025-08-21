import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/gameCard/measurementUnits.dart';

import '../app.dart';
import '../gameCard/cards.dart';

class CardDeckEditor extends StatefulWidget {
  final String? shPrefKey;
  const CardDeckEditor({super.key, this.shPrefKey});

  static const routeName = '/card-deck-editor';

  @override
  _CardDeckEditorState createState() => _CardDeckEditorState();
}

class _CharacteristicWithId {
  final int id;
  Characteristic characteristic;

  _CharacteristicWithId(this.id, this.characteristic);
}

class _CardDeckEditorState extends State<CardDeckEditor> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  GameCardDeck? _gameCardDeck;
  String name = '';
  String backgroundPath = '';
  List<_CharacteristicWithId> characteristicsWithId = [];

  @override
  void initState() {
    super.initState();
    _initializeDeck();
  }

  Future<void> _initializeDeck() async {
    if (widget.shPrefKey != null) {
      // Load the GameCardDeck from shared preferences
      final loadedDeck =
          await loadGameCardDeck(widget.shPrefKey!, fromShPref: true);
      setState(() {
        _gameCardDeck = loadedDeck;
        name = loadedDeck.name;
        backgroundPath = loadedDeck.backgroundPath;
        if (backgroundPath == 'colored.jpg') {
          backgroundPath = '';
        }
        characteristicsWithId = loadedDeck.characteristics
            .asMap()
            .entries
            .map((entry) => _CharacteristicWithId(entry.key, entry.value))
            .toList();
      });
    } else {
      setState(() {
        _gameCardDeck = null;
      });
    }
  }

  Future<void> save() async {
    if (_formKey.currentState!.validate()) {
      // Ensure that attributes are not empty
      if (characteristicsWithId.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              '✗ ${tr('No attributes added')}',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
        return;
      }

      int id = 0;
      if (_gameCardDeck != null) {
        id = _gameCardDeck!.id;
      } else {
        // new id is a random 9 digit number
        id = Random().nextInt(900000000) + 100000000;
      }

      // set images
      if (backgroundPath.isEmpty) {
        backgroundPath = 'colored.jpg';
      }
      String thumbnailPath = 'thumbnail.webp';

      // cards
      List<GameCard> cards = [];
      if (_gameCardDeck != null) {
        cards = _gameCardDeck!.cards;
      }

      // Extract characteristics from characteristicsWithId
      final characteristics =
          characteristicsWithId.map((c) => c.characteristic).toList();

      // create new card deck
      GameCardDeck newCardDeck = GameCardDeck(
        id,
        name,
        thumbnailPath,
        backgroundPath,
        characteristics,
        cards,
        isUserCreated: true,
      );

      setState(() {
        App.selectedCardDeck = newCardDeck;
      });

      // save
      saveGameCardDeck("gameCardDeck$id", newCardDeck);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            '✔ ${tr('Card Deck saved successfully')}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            '✗ ${tr('pleaseFixInvalidFields')}',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  void _addCharacteristic() {
    if (_gameCardDeck != null) {
      return; // Do not allow additions if deck is from prefs
    }

    setState(() {
      final newId = characteristicsWithId.isNotEmpty
          ? (characteristicsWithId.map((c) => c.id).reduce(max) + 1)
          : 0;
      final newItem = _CharacteristicWithId(
        newId,
        Characteristic(
          label: '',
          measurementType: MeasurementType.count,
          isHigherBetter: true,
        ),
      );

      characteristicsWithId.add(newItem);
      _listKey.currentState?.insertItem(characteristicsWithId.length - 1);
    });
  }

  void _removeCharacteristic(int id) {
    if (_gameCardDeck != null) {
      return; // Do not allow removals if deck is from prefs
    }

    final index = characteristicsWithId.indexWhere((c) => c.id == id);
    if (index >= 0) {
      final removedItem = characteristicsWithId[index];
      // Remove with animation
      _listKey.currentState?.removeItem(
        index,
        (context, animation) =>
            _buildCharacteristicItem(removedItem, animation),
        duration: const Duration(milliseconds: 300),
      );

      characteristicsWithId.removeAt(index);
    }
  }

  Widget _buildCharacteristicItem(
      _CharacteristicWithId item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      axisAlignment: 0.0,
      child: ScaleTransition(
        scale: animation,
        child: Container(
          key: ValueKey(item.id),
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Label TextFormField
                      TextFormField(
                        initialValue: item.characteristic.label,
                        decoration: InputDecoration(
                          labelText: tr('Label'),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return tr('pleaseEnterSomeText');
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            item.characteristic.label = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),

                      // MeasurementType Dropdown
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<MeasurementType>(
                              value: item.characteristic.measurementType,
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    item.characteristic.measurementType = value;
                                  });
                                }
                              },
                              items: MeasurementType.values
                                  .map(
                                    (type) => DropdownMenuItem(
                                      value: type,
                                      child: Text(
                                        Measurements.measurementTypeToString(
                                            type),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              decoration: InputDecoration(
                                labelText: tr('Measurement Type'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Higher is better Checkbox
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: item.characteristic.isHigherBetter,
                            onChanged: (value) {
                              setState(() {
                                item.characteristic.isHigherBetter =
                                    value ?? true;
                              });
                            },
                          ),
                          const SizedBox(width: 10),
                          Text(
                            tr("Higher value wins"),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // show Remove button only if deck is new
                _gameCardDeck == null
                    ? Positioned(
                        top: 5,
                        right: 5,
                        child: IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => setState(() {
                            _removeCharacteristic(item.id);
                          }),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If deck is still loading or hasn't been initialized yet, show a loader or placeholder
    if (widget.shPrefKey != null && _gameCardDeck == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(tr('Card Deck Editor')),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(tr('Card Deck Editor')),
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
                        child: Image.network(
                          backgroundPath,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset('assets/images/colored.jpg',
                                fit: BoxFit.cover);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
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
                            maxLength: 30,
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
                            initialValue: backgroundPath,
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
                                backgroundPath = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // ATTRIBUTES SECTION TITLE
                Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 2),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${tr("Attributes")} (${characteristicsWithId.length})",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                  ),
                ),

                // CHARACTERISTICS LIST
                Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: characteristicsWithId.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index, animation) {
                      final item = characteristicsWithId[index];
                      return _buildCharacteristicItem(item, animation);
                    },
                  ),
                ),

                // ADD NEW CHARACTERISTIC BUTTON
                if (_gameCardDeck == null) ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      foregroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                              width: 2)),
                      padding: const EdgeInsets.all(20),
                    ),
                    onPressed: _addCharacteristic,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.add),
                        const SizedBox(width: 10),
                        Text(tr("Add Attribute")),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ] else ...[
                  const SizedBox(height: 0),
                ],

                // SAVE BUTTON
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
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
