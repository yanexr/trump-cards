import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../settings/settingsController.dart';

class Unit {
  final String name;
  final String symbol;
  final num conversionFactor;

  Unit(this.name, this.symbol, this.conversionFactor);
}

class Measurement {
  final String name;
  final List<Unit> units;
  int selectedUnit;

  Measurement(this.name, this.units, this.selectedUnit);
}

enum MeasurementType {
  power,
  force,
  speed,
  weight,
  time,
  money,
  distance,
  amount,
}

class Measurements {
  static Measurement _getMeasurement(MeasurementType m) {
    if (m == MeasurementType.power) {
      return power();
    } else if (m == MeasurementType.force) {
      return force();
    } else if (m == MeasurementType.speed) {
      return speed();
    } else if (m == MeasurementType.weight) {
      return weight();
    } else if (m == MeasurementType.time) {
      return time();
    } else if (m == MeasurementType.money) {
      return money();
    } else if (m == MeasurementType.distance) {
      return distance();
    } else if (m == MeasurementType.amount) {
      return amount();
    } else {
      return amount();
    }
  }

  static Measurement power() {
    return Measurement(
        tr('power'),
        [Unit(tr('kilowatt'), 'kw', 1), Unit(tr('horsepower'), 'hp', 1.34102)],
        SettingsController.instance.powerUnit);
  }

  static Measurement force() {
    return Measurement(tr('force'), [Unit(tr('kilonewton'), 'kN', 1)],
        SettingsController.instance.forceUnit);
  }

  static Measurement speed() {
    return Measurement(
        tr('speed'),
        [
          Unit(tr('kilometresPerHour'), 'km/h', 1),
          Unit(tr('milesPerHour'), 'mph', 0.62137),
          Unit(tr('knot'), 'kn', 0.53996),
          Unit(tr('mach'), 'Ma', 0.00082)
        ],
        SettingsController.instance.speedUnit);
  }

  static Measurement weight() {
    return Measurement(
        tr('weight'),
        [Unit(tr('kilogram'), 'kg', 1), Unit(tr('pound'), 'lb', 2.20462)],
        SettingsController.instance.weightUnit);
  }

  static Measurement time() {
    return Measurement(tr('time'), [Unit(tr('second'), 's', 1)],
        SettingsController.instance.timeUnit);
  }

  static Measurement money() {
    return Measurement(
        tr('money'),
        [
          Unit(tr('euro'), '€', 1),
          Unit(tr('uSDollar'), '\$', 1.09),
          Unit(tr('poundSterling'), '£', 0.86),
          Unit(tr('brazilianReal'), 'R\$', 5.4),
          Unit(tr('japaneseYen'), '¥', 159),
          Unit(tr('indianRupee'), '₹', 90.5),
          Unit(tr('australianDollar'), 'A\$', 1.69),
          Unit(tr('canadianDollar'), 'C\$', 1.47),
          Unit(tr('chineseYuanRMB'), '¥', 7.94),
          Unit(tr('southAfricanRand'), 'R', 20.84),
          Unit(tr('swissFranc'), 'CHF', 0.96),
        ],
        SettingsController.instance.priceUnit);
  }

  static Measurement distance() {
    return Measurement(
        tr('distance'),
        [
          Unit(tr('metre'), 'm', 1),
          Unit(tr('foot'), 'ft', 3.28084),
        ],
        SettingsController.instance.distanceUnit);
  }

  static Measurement amount() {
    return Measurement(
        tr('amount'),
        [
          Unit('None', '', 1),
        ],
        SettingsController.instance.amountUnit);
  }

  static num convert(num value, MeasurementType m){
    Measurement measurement = _getMeasurement(m);
    Unit selectedUnit = measurement.units[measurement.selectedUnit];

    return value * selectedUnit.conversionFactor;
  }

  static num convertBack(num value, MeasurementType m){
    Measurement measurement = _getMeasurement(m);
    Unit selectedUnit = measurement.units[measurement.selectedUnit];

    return value / selectedUnit.conversionFactor;
  }

  static TextSpan getValueAndUnit(num value, MeasurementType m) {
    Measurement measurement = _getMeasurement(m);
    Unit selectedUnit = measurement.units[measurement.selectedUnit];

    num convertedValue = value * selectedUnit.conversionFactor;
    String symbol = selectedUnit.symbol;

    NumberFormat nf;
    if (convertedValue < 0) {
      nf = NumberFormat('0.######', "en_US");
    } else if (convertedValue < 10) {
      nf = NumberFormat('#.##', "en_US");
    } else if (convertedValue < 100) {
      nf = NumberFormat('##.#', "en_US");
    } else if (convertedValue < 1000000) {
      nf = NumberFormat('###,###', "en_US");
    } else {
      nf = NumberFormat.compact(locale: "en_US");
    }

    return TextSpan(
      text: nf.format(convertedValue),
      style: const TextStyle(fontWeight: FontWeight.bold),
      children: [
        TextSpan(
          text: ' $symbol',
          style: const TextStyle(fontWeight: FontWeight.normal),
        )
      ],
    );
  }

  static String getUnitSymbol(MeasurementType m) {
    Measurement measurement = _getMeasurement(m);
    Unit selectedUnit = measurement.units[measurement.selectedUnit];

    return selectedUnit.symbol;
  }
}
