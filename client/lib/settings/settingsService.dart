import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  Future<ThemeMode> loadThemeMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    ThemeMode theme = ThemeMode.values[prefs.getInt('themeMode') ?? 0];
    return theme;
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

  Future<int> loadSpeedUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int speedUnit = prefs.getInt('speedUnit') ?? 0;
    return speedUnit;
  }

  Future<int> loadWeightUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int weightUnit = prefs.getInt('weightUnit') ?? 0;
    return weightUnit;
  }

  Future<int> loadTimeUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int timeUnit = prefs.getInt('timeUnit') ?? 0;
    return timeUnit;
  }

  Future<int> loadPriceUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int priceUnit = prefs.getInt('priceUnit') ?? 0;
    return priceUnit;
  }

  Future<int> loadDistanceUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int distanceUnit = prefs.getInt('distanceUnit') ?? 0;
    return distanceUnit;
  }

  Future<int> loadAmountUnit() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int amountUnit = prefs.getInt('amountUnit') ?? 0;
    return amountUnit;
  }

  Future<void> updateThemeMode(ThemeMode theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', theme.index);
  }

  Future<void> updatePowerUnit(int powerUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('powerUnit', powerUnit);
  }

  Future<void> updateForceUnit(int forceUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('forceUnit', forceUnit);
  }

  Future<void> updateSpeedUnit(int speedUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('speedUnit', speedUnit);
  }

  Future<void> updateWeightUnit(int weightUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('weightUnit', weightUnit);
  }

  Future<void> updateTimeUnit(int timeUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('timeUnit', timeUnit);
  }

  Future<void> updatePriceUnit(int priceUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('priceUnit', priceUnit);
  }

  Future<void> updateDistanceUnit(int distanceUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('distanceUnit', distanceUnit);
  }

  Future<void> updateAmountUnit(int amountUnit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('amountUnit', amountUnit);
  }
}
