// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sketch.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SketchAdapter extends TypeAdapter<Sketch> {
  @override
  final int typeId = 0;

  @override
  Sketch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Sketch(
      isEraser: fields[4] as bool,
      points: (fields[0] as List).cast<Offset>(),
      strokeColor: fields[3] as Color,
      strokeSize: fields[1] as double,
      estrokeSize: fields[2] as double,
      brushmode: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Sketch obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.points)
      ..writeByte(1)
      ..write(obj.strokeSize)
      ..writeByte(2)
      ..write(obj.estrokeSize)
      ..writeByte(3)
      ..write(obj.strokeColor)
      ..writeByte(4)
      ..write(obj.isEraser)
      ..writeByte(5)
      ..write(obj.brushmode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SketchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
