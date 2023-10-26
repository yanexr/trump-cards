import 'package:flutter/material.dart';
import '../data/airplanes.dart';
import '../data/rockets.dart';

import '../gameCard/cards.dart';
import '../gameCard/measurementUnits.dart';
import 'cars.dart';

List<GameCardDeck> cardDecks = [
  // GameCardDeck(
  //     'Animals',
  //     [],
  //     const Icon(
  //       Icons.pets_rounded,
  //       color: Colors.white,
  //     ),
  //     Characteristic(
  //         label: "Characteristic 1",
  //         measurementType: MeasurementType.amount,
  //         isHigherBetter: true),
  //     Characteristic(
  //         label: "Characteristic 2",
  //         measurementType: MeasurementType.weight,
  //         isHigherBetter: true),
  //     Characteristic(
  //         label: "Characteristic 3",
  //         measurementType: MeasurementType.speed,
  //         isHigherBetter: true),
  //     Characteristic(
  //         label: "Characteristic 4",
  //         measurementType: MeasurementType.time,
  //         isHigherBetter: true),
  //     Characteristic(
  //         label: "Characteristic 5",
  //         measurementType: MeasurementType.amount,
  //         isHigherBetter: true)),
  GameCardDeck(
    'Cars',
    cars,
    const Icon(
      Icons.local_taxi_rounded,
      color: Colors.white,
    ),
    Characteristic(
        translationKey: 'power(Watt)',
        measurementType: MeasurementType.power,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'topSpeed',
        measurementType: MeasurementType.speed,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'weight',
        measurementType: MeasurementType.weight,
        isHigherBetter: false),
    Characteristic(
        label: '0-100 km/h',
        measurementType: MeasurementType.time,
        isHigherBetter: false),
    Characteristic(
        translationKey: 'price',
        measurementType: MeasurementType.money,
        isHigherBetter: false),
  ),
  GameCardDeck(
    'Airplanes',
    airplanes,
    const Icon(
      Icons.local_airport_rounded,
      color: Colors.white,
    ),
    Characteristic(
        translationKey: 'topSpeed',
        measurementType: MeasurementType.speed,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'wingspan',
        measurementType: MeasurementType.distance,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'maxTakeoffWeight',
        measurementType: MeasurementType.weight,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'maxAltitude',
        measurementType: MeasurementType.distance,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'seats',
        measurementType: MeasurementType.amount,
        isHigherBetter: true),
  ),
  GameCardDeck(
    'Rockets',
    rockets,
    const Icon(
      Icons.rocket_rounded,
      color: Colors.white,
    ),
    Characteristic(
        translationKey: 'height',
        measurementType: MeasurementType.distance,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'stages',
        measurementType: MeasurementType.amount,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'payloadToLEO',
        measurementType: MeasurementType.weight,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'liftOffThrust',
        measurementType: MeasurementType.force,
        isHigherBetter: true),
    Characteristic(
        translationKey: 'launchesUntil2023',
        measurementType: MeasurementType.amount,
        isHigherBetter: true),
  ),

];
