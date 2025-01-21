import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/gameCard/imageAttributionDialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../gameCard/cards.dart';
import '../gameCard/measurementUnits.dart';
import '../app.dart';
import 'gameCardWidget.dart';

class GameCardFront extends StatefulWidget {
  final GameCard gameCard;
  final Function flipCard;
  final bool isSelectable;
  final int selectedCharacteristic;
  // selectedCharacteristic: -1 means no selection, otherwise index of selected characteristic
  final Color selectionColor;
  final Function(int) onClick;
  final bool elevation;
  final GameCardDeck? deck;

  const GameCardFront({
    super.key,
    required this.gameCard,
    required this.flipCard,
    required this.isSelectable,
    required this.selectedCharacteristic,
    required this.selectionColor,
    required this.onClick,
    required this.elevation,
    this.deck,
  });

  @override
  _GameCardFrontState createState() => _GameCardFrontState();
}

class _GameCardFrontState extends State<GameCardFront> {
  @override
  Widget build(BuildContext context) {
    final deck = widget.deck ?? App.selectedCardDeck!;
    final characteristics = deck.characteristics;
    final values = widget.gameCard.values;
    final characteristicCount = characteristics.length;
    const outerMargin = 15.0;
    const innerPadding = 15.0;
    EdgeInsets containerPadding = EdgeInsets.symmetric(
        vertical: deck.characteristics.length <= 3 ? 15 : 0, horizontal: 14);
    const containerSpacing = 10.0;

    Widget buildCharacteristicContainer(int i, {bool isGrid = false}) {
      final characteristic = characteristics[i];
      final isSelected = widget.selectedCharacteristic == i;

      // Label text
      final labelText = AutoSizeText(
        tr(characteristic.label),
        style: TextStyle(
            fontSize: isGrid ? 14 : 16,
            color:
                isSelected ? Colors.white : GameCardStyle.style.frontLabelColor,
            fontFamily: GameCardStyle.style.frontLabelFontFamily),
        maxLines: 1,
        minFontSize: 8,
        overflow: TextOverflow.ellipsis,
      );

      // Value text
      final valueText = AutoSizeText.rich(
        Measurements.getValueAndUnit(
          values[i],
          characteristic.measurementType,
        ),
        style: TextStyle(
            fontSize: isGrid ? 18 : 16,
            color:
                isSelected ? Colors.white : GameCardStyle.style.frontValueColor,
            fontFamily: GameCardStyle.style.frontValueFontFamily),
        maxLines: 1,
        minFontSize: 8,
        overflow: TextOverflow.ellipsis,
      );

      return MouseRegion(
        cursor: widget.isSelectable
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: () => widget.onClick(i),
          child: ClipPath(
            clipper: GameCardStyle.style.isSlanted ? SlantedClipper() : null,
            child: Container(
              padding: containerPadding,
              decoration: BoxDecoration(
                color: isSelected
                    ? widget.selectionColor
                    : ((GameCardStyle.style.attributeContainerImage == null)
                        ? Theme.of(context).colorScheme.surface
                        : null),
                gradient: isSelected
                    ? null
                    : GameCardStyle.style.attributeContainerGradient,
                image: isSelected
                    ? null
                    : GameCardStyle.style.attributeContainerImage,
                borderRadius: BorderRadius.all(Radius.circular(
                    GameCardStyle.style.borderRadius == null
                        ? 10
                        : GameCardStyle.style.borderRadius! / 2)),
              ),
              child: isGrid
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        labelText,
                        const SizedBox(height: 5),
                        valueText,
                      ],
                    )
                  : LayoutBuilder(builder: (context, constraints) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: labelText),
                          const SizedBox(width: 8),
                          valueText,
                        ],
                      );
                    }),
            ),
          ),
        ),
      );
    }

    Widget buildCharacteristicsSection() {
      // No characteristics
      if (characteristicCount == 0) {
        return const SizedBox.shrink();
      }

      // If <=3: Show them as a simple column at the top
      if (characteristicCount <= 3) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: List.generate(characteristicCount, (i) {
            final widgetChar = buildCharacteristicContainer(i, isGrid: false);
            return Padding(
              padding: EdgeInsets.only(
                  bottom: i < characteristicCount - 1 ? containerSpacing : 0),
              child: widgetChar,
            );
          }),
        );
      }

      // Exactly 6: 3x2 grid filling all available space
      if (characteristicCount == 6) {
        return Expanded(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: containerSpacing, bottom: containerSpacing),
                        child: buildCharacteristicContainer(0, isGrid: true),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: containerSpacing),
                        child: buildCharacteristicContainer(1, isGrid: true),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: containerSpacing, bottom: containerSpacing),
                        child: buildCharacteristicContainer(2, isGrid: true),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(bottom: containerSpacing),
                        child: buildCharacteristicContainer(3, isGrid: true),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: containerSpacing),
                        child: buildCharacteristicContainer(4, isGrid: true),
                      ),
                    ),
                    Expanded(
                      child: buildCharacteristicContainer(5, isGrid: true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

      // More than 3 but less than 6: single column that fills space equally
      if (characteristicCount > 3 && characteristicCount < 6) {
        return Expanded(
          child: Column(
            children: [
              for (int i = 0; i < characteristicCount; i++) ...[
                Expanded(
                  child: buildCharacteristicContainer(i, isGrid: false),
                ),
                if (i < characteristicCount - 1)
                  const SizedBox(height: containerSpacing),
              ]
            ],
          ),
        );
      }

      // More than 6: scrollable list
      if (characteristicCount > 6) {
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(characteristicCount, (i) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom:
                          i < characteristicCount - 1 ? containerSpacing : 0),
                  child: SizedBox(
                    height: 60, // fixed height per item
                    child: buildCharacteristicContainer(i, isGrid: false),
                  ),
                );
              }),
            ),
          ),
        );
      }

      // Should never reach this point
      return const SizedBox.shrink();
    }

    return AspectRatio(
      aspectRatio: 5 / 8,
      child: Container(
        margin: const EdgeInsets.all(outerMargin),
        padding: const EdgeInsets.all(innerPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: (GameCardStyle.style.borderContainerGradient == null &&
                  GameCardStyle.style.borderContainerImage == null)
              ? Theme.of(context).colorScheme.surface
              : null,
          gradient: GameCardStyle.style.borderContainerGradient,
          image: GameCardStyle.style.borderContainerImage,
          borderRadius: BorderRadius.all(Radius.circular(
              GameCardStyle.style.borderRadius == null
                  ? 28
                  : GameCardStyle.style.borderRadius! * (4 / 3))),
          boxShadow: (widget.elevation && GameCardStyle.style.hasShadow)
              ? [
                  const BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0, 0),
                      blurRadius: 15.0,
                      spreadRadius: -5.0)
                ]
              : [],
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(innerPadding),
          decoration: BoxDecoration(
            color: GameCardStyle.style.innerContainerGradient == null
                ? Theme.of(context).scaffoldBackgroundColor
                : null,
            gradient: GameCardStyle.style.innerContainerGradient,
            image: GameCardStyle.style.innerContainerImage,
            borderRadius: BorderRadius.all(
                Radius.circular(GameCardStyle.style.borderRadius ?? 20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Semantics(
                label: "Show image attribution",
                button: true,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return ImageAttributionDialog(
                              imageAttribution: widget.gameCard.imageAttr,
                              imageLicenseLink: widget.gameCard.imageLic,
                            );
                          });
                    },
                    child: AspectRatio(
                      aspectRatio: 16 / 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            GameCardStyle.style.borderRadius == null
                                ? 10
                                : GameCardStyle.style.borderRadius! / 2),
                        child: ClipPath(
                          clipper: GameCardStyle.style.isSlanted
                              ? SlantedClipper()
                              : null,
                          child: SizedBox.fromSize(
                            child: widget.gameCard.imagePath.startsWith('http')
                                ? Image.network(
                                    widget.gameCard.imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(
                                        'assets/images/placeholder.png',
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  )
                                : Image.asset(
                                    'assets/images/${deck.name}/${widget.gameCard.imagePath}',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    widget.flipCard();
                  },
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.only(left: 10, right: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              widget.gameCard.name,
                              style: GameCardStyle.style.title,
                              maxLines: 1,
                              minFontSize: 16,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Icon(Icons.info,
                              color: GameCardStyle.style.frontLabelColor),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10),
                      margin: const EdgeInsets.only(top: 5, bottom: 15),
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        widget.gameCard.subtitle,
                        style: GameCardStyle.style.text,
                        maxLines: 3,
                        minFontSize: 12,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ]),
                ),
              ),
              buildCharacteristicsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class SlantedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double slope = 10;
    double bendHeight = 7;

    path.moveTo(slope, bendHeight / 2);
    // Top line with a bend in the middle
    path.lineTo(size.width * 0.1, bendHeight);
    path.lineTo(size.width, 0);

    // Bottom line with a bend in the middle
    path.lineTo(size.width - slope, size.height);
    path.lineTo(size.width * 0.7, size.height - bendHeight);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
