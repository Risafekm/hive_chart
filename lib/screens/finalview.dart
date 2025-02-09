// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:chart_project/provider/dropdown_provider.dart';
import 'package:chart_project/screens/widgets/barchart/barchart.dart';
import 'package:chart_project/screens/widgets/linechart/linechart.dart';
import 'package:chart_project/screens/widgets/piechart/piechart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinalView extends StatelessWidget {
  final String chartType;
  final List<String> xValue;
  final List<String> yValue;
  final List<String> percentage;

  const FinalView({
    Key? key,
    required this.chartType,
    required this.xValue,
    required this.yValue,
    required this.percentage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderDropDown>(context, listen: false);

    // Convert input lists to double lists, handling empty inputs gracefully
    List<double> yValues =
        yValue.map((e) => double.tryParse(e) ?? 0.0).toList();
    List<double> xValues =
        xValue.map((e) => double.tryParse(e) ?? 0.0).toList();

    Widget chartWidget;

    // Determine chart widget based on chartType
    switch (chartType) {
      case 'Line Chart 1':
      case 'Line Chart 2':
        chartWidget = xValues.isNotEmpty && yValues.isNotEmpty
            ? LineChartDatas(
                xValue: xValue,
                yValue: yValue,
              )
            : const SizedBox.shrink(); // Handle empty input gracefully
        break;
      case 'Bar Chart 1':
      case 'Bar Chart 2':
        chartWidget = xValues.isNotEmpty && yValues.isNotEmpty
            ? BarChartDatas(xValue: xValue, yValue: yValue)
            : const SizedBox.shrink(); // Handle empty input gracefully
        break;
      case 'Pie Chart 1':
      case 'Pie Chart 2':
        chartWidget = percentage.isNotEmpty
            ? PieChartDatas(percentage: percentage)
            : const SizedBox.shrink(); // Handle empty input gracefully
        break;
      default:
        chartWidget = const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          '$chartType ',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ),
      body: Center(
        child: SizedBox(
          height: 400,
          width: 500,
          child: chartWidget,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                child: const Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
