import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'data/cardDecks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app.dart';

class About extends StatelessWidget {
  const About({
    super.key,
  });

  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(tr('about')),
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset('assets/images/trump-cards-logo-shadow.png', height: 170),
                Text(
                  tr('appTitle'),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Text(
                  'v1.2.0',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          launchUrl(Uri.parse(
                              'https://sites.google.com/view/trump-quartet-privacy-policy'));
                        },
                        child: const Row(
                          children: [
                            Text(
                              'Privacy',
                            ),
                            Icon(
                              Icons.open_in_new_rounded,
                              size: 14,
                            ),
                          ],
                        )),
                    const SizedBox(width: 10),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        onPressed: () {
                          launchUrl(Uri.parse(
                              'https://github.com/yanexr/trump-cards'));
                        },
                        child: const Row(
                          children: [
                            Text(
                              'GitHub',
                            ),
                            Icon(
                              Icons.open_in_new_rounded,
                              size: 14,
                            ),
                          ],
                        )),
                  ],
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 800),
                  margin: const EdgeInsets.fromLTRB(10, 30, 10, 20),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(20.0))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.rate_review,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Text(
                              tr('feedback'),
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              tr('feedbackText'),
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            MaterialButton(
                              height: 50,
                              color: Theme.of(context).colorScheme.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              onPressed: () {
                                launchUrl(Uri.parse(
                                    'https://play.google.com/store/apps/details?id=com.yedesign.card_game'));
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    tr('rateApp'),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const Icon(
                                    Icons.open_in_new_rounded,
                                    size: 16,
                                    color: Colors.white70,
                                  )
                                ],
                              ),
                            ),
                          ]))
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              String image =
                  'assets/images/${cardDecks[App.selectedCardDeck].name}/${cardDecks[App.selectedCardDeck].cards[index].imagePath}';
              String attribution =
                  cardDecks[App.selectedCardDeck].cards[index].imageAttribution;
              String license =
                  cardDecks[App.selectedCardDeck].cards[index].imageLicenseLink;
              return Column(children: [
                Container(
                    constraints: const BoxConstraints(maxWidth: 800),
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: index == 0
                        ? const EdgeInsets.only(top: 20)
                        : index ==
                                cardDecks[App.selectedCardDeck].cards.length - 1
                            ? const EdgeInsets.only(bottom: 20)
                            : null,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: index == 0
                          ? const BorderRadius.vertical(
                              top: Radius.circular(20))
                          : index ==
                                  cardDecks[App.selectedCardDeck].cards.length -
                                      1
                              ? const BorderRadius.vertical(
                                  bottom: Radius.circular(20))
                              : null,
                    ),
                    child: Column(children: [
                      ListTile(
                        leading: Image.asset(
                          image,
                          width: 100,
                          alignment: Alignment.centerRight,
                        ),
                        title: Text(attribution),
                        subtitle: license != ''
                            ? MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () {
                                    launchUrl(Uri.parse(license));
                                  },
                                  child: Text(
                                    license,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ))
                            : null,
                      ),
                      const Divider(
                        height: 20,
                        indent: 20,
                        endIndent: 20,
                      )
                    ]))
              ]);
            }, childCount: cardDecks[App.selectedCardDeck].cards.length),
          )
        ]));
  }
}
