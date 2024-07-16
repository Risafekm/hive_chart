// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'piemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PieModelAdapter extends TypeAdapter<PieModel> {
  @override
  final int typeId = 2;

  @override
  PieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PieModel(
      chartType: fields[0] as String,
      percentage: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PieModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.chartType)
      ..writeByte(1)
      ..write(obj.percentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
