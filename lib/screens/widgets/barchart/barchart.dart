import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartDatas extends StatelessWidget {
  const BarChartDatas({super.key, required this.xValue, required this.yValue});
  final List<String> xValue;
  final List<String> yValue;

  @override
  Widget build(BuildContext context) {
    List<double> xValues = xValue.map((e) => double.parse(e)).toList();
    List<double> yValues = yValue.map((e) => double.parse(e)).toList();

    List<BarChartGroupData> spots = List.generate(
      xValues.length,
      (index) => BarChartGroupData(
        x: index,
        barRods: [BarChartRodData(toY: yValues[index])],
      ),
    );

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bar Chart'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChart(
          BarChartData(
            minY: 0,
            barGroups: spots,
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: true),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    int index = value.toInt();
                    if (index < 0 || index >= xValues.length) {
                      return Container();
                    }
                    return Text(xValue[index]);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
