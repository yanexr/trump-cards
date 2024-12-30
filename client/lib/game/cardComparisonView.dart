import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/app.dart';
import 'package:trump_cards/gameCard/imageAttributionDialog.dart';
import 'package:trump_cards/gameCard/measurementUnits.dart';

import '../gameCard/cards.dart';

class CardComparisonView extends StatelessWidget {
  final GameCard firstCard;
  final GameCard secondCard;

  const CardComparisonView(
      {Key? key, required this.firstCard, required this.secondCard})
      : super(key: key);

  static const routeName = '/compare-cards';

  @override
  Widget build(BuildContext context) {
    final deck = App.selectedCardDeck!;
    final characteristics = deck.characteristics;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Card Comparison'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                const SizedBox(height: 30),
                // Names Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        firstCard.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        secondCard.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Subtitles Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        firstCard.subtitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        secondCard.subtitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Images Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return ImageAttributionDialog(
                                  imageAttribution: firstCard.imageAttr,
                                  imageLicenseLink: firstCard.imageLic,
                                );
                              },
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: 16 / 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: firstCard.imagePath.startsWith('http')
                                  ? Image.network(firstCard.imagePath,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, _, __) {
                                      return Image.asset(
                                          'assets/images/placeholder.png',
                                          fit: BoxFit.cover);
                                    })
                                  : Image.asset(
                                      'assets/images/${deck.name}/${firstCard.imagePath}',
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return ImageAttributionDialog(
                                  imageAttribution: secondCard.imageAttr,
                                  imageLicenseLink: secondCard.imageLic,
                                );
                              },
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: 16 / 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: secondCard.imagePath.startsWith('http')
                                  ? Image.network(secondCard.imagePath,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, _, __) {
                                      return Image.asset(
                                          'assets/images/placeholder.png',
                                          fit: BoxFit.cover);
                                    })
                                  : Image.asset(
                                      'assets/images/${deck.name}/${secondCard.imagePath}',
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Attributes Table
                Column(
                  children: List.generate(characteristics.length, (index) {
                    final characteristic = characteristics[index];
                    final firstValue = firstCard.values[index];
                    final secondValue = secondCard.values[index];
                    final isHigherBetter = characteristic.isHigherBetter;

                    Color getValueColor(num first, num second) {
                      if (first == second) return Colors.orange;
                      return (first > second) == isHigherBetter
                          ? Colors.green
                          : Colors.red;
                    }

                    return Column(
                      children: [
                        // Characteristic label
                        Text(
                          tr(characteristic.label),
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 5),
                        // Values Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: getValueColor(
                                          firstValue, secondValue)),
                                  children: [
                                    Measurements.getValueAndUnit(firstValue,
                                        characteristic.measurementType),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: getValueColor(
                                          secondValue, firstValue)),
                                  children: [
                                    Measurements.getValueAndUnit(secondValue,
                                        characteristic.measurementType),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 32,
                          thickness: 1,
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
