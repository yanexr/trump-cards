import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:trump_cards/cardEditor/deleteCardDialog.dart';

import '../data/cardDecks.dart';
import '../cardEditor/cardEditor.dart';
import '../app.dart';
import '../gameCard/cards.dart';
import 'SingleCardView.dart';

enum SortedBy { title, subtitle, value1, value2, value3, value4, value5 }

class ViewCards extends StatefulWidget {
  const ViewCards({super.key});

  static const routeName = '/view-cards';

  @override
  _ViewCards createState() => _ViewCards();
}

class _ViewCards extends State<ViewCards> {
  List<GameCard> list = cardDecks[App.selectedCardDeck].cards +
      cardDecks[App.selectedCardDeck].userCreatedCards;
  SortedBy sortedBy = SortedBy.title;
  String sortedByLabel = 'Name (A-Z)';

  @override
  void initState() {
    super.initState();
    list.sort((a, b) => a.title.compareTo(b.title));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(tr('viewCards')),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 10),
            alignment: Alignment.topRight,
            child: PopupMenuButton<SortedBy>(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(10)),
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
                return [
                  PopupMenuItem(
                      value: SortedBy.title,
                      child: Row(children: [
                        sortedBy == SortedBy.title
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text('${tr('name')} (A-Z)'),
                      ])),
                  PopupMenuItem(
                      value: SortedBy.subtitle,
                      child: Row(children: [
                        sortedBy == SortedBy.subtitle
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text(tr('year')),
                      ])),
                  PopupMenuItem(
                      value: SortedBy.value1,
                      child: Row(children: [
                        sortedBy == SortedBy.value1
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text(cardDecks[App.selectedCardDeck].c1.getLabel()),
                        const SizedBox(width: 5),
                        cardDecks[App.selectedCardDeck].c1.isHigherBetter
                            ? const Icon(Icons.arrow_upward_rounded)
                            : const Icon(Icons.arrow_downward_rounded),
                      ])),
                  PopupMenuItem(
                      value: SortedBy.value2,
                      child: Row(children: [
                        sortedBy == SortedBy.value2
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text(cardDecks[App.selectedCardDeck].c2.getLabel()),
                        const SizedBox(width: 5),
                        cardDecks[App.selectedCardDeck].c2.isHigherBetter
                            ? const Icon(Icons.arrow_upward_rounded)
                            : const Icon(Icons.arrow_downward_rounded),
                      ])),
                  PopupMenuItem(
                      value: SortedBy.value3,
                      child: Row(children: [
                        sortedBy == SortedBy.value3
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text(cardDecks[App.selectedCardDeck].c3.getLabel()),
                        const SizedBox(width: 5),
                        cardDecks[App.selectedCardDeck].c3.isHigherBetter
                            ? const Icon(Icons.arrow_upward_rounded)
                            : const Icon(Icons.arrow_downward_rounded),
                      ])),
                  PopupMenuItem(
                      value: SortedBy.value4,
                      child: Row(children: [
                        sortedBy == SortedBy.value4
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text(cardDecks[App.selectedCardDeck].c4.getLabel()),
                        const SizedBox(width: 5),
                        cardDecks[App.selectedCardDeck].c4.isHigherBetter
                            ? const Icon(Icons.arrow_upward_rounded)
                            : const Icon(Icons.arrow_downward_rounded),
                      ])),
                  PopupMenuItem(
                      value: SortedBy.value5,
                      child: Row(children: [
                        sortedBy == SortedBy.value5
                            ? const Icon(Icons.check)
                            : const Icon(
                                Icons.check,
                                color: Colors.transparent,
                              ),
                        const SizedBox(width: 10),
                        Text(cardDecks[App.selectedCardDeck].c5.getLabel()),
                        const SizedBox(width: 5),
                        cardDecks[App.selectedCardDeck].c5.isHigherBetter
                            ? const Icon(Icons.arrow_upward_rounded)
                            : const Icon(Icons.arrow_downward_rounded),
                      ])),
                ];
              },
              onSelected: (SortedBy value) {
                setState(() {
                  sortedBy = value;
                  switch (value) {
                    case SortedBy.title:
                      list.sort((a, b) => a.title.compareTo(b.title));
                      sortedByLabel = '${tr('name')} (A-Z)';
                      break;
                    case SortedBy.subtitle:
                      list.sort((a, b) => b.subtitle.compareTo(a.subtitle));
                      sortedByLabel = tr('year');
                      break;
                    case SortedBy.value1:
                      list.sort((a, b) =>
                          cardDecks[App.selectedCardDeck].c1.isHigherBetter
                              ? b.value1.compareTo(a.value1)
                              : a.value1.compareTo(b.value1));
                      sortedByLabel =
                          cardDecks[App.selectedCardDeck].c1.getLabel();
                      break;
                    case SortedBy.value2:
                      list.sort((a, b) =>
                          cardDecks[App.selectedCardDeck].c2.isHigherBetter
                              ? b.value2.compareTo(a.value2)
                              : a.value2.compareTo(b.value2));
                      sortedByLabel =
                          cardDecks[App.selectedCardDeck].c2.getLabel();
                      break;
                    case SortedBy.value3:
                      list.sort((a, b) =>
                          cardDecks[App.selectedCardDeck].c3.isHigherBetter
                              ? b.value3.compareTo(a.value3)
                              : a.value3.compareTo(b.value3));
                      sortedByLabel =
                          cardDecks[App.selectedCardDeck].c3.getLabel();
                      break;
                    case SortedBy.value4:
                      list.sort((a, b) =>
                          cardDecks[App.selectedCardDeck].c4.isHigherBetter
                              ? b.value4.compareTo(a.value4)
                              : a.value4.compareTo(b.value4));
                      sortedByLabel =
                          cardDecks[App.selectedCardDeck].c4.getLabel();
                      break;
                    case SortedBy.value5:
                      list.sort((a, b) =>
                          cardDecks[App.selectedCardDeck].c5.isHigherBetter
                              ? b.value5.compareTo(a.value5)
                              : a.value5.compareTo(b.value5));
                      sortedByLabel =
                          cardDecks[App.selectedCardDeck].c5.getLabel();
                      break;
                  }
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
            onPressed: () {
              Navigator.pushNamed(context, '/card-editor');
            },
            child: const Icon(Icons.add, color: Colors.white),
          )),
      body: Center(
          child: ListView.builder(
              itemCount: list.length,
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
                              const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(list[index].title),
                                  const SizedBox(height: 2),
                                  Opacity(
                                      opacity: 0.7,
                                      child: Text(
                                        list[index].subtitle,
                                        style: const TextStyle(fontSize: 14),
                                      ))
                                ],
                              )),
                              list[index].id > 0
                                  ? const SizedBox(width: 0)
                                  : Center(
                                      child: Opacity(
                                          opacity: 0.6,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.delete),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) {
                                                        return DeleteCardDialog(
                                                          deleteCard: () {
                                                            setState(() {
                                                              CardEditor
                                                                  .deleteCard(
                                                                      list[index]
                                                                          .id);
                                                              list.remove(
                                                                  list[index]);
                                                            });
                                                          },
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
                                                                      gameCard:
                                                                          list[
                                                                              index],
                                                                    )));
                                                  })
                                            ],
                                          )))
                            ],
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox.fromSize(
                              child: list[index].id > 0
                                  ? Image.asset(
                                      'assets/images/${cardDecks[App.selectedCardDeck].name}/${list[index].imagePath}',
                                      fit: BoxFit.cover,
                                      height: 50,
                                      width: 50,
                                    )
                                  : Image.network(list[index].imagePath,
                                      fit: BoxFit.cover, height: 50, width: 50,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                      return Image.asset(
                                          'assets/images/placeholder.png',
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 50);
                                    }),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SingleCardView(
                                        list: list, index: index)));
                          },
                        ),
                      )),
                  SizedBox(height: index == list.length - 1 ? 100 : 0)
                ]);
              })),
    );
  }
}
