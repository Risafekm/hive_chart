// ignore_for_file: unused_local_variable

import 'package:chart_project/models/barmodel/barmodel.dart';
import 'package:chart_project/models/linemodel/linemodel.dart';
import 'package:chart_project/models/piemodel/piemodel.dart';
import 'package:chart_project/provider/dropdown_provider.dart';
import 'package:chart_project/screens/view_chart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class SavedCharts extends StatelessWidget {
  const SavedCharts({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderDropDown>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Saved charts'),
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
                  Navigator.popUntil(context, (route) => route.isFirst);
                  provider.xAxis.clear();
                  provider.yAxis.clear();
                  provider.percentage.clear();
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
      body: SafeArea(
        child: FutureBuilder(
          future: Future.wait([
            Hive.openBox<LineModel>('lineCharts'),
            Hive.openBox<BarModel>('barCharts'),
            Hive.openBox<PieModel>('pieCharts'),
          ]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return ListView.builder(
                itemCount: Hive.box<LineModel>('lineCharts').length +
                    Hive.box<BarModel>('barCharts').length +
                    Hive.box<PieModel>('pieCharts').length,
                itemBuilder: (context, index) {
                  if (index < Hive.box<LineModel>('lineCharts').length) {
                    LineModel lineChart =
                        Hive.box<LineModel>('lineCharts').getAt(index)!;
                    return _buildListItem('Line Chart', lineChart.xValue,
                        lineChart.yValue, context);
                  } else if (index <
                      Hive.box<LineModel>('lineCharts').length +
                          Hive.box<BarModel>('barCharts').length) {
                    BarModel barChart = Hive.box<BarModel>('barCharts').getAt(
                        index - Hive.box<LineModel>('lineCharts').length)!;
                    return _buildListItem(
                        'Bar Chart', barChart.xValue, barChart.yValue, context);
                  } else {
                    PieModel pieChart = Hive.box<PieModel>('pieCharts').getAt(
                        index -
                            Hive.box<LineModel>('lineCharts').length -
                            Hive.box<BarModel>('barCharts').length)!;
                    return _buildListItem(
                        'Pie Chart', [], pieChart.percentage, context);
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildListItem(
      String chartType, List<String> xData, List<String> yData, context) {
    return Consumer<ProviderDropDown>(
      builder: (BuildContext context, ProviderDropDown value, Widget? child) {
        var provider = Provider.of<ProviderDropDown>(context, listen: false);

        return Card(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewChart(
                    chartType: provider.selectChart,
                    xValue: xData,
                    yValue: yData,
                    percentage: yData,
                  ),
                ),
              );
            },
            title: Text(
              chartType,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('X Data: ${xData.join(', ')}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal)),
                Text('Y Data: ${yData.join(', ')}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.normal)),
              ],
            ),
          ),
        );
      },
    );
  }
}
