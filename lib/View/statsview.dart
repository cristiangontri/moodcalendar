import 'dart:ffi';

import 'package:emotionscalendar/Model/statsmodel.dart';
import 'package:emotionscalendar/View/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatsView extends StatelessWidget {
  StatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Stats myStats = Stats();
    final List<ChartData> chartData = [
      ChartData("😊", myStats.getHappyDays()),
      ChartData("😴", myStats.getCalmDays()),
      ChartData("😭", myStats.getCryingDays()),
      ChartData("😡", myStats.getAngryDays()),
      ChartData("😞", myStats.getBadDays()),
      ChartData("🥰", myStats.getLovedDays()),
      ChartData("🤒", myStats.getSickDays()),
      ChartData("😐", myStats.getNeutralDays()),
    ];
    return Scaffold(
        backgroundColor: myBackgroundColor,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, bottom: 20.0, left: 10, right: 10),
          child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(
                      isInversed: true,
                      majorGridLines: const MajorGridLines(width: 0)),
                  primaryYAxis: NumericAxis(isVisible: false),
                  series: <ChartSeries>[
                    // Renders bar chart
                    BarSeries<ChartData, String>(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            myBackgroundColor,
                            Colors.teal,
                          ],
                        ),
                        color: myBackgroundColor,
                        width: 0.2,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.position,
                        yValueMapper: (ChartData data, _) => data.value)
                  ])),
        )));
  }
}

class ChartData {
  String position;
  int value;
  ChartData(this.position, this.value);
}
