import 'package:hive/hive.dart';

part 'linemodel.g.dart';

@HiveType(typeId: 0)
class LineModel extends HiveObject {
  @HiveField(0)
  late String chartType;

  @HiveField(1)
  late List<String> xValue;

  @HiveField(2)
  late List<String> yValue;

  LineModel(
      {required this.chartType, required this.xValue, required this.yValue});
}
