import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../gameCard/cards.dart';
import '../gameCard/gameCardWidget.dart';

class SingleCardView extends StatefulWidget {
  final List<GameCard> list;
  final int index;
  const SingleCardView({super.key, required this.list, required this.index});

  static const routeName = '/cards';

  @override
  _SingleCardViewState createState() => _SingleCardViewState();
}

class _SingleCardViewState extends State<SingleCardView> {
  late PageController pageController;
  late int currentPage;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.index);
    currentPage = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.list[currentPage].name),
        ),
        body: Container(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (BuildContext context, int index) =>
                        Row(children: [
                      GameCardWidget(
                        gameCard: widget.list[index],
                      )
                    ]),
                    itemCount: widget.list.length,
                    controller: pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      height: 50,
                      minWidth: 140,
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(children: [
                        const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.white,
                        ),
                        Text(tr('previousCard'),
                            style: const TextStyle(color: Colors.white)),
                      ]),
                      onPressed: () {
                        if (pageController.page == 0) {
                          pageController.animateToPage(widget.list.length - 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        } else {
                          pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        }
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    MaterialButton(
                      height: 50,
                      minWidth: 140,
                      color: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(children: [
                        Text(tr('nextCard'),
                            style: const TextStyle(color: Colors.white)),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ]),
                      onPressed: () {
                        if (pageController.page == widget.list.length - 1) {
                          pageController.animateToPage(0,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        } else {
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        }
                      },
                    ),
                    const SizedBox(height: 50)
                  ],
                )
              ],
            )));
  }
}
