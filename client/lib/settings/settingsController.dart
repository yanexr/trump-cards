import 'package:flutter/material.dart';

import 'settingsService.dart';

class SettingsController with ChangeNotifier {
  SettingsController._(this._settingsService);

  static final instance = SettingsController._(SettingsService());
  final SettingsService _settingsService;

  late ThemeMode _themeMode;
  late int _powerUnit = 0;
  late int _forceUnit = 0;
  late int _speedUnit = 0;
  late int _weightUnit = 0;
  late int _timeUnit = 0;
  late int _priceUnit = 0;
  late int _distanceUnit = 0;
  late int _amountUnit = 0;

  // Allow Widgets to read the user setting.
  ThemeMode get themeMode => _themeMode;
  int get powerUnit => _powerUnit;
  int get forceUnit => _forceUnit;
  int get speedUnit => _speedUnit;
  int get weightUnit => _weightUnit;
  int get timeUnit => _timeUnit;
  int get priceUnit => _priceUnit;
  int get distanceUnit => _distanceUnit;
  int get amountUnit => _amountUnit;

  // Load the user's settings from the SettingsService.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.loadThemeMode();
    _powerUnit = await _settingsService.loadPowerUnit();
    _forceUnit = await _settingsService.loadForceUnit();
    _speedUnit = await _settingsService.loadSpeedUnit();
    _weightUnit = await _settingsService.loadWeightUnit();
    _timeUnit = await _settingsService.loadTimeUnit();
    _priceUnit = await _settingsService.loadPriceUnit();
    _distanceUnit = await _settingsService.loadDistanceUnit();
    _amountUnit = await _settingsService.loadAmountUnit();

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updatePowerUnit(int? newPowerUnit) async {
    if (newPowerUnit == null) return;
    if (newPowerUnit == _powerUnit) return;
    _powerUnit = newPowerUnit;
    notifyListeners();
    await _settingsService.updatePowerUnit(newPowerUnit);
  }

  Future<void> updateForceUnit(int? newForceUnit) async {
    if (newForceUnit == null) return;
    if (newForceUnit == _forceUnit) return;
    _forceUnit = newForceUnit;
    notifyListeners();
    await _settingsService.updateForceUnit(newForceUnit);
  }

  Future<void> updateSpeedUnit(int? newSpeedUnit) async {
    if (newSpeedUnit == null) return;
    if (newSpeedUnit == _speedUnit) return;
    _speedUnit = newSpeedUnit;
    notifyListeners();
    await _settingsService.updateSpeedUnit(newSpeedUnit);
  }

  Future<void> updateWeightUnit(int? newWeightUnit) async {
    if (newWeightUnit == null) return;
    if (newWeightUnit == _weightUnit) return;
    _weightUnit = newWeightUnit;
    notifyListeners();
    await _settingsService.updateWeightUnit(newWeightUnit);
  }

  Future<void> updateTimeUnit(int? newTimeUnit) async {
    if (newTimeUnit == null) return;
    if (newTimeUnit == _timeUnit) return;
    _timeUnit = newTimeUnit;
    notifyListeners();
    await _settingsService.updateTimeUnit(newTimeUnit);
  }

  Future<void> updatePriceUnit(int? newPriceUnit) async {
    if (newPriceUnit == null) return;
    if (newPriceUnit == _priceUnit) return;
    _priceUnit = newPriceUnit;
    notifyListeners();
    await _settingsService.updatePriceUnit(newPriceUnit);
  }

  Future<void> updateDistanceUnit(int? newDistanceUnit) async {
    if (newDistanceUnit == null) return;
    if (newDistanceUnit == _distanceUnit) return;
    _distanceUnit = newDistanceUnit;
    notifyListeners();
    await _settingsService.updateDistanceUnit(newDistanceUnit);
  }

  Future<void> updateAmountUnit(int? newAmountUnit) async {
    if (newAmountUnit == null) return;
    if (newAmountUnit == _amountUnit) return;
    _amountUnit = newAmountUnit;
    notifyListeners();
    await _settingsService.updateAmountUnit(newAmountUnit);
  }
}
