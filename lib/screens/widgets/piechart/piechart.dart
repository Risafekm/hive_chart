import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PieChartDatas extends StatelessWidget {
  const PieChartDatas({
    super.key,
    required this.percentage,
  });
  final List<String> percentage;

  @override
  Widget build(BuildContext context) {
    List<double> xValues = percentage.map((e) => double.parse(e)).toList();

    List<Color> colorslist = [
      Colors.yellow,
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.pink,
      Colors.orange,
      Colors.lime,
    ];
    List<PieChartSectionData> spots = List.generate(
      xValues.length,
      (index) => PieChartSectionData(
        value: xValues[index],
        color: colorslist[index % colorslist.length],
      ),
    );
    return PieChart(
      swapAnimationDuration: const Duration(milliseconds: 7500),
      PieChartData(
        sections: spots,
      ),
    );
  }
}
