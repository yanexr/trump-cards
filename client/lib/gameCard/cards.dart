import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'measurementUnits.dart';

class GameCard {
  final int id;
  final String title, subtitle, imagePath, imageAttribution, imageLicenseLink;
  final num value1;
  final num value2;
  final num value3;
  final num value4;
  final num value5;

  const GameCard(
    this.id,
    this.title,
    this.subtitle,
    this.imagePath,
    this.imageAttribution,
    this.imageLicenseLink,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
    this.value5,
  );
}

class Characteristic {
  String? label;
  final MeasurementType measurementType;
  final bool isHigherBetter;
  String? translationKey;

  Characteristic(
      {this.label,
      required this.measurementType,
      required this.isHigherBetter,
      this.translationKey});

  String getLabel() {
    if (translationKey != null) {
      return tr(translationKey!);
    } else {
      return label ?? 'No label';
    }
  }

  static String getLabelAndSymbol(Characteristic c) {
    return '${c.getLabel()} (${Measurements.getUnitSymbol(c.measurementType)})';
  }
}

class GameCardDeck {
  final String name;
  final List<GameCard> cards;
  final List<GameCard> userCreatedCards = [];
  final Icon icon;
  final Characteristic c1;
  final Characteristic c2;
  final Characteristic c3;
  final Characteristic c4;
  final Characteristic c5;

  GameCardDeck(this.name, this.cards, this.icon, this.c1, this.c2, this.c3,
      this.c4, this.c5);
}
