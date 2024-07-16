// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'linemodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LineModelAdapter extends TypeAdapter<LineModel> {
  @override
  final int typeId = 0;

  @override
  LineModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LineModel(
      chartType: fields[0] as String,
      xValue: (fields[1] as List).cast<String>(),
      yValue: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, LineModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.chartType)
      ..writeByte(1)
      ..write(obj.xValue)
      ..writeByte(2)
      ..write(obj.yValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LineModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
