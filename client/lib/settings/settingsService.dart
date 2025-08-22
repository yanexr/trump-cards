import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<ThemeMode> loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeMode theme = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
    return theme;
  }

  Future<int> loadCardDesign() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int cardDesign = prefs.getInt('cardDesign') ?? 0;
    return cardDesign;
  }

  Future<int> loadPowerUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int powerUnit = prefs.getInt('powerUnit') ?? 0;
    return powerUnit;
  }

  Future<int> loadForceUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int forceUnit = prefs.getInt('forceUnit') ?? 0;
    return forceUnit;
  }

  Future<int> loadVelocityUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int velocityUnit = prefs.getInt('velocityUnit') ?? 0;
    return velocityUnit;
  }

  Future<int> loadMassUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int massUnit = prefs.getInt('massUnit') ?? 0;
    return massUnit;
  }

  Future<int> loadClockTimeUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int clockTimeUnit = prefs.getInt('clockTimeUnit') ?? 0;
    return clockTimeUnit;
  }

  Future<int> loadCalendarTimeUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int calendarTimeUnit = prefs.getInt('calendarTimeUnit') ?? 0;
    return calendarTimeUnit;
  }

  Future<int> loadCurrencyUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currencyUnit = prefs.getInt('currencyUnit') ?? 0;
    return currencyUnit;
  }

  Future<int> loadDimensionUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int dimensionUnit = prefs.getInt('dimensionUnit') ?? 0;
    return dimensionUnit;
  }

  Future<int> loadCountUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int countUnit = prefs.getInt('countUnit') ?? 0;
    return countUnit;
  }

  Future <int> loadDensityUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int densityUnit = prefs.getInt('densityUnit') ?? 0;
    return densityUnit;
  }

  Future <int> loadPercentageUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int percentageUnit = prefs.getInt('percentageUnit') ?? 0;
    return percentageUnit;
  }

  Future <int> loadTemperatureUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int temperatureUnit = prefs.getInt('temperatureUnit') ?? 0;
    return temperatureUnit;
  }

  Future <int> loadVolumeUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int volumeUnit = prefs.getInt('volumeUnit') ?? 0;
    return volumeUnit;
  }

  Future<int> loadLongDistanceUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int longDistanceUnit = prefs.getInt('longDistanceUnit') ?? 0;
    return longDistanceUnit;
  }

  Future<int> loadHighMassUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int highMassUnit = prefs.getInt('highMassUnit') ?? 0;
    return highMassUnit;
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', theme.index);
  }

  Future<void> updateCardDesign(int cardDesign) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('cardDesign', cardDesign);
  }

  Future<void> updatePowerUnit(int powerUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('powerUnit', powerUnit);
  }

  Future<void> updateForceUnit(int forceUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('forceUnit', forceUnit);
  }

  Future<void> updateVelocityUnit(int velocityUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('velocityUnit', velocityUnit);
  }

  Future<void> updateMassUnit(int massUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('massUnit', massUnit);
  }

  Future<void> updateClockTimeUnit(int clockTimeUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('clockTimeUnit', clockTimeUnit);
  }

  Future<void> updateCalendarTimeUnit(int calendarTimeUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('calendarTimeUnit', calendarTimeUnit);
  }

  Future<void> updateCurrencyUnit(int currencyUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currencyUnit', currencyUnit);
  }

  Future<void> updateDimensionUnit(int dimensionUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('dimensionUnit', dimensionUnit);
  }

  Future<void> updateCountUnit(int countUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('countUnit', countUnit);
  }

  Future<void> updateDensityUnit(int densityUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('densityUnit', densityUnit);
  }

  Future<void> updatePercentageUnit(int percentageUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('percentageUnit', percentageUnit);
  }

  Future<void> updateTemperatureUnit(int temperatureUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('temperatureUnit', temperatureUnit);
  }

  Future<void> updateVolumeUnit(int volumeUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('volumeUnit', volumeUnit);
  }

  Future<void> updateLongDistanceUnit(int longDistanceUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('longDistanceUnit', longDistanceUnit);
  }

  Future<void> updateHighMassUnit(int highMassUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highMassUnit', highMassUnit);
  }
}
