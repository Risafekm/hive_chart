// ignore_for_file: avoid_print

import 'package:chart_project/models/barmodel/barmodel.dart';
import 'package:chart_project/models/linemodel/linemodel.dart';
import 'package:chart_project/models/piemodel/piemodel.dart';
import 'package:chart_project/provider/dropdown_provider.dart';
import 'package:chart_project/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:provider/provider.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Hive.initFlutter();
    Hive.registerAdapter(LineModelAdapter());
    Hive.registerAdapter(BarModelAdapter());
    Hive.registerAdapter(PieModelAdapter());

    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Hive: $e');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderDropDown()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
