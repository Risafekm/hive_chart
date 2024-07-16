import 'package:chart_project/models/barmodel/barmodel.dart';
import 'package:chart_project/models/linemodel/linemodel.dart';
import 'package:chart_project/models/piemodel/piemodel.dart';
import 'package:chart_project/screens/widgets/barchart/barchart_sample.dart';
import 'package:chart_project/screens/widgets/linechart/linechart_sample.dart';
import 'package:chart_project/screens/widgets/piechart/piechart_sample.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ProviderDropDown extends ChangeNotifier {
  var chartList = [
    'Line Chart 1',
    'Bar Chart 1',
    'Pie Chart 1',
    'Line Chart 2',
    'Bar Chart 2',
    'Pie Chart 2'
  ];

  var selectChart = 'Line Chart 1';

  var chartSample = const [
    LineChartSample(),
    BarChartSample(),
    PieChartSample(),
    LineChartSample(),
    BarChartSample(),
    PieChartSample(),
  ];

  TextEditingController xAxis = TextEditingController();
  TextEditingController yAxis = TextEditingController();
  TextEditingController percentage = TextEditingController();

  final Map<String, List<double>> _chartData = {};

  setChart(String value) {
    selectChart = value;
    notifyListeners();
  }

  List<double>? getChartData(String chartType) {
    return _chartData[chartType];
  }

  void updateChartData(String chartType, List<double> data) {
    try {
      _chartData[chartType] = data;
      notifyListeners();
    } catch (e) {
      print('Error update chart data: $e');
    }
  }

  void clearControllers() {
    xAxis.clear();
    yAxis.clear();
    percentage.clear();
  }

  List<double> parseInput(String input) {
    return input.split(',').map((e) => double.tryParse(e.trim()) ?? 0).toList();
  }

  final List<Box> _hiveBoxes = [];

  ProviderDropDown() {
    _openHiveBoxes();
  }

  void _openHiveBoxes() async {
    await Hive.openBox<LineModel>('lineCharts');
    await Hive.openBox<BarModel>('barCharts');
    await Hive.openBox<PieModel>('pieCharts');

    _hiveBoxes.addAll([
      Hive.box<LineModel>('lineCharts'),
      Hive.box<BarModel>('barCharts'),
      Hive.box<PieModel>('pieCharts'),
    ]);
  }

  Future<void> saveChart(String chartType, List<String> xValues,
      List<String> yValues, List<String> percentages) async {
    try {
      switch (chartType) {
        case 'Line Chart 1':
        case 'Line Chart 2':
          await _hiveBoxes[0].add(LineModel(
              chartType: chartType, xValue: xValues, yValue: yValues));
          break;
        case 'Bar Chart 1':
        case 'Bar Chart 2':
          await _hiveBoxes[1].add(
              BarModel(chartType: chartType, xValue: xValues, yValue: yValues));
          break;
        case 'Pie Chart 1':
        case 'Pie Chart 2':
          await _hiveBoxes[2]
              .add(PieModel(chartType: chartType, percentage: percentages));
          break;
        default:
          throw Exception('Unsupported chart type');
      }
    } catch (e) {
      print('Error saving chart: $e');
    }
  }

  List<LineModel> get lineCharts =>
      _hiveBoxes[0].values.toList().cast<LineModel>();
  List<BarModel> get barCharts =>
      _hiveBoxes[1].values.toList().cast<BarModel>();
  List<PieModel> get pieCharts =>
      _hiveBoxes[2].values.toList().cast<PieModel>();
}
