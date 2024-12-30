import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/gameCard/gameCardWidget.dart';
import '../settings/settingsController.dart';

class CardDesignDropdown extends StatefulWidget {
  const CardDesignDropdown({super.key});

  @override
  State<CardDesignDropdown> createState() => _CardDesignDropdownState();
}

class _CardDesignDropdownState extends State<CardDesignDropdown> {
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              const RotatedBox(quarterTurns: 2, child: Icon(Icons.style)),
              const SizedBox(width: 20),
              Text(
                tr('Card Design'),
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              DropdownButton<int>(
                padding: const EdgeInsets.only(left: 10, right: 10),
                borderRadius: BorderRadius.circular(10),
                value: SettingsController.instance.cardDesign,
                onChanged: (value) {
                  setState(() {
                    SettingsController.instance.updateCardDesign(value);
                  });
                },
                items: GameCardStyle.styles.asMap().entries.map((entry) {
                  return DropdownMenuItem<int>(
                    value: entry.key,
                    child: Row(
                      children: [
                        Container(
                            width: 28,
                            height: 28,
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: (entry.value.borderContainerGradient ==
                                          null &&
                                      entry.value.borderContainerImage == null)
                                  ? Theme.of(context).colorScheme.surface
                                  : null,
                              gradient: entry.value.borderContainerGradient,
                              image: entry.value.borderContainerImage,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  entry.value.borderRadius == null
                                      ? 28
                                      : entry.value.borderRadius! * (4 / 3))),
                            ),
                            child: Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color:
                                    entry.value.innerContainerGradient == null
                                        ? Colors.black12
                                        : null,
                                gradient: entry.value.innerContainerGradient,
                                image: entry.value.innerContainerImage,
                                borderRadius: BorderRadius.all(Radius.circular(
                                    entry.value.borderRadius ?? 20)),
                              ),
                            )),
                        const SizedBox(width: 10),
                        Text(entry.value.name,
                            style: TextStyle(
                                fontFamily: entry.value.frontLabelFontFamily)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ));
  }
}
