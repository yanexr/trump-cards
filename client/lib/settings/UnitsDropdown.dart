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
        margin: const EdgeInsets.only(top: 20),
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
                        Text(Measurements.speed().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.speedUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateSpeedUnit(value);
                            });
                          },
                          items: Measurements.speed()
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
                        Text(Measurements.weight().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.weightUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateWeightUnit(value);
                            });
                          },
                          items: Measurements.weight()
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
                        Text(Measurements.time().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.timeUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance.updateTimeUnit(value);
                            });
                          },
                          items: Measurements.time()
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
                        Text(Measurements.money().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.priceUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updatePriceUnit(value);
                            });
                          },
                          items: Measurements.money()
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
                    // Distance
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.distance().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.distanceUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateDistanceUnit(value);
                            });
                          },
                          items: Measurements.distance()
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
                    // Amount
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        Text(Measurements.amount().name),
                        const Spacer(),
                        DropdownButton<int>(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          borderRadius: BorderRadius.circular(10),
                          value: SettingsController.instance.amountUnit,
                          onChanged: (value) {
                            setState(() {
                              SettingsController.instance
                                  .updateAmountUnit(value);
                            });
                          },
                          items: Measurements.amount()
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
