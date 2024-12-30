import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/editor/deleteDialog.dart';

import '../editor/cardEditor.dart';
import '../app.dart';
import 'SingleCardView.dart';

enum SortedBy { name, subtitle, characteristic }

class ViewCards extends StatefulWidget {
  const ViewCards({super.key});

  static const routeName = '/cards';

  @override
  _ViewCards createState() => _ViewCards();
}

class _ViewCards extends State<ViewCards> {
  SortedBy sortedBy = SortedBy.name;
  String sortedByLabel = '${tr('name')} (A-Z)';
  int? characteristicSortIndex;

  @override
  void initState() {
    super.initState();
    App.selectedCardDeck!.cards.sort((a, b) => a.name.compareTo(b.name));
  }

  void sortCards() {
    switch (sortedBy) {
      case SortedBy.name:
        App.selectedCardDeck!.cards.sort((a, b) => a.name.compareTo(b.name));
        sortedByLabel = '${tr('name')} (A-Z)';
        break;

      case SortedBy.subtitle:
        App.selectedCardDeck!.cards
            .sort((a, b) => b.subtitle.compareTo(a.subtitle));
        sortedByLabel = tr('year');
        break;

      case SortedBy.characteristic:
        if (characteristicSortIndex != null) {
          final characteristic =
              App.selectedCardDeck!.characteristics[characteristicSortIndex!];
          // Sort by the selected characteristic’s value
          App.selectedCardDeck!.cards.sort((a, b) {
            final aVal = a.values[characteristicSortIndex!];
            final bVal = b.values[characteristicSortIndex!];
            if (characteristic.isHigherBetter) {
              // Higher is better, so sort descending
              return bVal.compareTo(aVal);
            } else {
              // Lower is better, so sort ascending
              return aVal.compareTo(bVal);
            }
          });
          sortedByLabel = tr(characteristic.label);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(tr(App.selectedCardDeck!.name)),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
            alignment: Alignment.topRight,
            child: PopupMenuButton<dynamic>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 70, 165, 243),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.sort_rounded, color: Colors.white),
                      const SizedBox(width: 10),
                      Text('${tr('sortBy')} $sortedByLabel',
                          style: const TextStyle(color: Colors.white)),
                    ],
                  )),
              itemBuilder: (BuildContext context) {
                final items = <PopupMenuEntry>[
                  PopupMenuItem(
                      value: const {'type': SortedBy.name},
                      child: Row(children: [
                        sortedBy == SortedBy.name &&
                                characteristicSortIndex == null
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text('${tr('name')} (A-Z)'),
                      ])),
                  PopupMenuItem(
                      value: const {'type': SortedBy.subtitle},
                      child: Row(children: [
                        sortedBy == SortedBy.subtitle
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text(tr('Subtitle')),
                      ])),
                ];

                items.add(const PopupMenuDivider());

                // Add characteristics to the menu
                for (int i = 0;
                    i < App.selectedCardDeck!.characteristics.length;
                    i++) {
                  final c = App.selectedCardDeck!.characteristics[i];
                  final isSelected = (sortedBy == SortedBy.characteristic &&
                      characteristicSortIndex == i);
                  items.add(PopupMenuItem(
                      value: {'type': SortedBy.characteristic, 'index': i},
                      child: Row(children: [
                        isSelected
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text(tr(c.label)),
                        const SizedBox(width: 5),
                        c.isHigherBetter
                            ? const Icon(Icons.arrow_upward_rounded)
                            : const Icon(Icons.arrow_downward_rounded),
                      ])));
                }

                return items;
              },
              onSelected: (value) {
                setState(() {
                  final map = value as Map;
                  sortedBy = map['type'];
                  if (sortedBy == SortedBy.characteristic) {
                    characteristicSortIndex = map['index'];
                  } else {
                    characteristicSortIndex = null;
                  }
                  sortCards();
                });
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          alignment: Alignment.bottomRight,
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.fromLTRB(0, 0, 40, 10),
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            onPressed: () async {
              await Navigator.pushNamed(context, '/card-editor');
              setState(() {
                // sort by name
                App.selectedCardDeck!.cards
                    .sort((a, b) => a.name.compareTo(b.name));
              });
            },
            child: const Icon(Icons.add, color: Colors.white),
          )),
      body: Center(
          child: App.selectedCardDeck!.cards.isNotEmpty
              ? ListView.builder(
                  itemCount: App.selectedCardDeck!.cards.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(children: [
                      SizedBox(height: index == 0 ? 10 : 0),
                      Container(
                          constraints: const BoxConstraints(maxWidth: 800),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 4, 12, 4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(App
                                          .selectedCardDeck!.cards[index].name),
                                      const SizedBox(height: 2),
                                      Opacity(
                                          opacity: 0.7,
                                          child: Text(
                                            App.selectedCardDeck!.cards[index]
                                                .subtitle,
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ))
                                    ],
                                  )),
                                  App.selectedCardDeck!.cards[index].id > 0
                                      ? const SizedBox(width: 0)
                                      : Center(
                                          child: Opacity(
                                              opacity: 0.6,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    onPressed: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (_) {
                                                            return DeleteDialog(
                                                              deleteFunction:
                                                                  () {
                                                                setState(() {
                                                                  CardEditor.deleteCard(App
                                                                      .selectedCardDeck!
                                                                      .cards[
                                                                          index]
                                                                      .id);
                                                                });
                                                              },
                                                              name: App
                                                                  .selectedCardDeck!
                                                                  .cards[index]
                                                                  .name,
                                                              title: tr(
                                                                  'Delete Card'),
                                                            );
                                                          });
                                                    },
                                                  ),
                                                  IconButton(
                                                      icon: const Icon(
                                                          Icons.edit_rounded),
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        CardEditor(
                                                                          gameCard: App
                                                                              .selectedCardDeck!
                                                                              .cards[index],
                                                                        )));
                                                      })
                                                ],
                                              )))
                                ],
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox.fromSize(
                                    child: App.selectedCardDeck!.cards[index]
                                            .imagePath
                                            .startsWith('http')
                                        ? Image.network(
                                            App.selectedCardDeck!.cards[index]
                                                .imagePath,
                                            fit: BoxFit.cover,
                                            height: 72,
                                            width: 72, errorBuilder:
                                                (BuildContext context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                            return Image.asset(
                                                'assets/images/placeholder.png',
                                                fit: BoxFit.cover,
                                                height: 72,
                                                width: 72);
                                          })
                                        : Image.asset(
                                            'assets/images/${App.selectedCardDeck!.name}/${App.selectedCardDeck!.cards[index].imagePath}',
                                            fit: BoxFit.cover,
                                            height: 72,
                                            width: 72,
                                          )),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SingleCardView(
                                            list: App.selectedCardDeck!.cards,
                                            index: index)));
                              },
                            ),
                          )),
                      SizedBox(
                          height:
                              index == App.selectedCardDeck!.cards.length - 1
                                  ? 100
                                  : 0)
                    ]);
                  })
              : Center(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(Icons.post_add_rounded),
                        const SizedBox(height: 20),
                        Text(
                          tr('Add cards to get started!'),
                          textAlign: TextAlign.center,
                        )
                      ])),
                )),
    );
  }
}
