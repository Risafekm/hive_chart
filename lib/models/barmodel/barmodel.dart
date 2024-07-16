import 'package:hive/hive.dart';

part 'barmodel.g.dart';

@HiveType(typeId: 1)
class BarModel extends HiveObject {
  @HiveField(0)
  late String chartType;

  @HiveField(1)
  late List<String> xValue;

  @HiveField(2)
  late List<String> yValue;

  BarModel(
      {required this.chartType, required this.xValue, required this.yValue});
}
