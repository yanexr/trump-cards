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
  velocity,
  mass,
  clockTime,
  calendarTime,
  currency,
  dimension,
  count,
  density,
  percentage,
  temperature,
  volume,
  longDistance,
  highMass
}

class Measurements {
  static Measurement _getMeasurement(MeasurementType m) {
    if (m == MeasurementType.power) {
      return power();
    } else if (m == MeasurementType.force) {
      return force();
    } else if (m == MeasurementType.velocity) {
      return velocity();
    } else if (m == MeasurementType.mass) {
      return mass();
    } else if (m == MeasurementType.clockTime) {
      return clockTime();
    } else if (m == MeasurementType.calendarTime) {
      return calendarTime();
    } else if (m == MeasurementType.currency) {
      return currency();
    } else if (m == MeasurementType.dimension) {
      return dimension();
    } else if (m == MeasurementType.count) {
      return count();
    } else if (m == MeasurementType.density) {
      return density();
    } else if (m == MeasurementType.percentage) {
      return percentage();
    } else if (m == MeasurementType.temperature) {
      return temperature();
    } else if (m == MeasurementType.volume) {
      return volume();
    } else if (m == MeasurementType.longDistance) {
      return longDistance();
    } else if (m == MeasurementType.highMass) {
      return highMass();
    } else {
      return count();
    }
  }

  static Measurement power() {
    return Measurement(
        tr('Power'),
        [
          Unit(tr('Kilowatt'), 'kW', 1),
          Unit(tr('Watt'), 'W', 1000),
          Unit(tr('Horsepower'), 'hp', 1.34102)
        ],
        SettingsController.instance.powerUnit);
  }

  static Measurement force() {
    return Measurement(
        tr('Force'),
        [
          Unit(tr('Kilonewton'), 'kN', 1),
          Unit(tr('Newton'), 'N', 1000),
          Unit(tr('Pound-force'), 'lbf', 224.809)
        ],
        SettingsController.instance.forceUnit);
  }

  static Measurement velocity() {
    return Measurement(
        tr('Velocity'),
        [
          Unit(tr('Kilometre per Hour'), 'km/h', 1),
          Unit(tr('Metre per Second'), 'm/s', 0.2777778),
          Unit(tr('Miles per Hour'), 'mph', 0.62137),
          Unit(tr('Feet per Second'), 'ft/s', 0.9113444),
          Unit(tr('Knot'), 'kn', 0.53996),
          Unit(tr('Mach'), 'Ma', 0.00082)
        ],
        SettingsController.instance.velocityUnit);
  }

  static Measurement mass() {
    return Measurement(
        tr('Mass'),
        [
          Unit(tr('Kilogram'), 'kg', 1),
          Unit(tr('Pound'), 'lb', 2.20462),
          // 1 kg = 5.02785e-31 solar masses (M☉)
          Unit(tr('Stellar Mass'), 'M☉', 5.02785e-31),
        ],
        SettingsController.instance.massUnit);
  }

  static Measurement clockTime() {
    return Measurement(
        tr('Clock Time'),
        [
          Unit(tr('Second'), 's', 1),
          Unit(tr('Minute'), 'min', 0.01667),
          Unit(tr('Hour'), 'h', 0.0002778)
        ],
        SettingsController.instance.clockTimeUnit);
  }

  static Measurement calendarTime() {
    return Measurement(
        tr('Calendar Time'),
        [
          Unit(tr('Year'), 'y', 1),
          Unit(tr('Month'), 'm', 12),
          Unit(tr('Day'), 'd', 365)
        ],
  SettingsController.instance.calendarTimeUnit);
  }

  static Measurement currency() {
    return Measurement(
        tr('Currency'),
        [
          Unit(tr('Euro'), '€', 1),
          Unit(tr('US Dollar'), '\$', 1.09),
          Unit(tr('Pound Sterling'), '£', 0.86),
          Unit(tr('Brazilian Real'), 'R\$', 5.4),
          Unit(tr('Japanese Yen'), '¥', 159),
          Unit(tr('Indian Rupee'), '₹', 90.5),
          Unit(tr('Australian Dollar'), 'A\$', 1.69),
          Unit(tr('Canadian Dollar'), 'C\$', 1.47),
          Unit(tr('Chinese Yuan (RMB)'), '¥', 7.94),
          Unit(tr('South African Rand'), 'R', 20.84),
          Unit(tr('Swiss Franc'), 'CHF', 0.96),
        ],
        SettingsController.instance.currencyUnit);
  }

  static Measurement dimension() {
    return Measurement(
        tr('Dimension'),
        [
          Unit(tr('Metre'), 'm', 1),
          Unit(tr('Foot'), 'ft', 3.28084),
          Unit(tr('Astronomical Unit'), 'AU', 6.68459e-12),
          Unit(tr('Light Year'), 'ly', 1.057e-16),
        ],
        SettingsController.instance.dimensionUnit);
  }

  static Measurement longDistance() {
    // Same units as Dimension, but default (first) is Light Year, then AU, then m, then ft
    return Measurement(
        tr('Long Distance'),
        [
          Unit(tr('Light Year'), 'ly', 1.057e-16),
          Unit(tr('Astronomical Unit'), 'AU', 6.68459e-12),
          Unit(tr('Metre'), 'm', 1),
          Unit(tr('Foot'), 'ft', 3.28084),
        ],
        SettingsController.instance.longDistanceUnit);
  }

  static Measurement count() {
    return Measurement(
        tr('Count'),
        [
          Unit(tr('None'), '', 1),
        ],
        SettingsController.instance.countUnit);
  }

  static Measurement density() {
    return Measurement(
        tr('Density'),
        [
          Unit(tr('Per Square Kilometre'), '/km²', 1),
          Unit(tr('Per Square Mile'), '/mi²', 2.59),
          Unit(tr('Per Hectare'), '/ha', 0.01),
        ],
        SettingsController.instance.densityUnit);
  }

  static Measurement percentage() {
    return Measurement(
        tr('Percentage'),
        [
          Unit(tr('Percent'), '%', 1),
          Unit(tr('Permille'), '‰', 10),
        ],
        0);
  }

  static Measurement temperature() {
    return Measurement(
        tr('Temperature'),
        [
          Unit(tr('Celsius'), '°C', 1),
          Unit(tr('Fahrenheit'), '°F', 33.8),
          Unit(tr('Kelvin'), 'K', 274.15),
        ],
        0);
  }

  static Measurement volume() {
    return Measurement(
        tr('Volume'),
        [
          Unit(tr('Cubic Metre'), 'm³', 1),
          Unit(tr('Cubic Foot'), 'ft³', 35.3147),
          Unit(tr('Gallon'), 'gal', 264.172),
          Unit(tr('Litre'), 'l', 1000),
        ],
        0);
  }

  static Measurement highMass() {
    // Same units as Mass, but default (first) is Stellar Mass
    return Measurement(
        tr('High Mass'),
        [
          Unit(tr('Stellar Mass'), 'M☉', 5.02785e-31),
          Unit(tr('Kilogram'), 'kg', 1),
          Unit(tr('Pound'), 'lb', 2.20462),
        ],
        SettingsController.instance.highMassUnit);
  }

  static num convert(num value, MeasurementType m) {
    Measurement measurement = _getMeasurement(m);
    Unit selectedUnit = measurement.units[measurement.selectedUnit];

    return value * selectedUnit.conversionFactor;
  }

  static num convertBack(num value, MeasurementType m) {
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
      children: [
        TextSpan(
          text: nf.format(convertedValue),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        if (symbol.isNotEmpty)
          TextSpan(
            text: ' $symbol',
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
      ],
    );
  }

  static String getUnitSymbol(MeasurementType m) {
    Measurement measurement = _getMeasurement(m);
    Unit selectedUnit = measurement.units[measurement.selectedUnit];
    return selectedUnit.symbol;
  }

  static String measurementTypeToString(MeasurementType mt) {
    Measurement m = _getMeasurement(mt);
    if (m.name == 'count') return tr('Count (none)');
    return '${m.name[0].toUpperCase()}${m.name.substring(1)} (${m.units.map((e) => e.symbol).join(', ')})';
  }

  static String getDefaultUnit(MeasurementType mt) {
    Measurement m = _getMeasurement(mt);
    String s = m.units[0].symbol;
    return s.isNotEmpty ? '($s)' : '';
  }
}
