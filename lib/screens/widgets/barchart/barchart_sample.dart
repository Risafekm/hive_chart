import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample extends StatelessWidget {
  const BarChartSample({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      margin: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 14.0, bottom: 6),
            child: Text(
              'BarChart',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 240,
              margin: const EdgeInsets.all(8),
              child: BarChart(
                BarChartData(
                  barGroups: [
                    BarChartGroupData(x: 0, barRods: [
                      BarChartRodData(fromY: 0, toY: 8, color: Colors.blue)
                    ]),
                    BarChartGroupData(x: 1, barRods: [
                      BarChartRodData(fromY: 0, toY: 10, color: Colors.red)
                    ]),
                    BarChartGroupData(x: 2, barRods: [
                      BarChartRodData(fromY: 0, toY: 14, color: Colors.green)
                    ]),
                    BarChartGroupData(x: 3, barRods: [
                      BarChartRodData(fromY: 0, toY: 15, color: Colors.yellow)
                    ]),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          return Text(value.toInt().toString());
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('A');
                            case 1:
                              return const Text('B');
                            case 2:
                              return const Text('C');
                            case 3:
                              return const Text('D');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
