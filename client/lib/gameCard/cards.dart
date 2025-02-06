import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'measurementUnits.dart';
import 'package:flutter/services.dart' show rootBundle;

extension MeasurementTypeExtension on MeasurementType {
  String toJsonString() => toString().split('.').last;

  static MeasurementType fromJsonString(String s) {
    return MeasurementType.values.firstWhere(
      (e) => e.toString().split('.').last == s,
      orElse: () => MeasurementType.count,
    );
  }
}

class GameCard {
  final int id;
  final String name;
  final String subtitle;
  final String imagePath;
  final String imageAttr;
  final String imageLic;
  final List<num> values;

  const GameCard(this.id, this.name, this.subtitle, this.imagePath,
      this.imageAttr, this.imageLic, this.values);

  factory GameCard.fromJson(Map<String, dynamic> json) {
    return GameCard(
        json['id'] as int,
        json['name'] as String,
        json['subtitle'] as String,
        json['imagePath'] as String,
        json['imageAttr'] as String,
        json['imageLic'] as String,
        (json['values'] as List<dynamic>).cast<num>());
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subtitle': subtitle,
        'imagePath': imagePath,
        'imageAttr': imageAttr,
        'imageLic': imageLic,
        'values': values,
      };
}

class Characteristic {
  String label;
  MeasurementType measurementType;
  bool isHigherBetter;

  Characteristic({
    required this.label,
    required this.measurementType,
    required this.isHigherBetter,
  });

  factory Characteristic.fromJson(Map<String, dynamic> json) {
    return Characteristic(
      label: json['label'],
      measurementType:
          MeasurementTypeExtension.fromJsonString(json['measurementType']),
      isHigherBetter: json['isHigherBetter'],
    );
  }

  Map<String, dynamic> toJson() => {
        'label': label,
        'measurementType': measurementType.toJsonString(),
        'isHigherBetter': isHigherBetter,
      };

  static String getLabelAndSymbol(Characteristic c) {
    if (c.measurementType == MeasurementType.count) {
      return tr(c.label);
    }
    return '${tr(c.label)} (${Measurements.getUnitSymbol(c.measurementType)})';
  }
}

class GameCardDeck {
  int id;
  final String name;
  final String thumbnailPath;
  final String backgroundPath;
  final List<Characteristic> characteristics;
  final List<GameCard> cards;
  bool isUserCreated;

  GameCardDeck(this.id, this.name, this.thumbnailPath, this.backgroundPath,
      this.characteristics, this.cards,
      {this.isUserCreated = false});

  factory GameCardDeck.fromJson(Map<String, dynamic> json) {
    var cardsJson = json['cards'] as List;
    var characteristicsJson = json['characteristics'] as List;

    return GameCardDeck(
      json['id'],
      json['name'],
      json['thumbnailPath'],
      json['backgroundPath'],
      characteristicsJson.map((ch) => Characteristic.fromJson(ch)).toList(),
      cardsJson.map((c) => GameCard.fromJson(c)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'thumbnailPath': thumbnailPath,
        'backgroundPath': backgroundPath,
        'characteristics': characteristics.map((ch) => ch.toJson()).toList(),
        'cards': cards.map((c) => c.toJson()).toList(),
      };

  Future<void> addUserCreatedCards() async {
    String key = 'gameCards$id';
    cards.addAll(await loadGameCards(key));
  }

  String toCSV() {
    // header are name, subtitle and characteristics labels
    String csv = '"Title","Subtitle",';
    csv +=
        '${characteristics.map((ch) => '"${ch.label} ${Measurements.getDefaultUnit(ch.measurementType)}"').join(',')}\n';
    // add the cards
    for (var card in cards) {
      csv += '"${card.name.replaceAll('"', '""')}","${card.subtitle.replaceAll('"', '""')}",';
      csv += '${card.values.join(',')}\n';
    }
    return csv;
  }
}

Future<GameCardDeck> loadGameCardDeck(String s,
    {bool fromShPref = false}) async {
  String jsonString = '';

  if (fromShPref) {
    final prefs = await SharedPreferences.getInstance();
    jsonString = prefs.getString(s) ?? '';
    if (jsonString.isEmpty) {
      throw Exception('No deck found in SharedPreferences with key: $s');
    }
  } else if (s.startsWith('http')) {
    final response = await http.get(Uri.parse(s));
    if (response.statusCode == 200) {
      jsonString = response.body;
    } else {
      throw Exception('Failed to load remote deck');
    }
  } else {
    jsonString = await rootBundle.loadString(s);
  }

  final Map<String, dynamic> json = await jsonDecode(jsonString);
  return GameCardDeck.fromJson(json);
}

Future<void> saveGameCardDeck(String key, GameCardDeck deck) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, jsonEncode(deck));
}

Future<List<GameCard>> loadGameCards(String key) async {
  final prefs = await SharedPreferences.getInstance();
  String jsonString = prefs.getString(key) ?? '';
  if (jsonString.isEmpty) {
    return [];
  }
  final List<dynamic> json = await jsonDecode(jsonString);
  return json.map((c) => GameCard.fromJson(c)).toList();
}

Future<void> saveGameCards(String key, List<GameCard> cards) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, jsonEncode(cards));
}

class GameCardDeckEntry {
  final String name;
  final String path;
  final String numberOfCards;
  final String thumbnailPath;
  final int id;

  GameCardDeckEntry(
      this.name, this.path, this.numberOfCards, this.thumbnailPath,
      {this.id = 0});

  factory GameCardDeckEntry.fromJson(Map<String, dynamic> json) {
    return GameCardDeckEntry(
      json['name'],
      json['path'],
      json['numberOfCards'],
      json['thumbnailPath'],
    );
  }
}

Future<List<GameCardDeckEntry>> parseGameCardDeckEntries(String path) async {
  String jsonString = '';
  if (path.startsWith('http')) {
    final response = await http.get(Uri.parse(path));
    if (response.statusCode == 200) {
      jsonString = response.body;
    } else {
      throw Exception('Failed to load remote decks');
    }
  } else {
    jsonString = await rootBundle.loadString(path);
  }
  final parsed = jsonDecode(jsonString).cast<Map<String, dynamic>>();
  return parsed
      .map<GameCardDeckEntry>((json) => GameCardDeckEntry.fromJson(json))
      .toList();
}

Future<List<GameCardDeckEntry>> parseUserCreatedGameCardDeckEntries() async {
  List<GameCardDeckEntry> gcde = [];

  final prefs = await SharedPreferences.getInstance();
  final keys = prefs
      .getKeys()
      .where((key) => RegExp(r'^gameCardDeck\d{9}$').hasMatch(key));

  for (var key in keys) {
    try {
      GameCardDeck deck = await loadGameCardDeck(key, fromShPref: true);
      gcde.add(GameCardDeckEntry(
        deck.name,
        key,
        deck.cards.length.toString(),
        deck.thumbnailPath,
        id: deck.id,
      ));
    } catch (e) {
      print('Error loading deck $key: $e');
    }
  }
  return gcde;
}
