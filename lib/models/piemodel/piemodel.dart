import 'package:hive/hive.dart';

part 'piemodel.g.dart';

@HiveType(typeId: 2)
class PieModel extends HiveObject {
  @HiveField(0)
  late String chartType;

  @HiveField(1)
  late List<String> percentage;

  PieModel({required this.chartType, required this.percentage});
}
