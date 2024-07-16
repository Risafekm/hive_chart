// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LineChartDatas extends StatelessWidget {
  LineChartDatas({super.key, required this.xValue, required this.yValue});
  final List<String> xValue;
  final List<String> yValue;

  @override
  Widget build(BuildContext context) {
    List<double> xValues = xValue.map((e) => double.parse(e)).toList();

    List<double> yValues = yValue.map((e) => double.parse(e)).toList();

    List<FlSpot> spots = List.generate(
      xValues.length,
      (index) => FlSpot(xValues[index], yValues[index]),
    );

    return LineChart(
      LineChartData(
          minX: 0,
          minY: 0,
          maxX: 100,
          maxY: 100,
          gridData: FlGridData(
              show: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.red,
                  strokeWidth: 1,
                );
              },
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.blue,
                  strokeWidth: 1,
                );
              }),
          borderData: FlBorderData(
            show: true,
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
            ),
          ]),
    );
  }
}
