import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class OffsetAdapter extends TypeAdapter<Offset> {
  @override
  final typeId = 1;

  @override
  Offset read(BinaryReader reader) {
    final value = reader.readMap();
    final dx = value['dx'] as double;
    final dy = value['dy'] as double;

    return Offset(dx, dy);
  }

  @override
  void write(BinaryWriter writer, Offset obj) {
    writer.writeMap({
      'dx': obj.dx,
      'dy': obj.dy,
    });
  }
}