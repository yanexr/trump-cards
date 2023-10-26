import 'package:flutter/material.dart';
import 'package:trump_cards/gameCard/imageAttributionDialog.dart';
import '../gameCard/cards.dart';
import '../gameCard/measurementUnits.dart';
import '../data/cardDecks.dart';
import '../app.dart';
import 'gameCardWidget.dart';

/// Displays a list of SampleItems.
class GameCardFront extends StatefulWidget {
  final GameCard gameCard;
  final Function flipCard;
  final bool isSelectable;
  final SelectedCharacteristic selectedCharacteristic;
  final Color selectionColor;
  final Function(SelectedCharacteristic) onClick;
  final bool elevation;

  const GameCardFront(
      {super.key,
      required this.gameCard,
      required this.flipCard,
      required this.isSelectable,
      required this.selectedCharacteristic,
      required this.selectionColor,
      required this.onClick,
      required this.elevation});

  @override
  _GameCardFrontState createState() => _GameCardFrontState();
}

class _GameCardFrontState extends State<GameCardFront> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 5 / 8,
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(28)),
          boxShadow: widget.elevation
              ? [
                  const BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 0),
                      blurRadius: 15.0,
                      spreadRadius: -5.0)
                ]
              : [],
        ),
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              children: [
                MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      child: AspectRatio(
                          aspectRatio: 16 / 10,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox.fromSize(
                              child: widget.gameCard.id > 0
                                  ? Image.asset(
                                      'assets/images/${cardDecks[App.selectedCardDeck].name}/${widget.gameCard.imagePath}',
                                      fit: BoxFit.cover)
                                  : Image.network(widget.gameCard.imagePath,
                                      fit: BoxFit.cover, errorBuilder:
                                          (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                      return Image.asset(
                                          'assets/images/placeholder.png',
                                          fit: BoxFit.cover);
                                    }),
                            ),
                          )),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return ImageAttributionDialog(
                                  imageAttribution:
                                      widget.gameCard.imageAttribution,
                                  imageLicenseLink:
                                      widget.gameCard.imageLicenseLink);
                            });
                      },
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: () {
                              widget.flipCard();
                            },
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  widget.gameCard.title,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )),
                                const SizedBox(width: 10),
                                const Icon(
                                  Icons.info,
                                ),
                              ],
                            )))),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  margin: const EdgeInsets.only(bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.gameCard.subtitle,
                  ),
                ),
                Expanded(
                    child: MouseRegion(
                        cursor: widget.isSelectable
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.basic,
                        child: GestureDetector(
                            onTap: () {
                              widget.onClick(SelectedCharacteristic.v1);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: widget.selectedCharacteristic ==
                                        SelectedCharacteristic.v1
                                    ? widget.selectionColor
                                    : Theme.of(context).colorScheme.surface,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cardDecks[App.selectedCardDeck]
                                      .c1
                                      .getLabel()),
                                  Text.rich(Measurements.getValueAndUnit(
                                      widget.gameCard.value1,
                                      cardDecks[App.selectedCardDeck]
                                          .c1
                                          .measurementType))
                                ],
                              ),
                            )))),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: MouseRegion(
                        cursor: widget.isSelectable
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.basic,
                        child: GestureDetector(
                            onTap: () {
                              widget.onClick(SelectedCharacteristic.v2);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: widget.selectedCharacteristic ==
                                        SelectedCharacteristic.v2
                                    ? widget.selectionColor
                                    : Theme.of(context).colorScheme.surface,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cardDecks[App.selectedCardDeck]
                                      .c2
                                      .getLabel()),
                                  Text.rich(Measurements.getValueAndUnit(
                                      widget.gameCard.value2,
                                      cardDecks[App.selectedCardDeck]
                                          .c2
                                          .measurementType))
                                ],
                              ),
                            )))),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: MouseRegion(
                        cursor: widget.isSelectable
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.basic,
                        child: GestureDetector(
                            onTap: () {
                              widget.onClick(SelectedCharacteristic.v3);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: widget.selectedCharacteristic ==
                                        SelectedCharacteristic.v3
                                    ? widget.selectionColor
                                    : Theme.of(context).colorScheme.surface,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cardDecks[App.selectedCardDeck]
                                      .c3
                                      .getLabel()),
                                  Text.rich(Measurements.getValueAndUnit(
                                      widget.gameCard.value3,
                                      cardDecks[App.selectedCardDeck]
                                          .c3
                                          .measurementType))
                                ],
                              ),
                            )))),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: MouseRegion(
                        cursor: widget.isSelectable
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.basic,
                        child: GestureDetector(
                            onTap: () {
                              widget.onClick(SelectedCharacteristic.v4);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: widget.selectedCharacteristic ==
                                        SelectedCharacteristic.v4
                                    ? widget.selectionColor
                                    : Theme.of(context).colorScheme.surface,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cardDecks[App.selectedCardDeck]
                                      .c4
                                      .getLabel()),
                                  Text.rich(Measurements.getValueAndUnit(
                                      widget.gameCard.value4,
                                      cardDecks[App.selectedCardDeck]
                                          .c4
                                          .measurementType))
                                ],
                              ),
                            )))),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: MouseRegion(
                        cursor: widget.isSelectable
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.basic,
                        child: GestureDetector(
                            onTap: () {
                              widget.onClick(SelectedCharacteristic.v5);
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                              decoration: BoxDecoration(
                                color: widget.selectedCharacteristic ==
                                        SelectedCharacteristic.v5
                                    ? widget.selectionColor
                                    : Theme.of(context).colorScheme.surface,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cardDecks[App.selectedCardDeck]
                                      .c5
                                      .getLabel()),
                                  Text.rich(Measurements.getValueAndUnit(
                                      widget.gameCard.value5,
                                      cardDecks[App.selectedCardDeck]
                                          .c5
                                          .measurementType))
                                ],
                              ),
                            ))))
              ],
            )),
      ),
    );
  }
}
