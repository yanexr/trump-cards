import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:pie_chart/pie_chart.dart';

class Statistics extends StatelessWidget {
  const Statistics({
    super.key,
  });

  static const routeName = '/statistics';

  @override
  Widget build(BuildContext context) {
    final Map<String, double> dataMap = {
      '${tr('gamesWon')} (${App.wins})   ': App.wins.toDouble(),
      '${tr('gamesLost')} (${App.losses})': App.losses.toDouble(),
    };

    final colorList = <Color>[
      const Color.fromARGB(255, 73, 189, 117),
      Colors.redAccent,
    ];
    return Scaffold(
        appBar: AppBar(
          title: Text(tr('statistics')),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: (App.wins + App.losses) < 1
            ? Center(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.warning_amber_rounded),
                      const SizedBox(height: 20),
                      Text(
                        tr('noStatisticsYet'),
                        textAlign: TextAlign.center,
                      )
                    ])),
              )
            : SingleChildScrollView(
                child: Center(
                    child: Container(
                        constraints: const BoxConstraints(maxWidth: 800),
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            Card(
                              margin: const EdgeInsets.only(top: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 30),
                                child: Column(
                                  children: [
                                    Text(tr('winLossRatio'),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 20),
                                    PieChart(
                                      dataMap: dataMap,
                                      colorList: colorList,
                                      chartRadius: 300,
                                      legendOptions: const LegendOptions(
                                          showLegendsInRow: true,
                                          legendPosition:
                                              LegendPosition.bottom),
                                      chartValuesOptions:
                                          const ChartValuesOptions(
                                              showChartValuesInPercentage:
                                                  true),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 20),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 30),
                                child: Column(
                                  children: [
                                    Text(tr('points'),
                                        style: const TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            '${tr('totalPoints')}: ${App.pointsTotal}')
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                        '${tr('highestScore')}: ${App.pointsHighest}'),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )))));
  }
}
