import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample extends StatelessWidget {
  const PieChartSample({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 14.0, bottom: 12),
            child: Text(
              'PieChart',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: 240,
              margin: const EdgeInsets.all(5),
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      value: 25,
                      color: Colors.orange,
                      title: '25%',
                    ),
                    PieChartSectionData(
                      value: 35,
                      color: Colors.pink,
                      title: '35%',
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: Colors.purple,
                      title: '20%',
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: Colors.cyan,
                      title: '20%',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
