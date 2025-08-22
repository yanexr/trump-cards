import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../settings/settingsController.dart';
import '../gameCard/measurementUnits.dart';

class UnitsDropdown extends StatefulWidget {
  const UnitsDropdown({super.key});

  @override
  State<UnitsDropdown> createState() => _UnitsDropdownState();
}

class _UnitsDropdownState extends State<UnitsDropdown> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.list_alt_rounded),
                    const SizedBox(width: 20),
                    Text(
                      tr('measurementUnits'),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    const Divider(),
                    // Power
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.power().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.powerUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updatePowerUnit(value);
                            });
                          },
                          items: Measurements.power()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Force
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.force().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.forceUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateForceUnit(value);
                            });
                          },
                          items: Measurements.force()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Speed
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.velocity().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.velocityUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateVelocityUnit(value);
                            });
                          },
                          items: Measurements.velocity()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Time
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.mass().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.massUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateMassUnit(value);
                            });
                          },
                          items: Measurements.mass()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Clock time
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.clockTime().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.clockTimeUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance.updateClockTimeUnit(value);
                            });
                          },
                          items: Measurements.clockTime()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Calendar time
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.calendarTime().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.calendarTimeUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance.updateCalendarTimeUnit(value);
                            });
                          },
                          items: Measurements.calendarTime()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Price
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.currency().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.currencyUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateCurrencyUnit(value);
                            });
                          },
                          items: Measurements.currency()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Dimension
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.dimension().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.dimensionUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateDimensionUnit(value);
                            });
                          },
                          items: Measurements.dimension()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Long Distance
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.longDistance().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.longDistanceUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateLongDistanceUnit(value);
                            });
                          },
                          items: Measurements.longDistance()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Count
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.count().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.countUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateCountUnit(value);
                            });
                          },
                          items: Measurements.count()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Density
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.density().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.densityUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateDensityUnit(value);
                            });
                          },
                          items: Measurements.density()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // High Mass
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.highMass().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.highMassUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateHighMassUnit(value);
                            });
                          },
                          items: Measurements.highMass()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Percentage
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.percentage().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.percentageUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updatePercentageUnit(value);
                            });
                          },
                          items: Measurements.percentage()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Temperature
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.temperature().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.temperatureUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateTemperatureUnit(value);
                            });
                          },
                          items: Measurements.temperature()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const Divider(),
                    // Volume
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.volume().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.volumeUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateVolumeUnit(value);
                            });
                          },
                          items: Measurements.volume()
                              .units
                              .asMap()
                              .entries
                              .map((entry) {
                            return DropdownMenuItem(
                              value: entry.key,
                              child: Text(entry.value.name),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )));
  }
}
