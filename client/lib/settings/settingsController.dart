import 'package:flutter/material.dart';

import 'settingsService.dart';

class SettingsController with ChangeNotifier {
  SettingsController._(this._settingsService);

  static final instance = SettingsController._(SettingsService());
  final SettingsService _settingsService;

  late ThemeMode _themeMode;
  late int _cardDesign = 0;
  late int _powerUnit = 0;
  late int _forceUnit = 0;
  late int _velocityUnit = 0;
  late int _massUnit = 0;
  late int _clockTimeUnit = 0;
  late int _calendarTimeUnit = 0;
  late int _currencyUnit = 0;
  late int _dimensionUnit = 0;
  late int _countUnit = 0;
  late int _densityUnit = 0;
  late int _percentageUnit = 0;
  late int _temperatureUnit = 0;
  late int _volumeUnit = 0;

  // Allow Widgets to read the user setting.
  ThemeMode get themeMode => _themeMode;
  int get cardDesign => _cardDesign;
  int get powerUnit => _powerUnit;
  int get forceUnit => _forceUnit;
  int get velocityUnit => _velocityUnit;
  int get massUnit => _massUnit;
  int get clockTimeUnit => _clockTimeUnit;
  int get calendarTimeUnit => _calendarTimeUnit;
  int get currencyUnit => _currencyUnit;
  int get dimensionUnit => _dimensionUnit;
  int get countUnit => _countUnit;
  int get densityUnit => _densityUnit;
  int get percentageUnit => _percentageUnit;
  int get temperatureUnit => _temperatureUnit;
  int get volumeUnit => _volumeUnit;

  // Load the user's settings from the SettingsService.
  Future<void> loadSettings() async {
    _themeMode = await _settingsService.loadThemeMode();
    _cardDesign = await _settingsService.loadCardDesign();
    _powerUnit = await _settingsService.loadPowerUnit();
    _forceUnit = await _settingsService.loadForceUnit();
    _velocityUnit = await _settingsService.loadVelocityUnit();
    _massUnit = await _settingsService.loadMassUnit();
    _clockTimeUnit = await _settingsService.loadClockTimeUnit();
    _calendarTimeUnit = await _settingsService.loadCalendarTimeUnit();
    _currencyUnit = await _settingsService.loadCurrencyUnit();
    _dimensionUnit = await _settingsService.loadDimensionUnit();
    _countUnit = await _settingsService.loadCountUnit();
    _densityUnit = await _settingsService.loadDensityUnit();
    _percentageUnit = await _settingsService.loadPercentageUnit();
    _temperatureUnit = await _settingsService.loadTemperatureUnit();
    _volumeUnit = await _settingsService.loadVolumeUnit();

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }

  Future<void> updateCardDesign(int? newCardDesign) async {
    if (newCardDesign == null) return;
    if (newCardDesign == _cardDesign) return;
    _cardDesign = newCardDesign;
    notifyListeners();
    await _settingsService.updateCardDesign(newCardDesign);
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

  Future<void> updateVelocityUnit(int? newVelocityUnit) async {
    if (newVelocityUnit == null) return;
    if (newVelocityUnit == _velocityUnit) return;
    _velocityUnit = newVelocityUnit;
    notifyListeners();
    await _settingsService.updateVelocityUnit(newVelocityUnit);
  }

  Future<void> updateMassUnit(int? newMassUnit) async {
    if (newMassUnit == null) return;
    if (newMassUnit == _massUnit) return;
    _massUnit = newMassUnit;
    notifyListeners();
    await _settingsService.updateMassUnit(newMassUnit);
  }

  Future<void> updateClockTimeUnit(int? newClockTimeUnit) async {
    if (newClockTimeUnit == null) return;
    if (newClockTimeUnit == _clockTimeUnit) return;
    _clockTimeUnit = newClockTimeUnit;
    notifyListeners();
    await _settingsService.updateClockTimeUnit(newClockTimeUnit);
  }

  Future<void> updateCalendarTimeUnit(int? newCalendarTimeUnit) async {
    if (newCalendarTimeUnit == null) return;
    if (newCalendarTimeUnit == _calendarTimeUnit) return;
    _calendarTimeUnit = newCalendarTimeUnit;
    notifyListeners();
    await _settingsService.updateCalendarTimeUnit(newCalendarTimeUnit);
  }

  Future<void> updateCurrencyUnit(int? newCurrencyUnit) async {
    if (newCurrencyUnit == null) return;
    if (newCurrencyUnit == _currencyUnit) return;
    _currencyUnit = newCurrencyUnit;
    notifyListeners();
    await _settingsService.updateCurrencyUnit(newCurrencyUnit);
  }

  Future<void> updateDimensionUnit(int? newDimensionUnit) async {
    if (newDimensionUnit == null) return;
    if (newDimensionUnit == _dimensionUnit) return;
    _dimensionUnit = newDimensionUnit;
    notifyListeners();
    await _settingsService.updateDimensionUnit(newDimensionUnit);
  }

  Future<void> updateCountUnit(int? newCountUnit) async {
    if (newCountUnit == null) return;
    if (newCountUnit == _countUnit) return;
    _countUnit = newCountUnit;
    notifyListeners();
    await _settingsService.updateCountUnit(newCountUnit);
  }

  Future<void> updateDensityUnit(int? newDensityUnit) async {
    if (newDensityUnit == null) return;
    if (newDensityUnit == _densityUnit) return;
    _densityUnit = newDensityUnit;
    notifyListeners();
    await _settingsService.updateDensityUnit(newDensityUnit);
  }

  Future<void> updatePercentageUnit(int? newPercentageUnit) async {
    if (newPercentageUnit == null) return;
    if (newPercentageUnit == _percentageUnit) return;
    _percentageUnit = newPercentageUnit;
    notifyListeners();
    await _settingsService.updatePercentageUnit(newPercentageUnit);
  }

  Future<void> updateTemperatureUnit(int? newTemperatureUnit) async {
    if (newTemperatureUnit == null) return;
    if (newTemperatureUnit == _temperatureUnit) return;
    _temperatureUnit = newTemperatureUnit;
    notifyListeners();
    await _settingsService.updateTemperatureUnit(newTemperatureUnit);
  }
  
  Future<void> updateVolumeUnit(int? newVolumeUnit) async {
    if (newVolumeUnit == null) return;
    if (newVolumeUnit == _volumeUnit) return;
    _volumeUnit = newVolumeUnit;
    notifyListeners();
    await _settingsService.updateVolumeUnit(newVolumeUnit);
  }
}
