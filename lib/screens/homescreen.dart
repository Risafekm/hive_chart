import 'package:chart_project/provider/dropdown_provider.dart';
import 'package:chart_project/screens/saved_charts.dart';
import 'package:chart_project/screens/view_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderDropDown>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(child: Icon(Icons.show_chart)),
        ),
        title: const Text('Chart Patterns'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Dropdown area...
            Consumer<ProviderDropDown>(
              builder: (context, value, child) {
                return Padding(
                  padding:
                      const EdgeInsets.only(top: 40, left: 20.0, right: 10),
                  child: Container(
                    height: 60,
                    width: 170,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: DropdownButton(
                        style:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        underline: const SizedBox(),
                        value: provider.selectChart,
                        onChanged: (value) {
                          provider.setChart(value!);
                          provider.clearControllers();
                        },
                        items: provider.chartList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              },
            ),

            // TextField area...
            Container(
              height: 500,
              width: double.maxFinite,
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const SizedBox(height: 35),
                  const Text(
                    'Enter numbers using comma',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 10),
                  Consumer<ProviderDropDown>(
                    builder: (context, value, child) {
                      return SizedBox(
                        width: double.maxFinite,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (provider.selectChart == 'Pie Chart 1' ||
                                provider.selectChart == 'Pie Chart 2')
                              SizedBox(
                                height: 40,
                                width: 220,
                                child: TextField(
                                  controller: provider.percentage,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(),
                                    hintText: "Percentage",
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              )
                            else ...[
                              SizedBox(
                                height: 40,
                                width: 220,
                                child: TextField(
                                  controller: provider.xAxis,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(),
                                    hintText: "X values",
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                height: 40,
                                width: 220,
                                child: TextField(
                                  controller: provider.yAxis,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(fontSize: 16),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(),
                                    hintText: "Y values",
                                    hintStyle: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // Corresponding chart area...
                  Expanded(
                    child: SizedBox(
                      height: 300,
                      child: Consumer<ProviderDropDown>(
                        builder: (context, provider, child) {
                          int index =
                              provider.chartList.indexOf(provider.selectChart);
                          return provider.chartSample[index];
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // Bottom navigation area...
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: Consumer<ProviderDropDown>(
                builder: (BuildContext context, ProviderDropDown value,
                    Widget? child) {
                  return ElevatedButton(
                    onPressed: () {
                      List<String> xValues = [];
                      List<String> yValues = [];

                      if (provider.selectChart == 'Pie Chart 1' ||
                          provider.selectChart == 'Pie Chart 2') {
                        yValues = provider.percentage.text.split(',');
                      } else {
                        xValues = provider.xAxis.text.split(',');
                        yValues = provider.yAxis.text.split(',');
                      }

                      // Check if any required field is empty or lengths don't match
                      if ((provider.selectChart.contains('Pie') &&
                              yValues.isEmpty) ||
                          (!provider.selectChart.contains('Pie') &&
                              (xValues.isEmpty ||
                                  yValues.isEmpty ||
                                  xValues.length != yValues.length))) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('enter same length for x aix and y axis'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewChart(
                              chartType: provider.selectChart,
                              xValue: xValues,
                              yValue: yValues,
                              percentage: yValues,
                            ),
                          ),
                        );
                      }
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
                      'View Chart',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SavedCharts(),
                    ),
                  );
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
                  'Saved Charts',
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
