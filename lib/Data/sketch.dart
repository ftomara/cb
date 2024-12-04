import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'sketch.g.dart';
@HiveType(typeId: 0)
class Sketch extends HiveObject {
  @HiveField(0)
  List<Offset> points = [];
  @HiveField(1)
  double strokeSize = 0.0;
  @HiveField(2)
  double estrokeSize = 0.0;
  @HiveField(3)
  Color strokeColor = Colors.black;
  @HiveField(4)
  bool isEraser = false;
  @HiveField(5)
  int brushmode = 1;
  Sketch({
    this.isEraser = false,
    required this.points,
    this.strokeColor = Colors.black,
    this.strokeSize = 3,
    this.estrokeSize = 5,
    this.brushmode = 1,
  });
  //1 brush , 2 line , 3 circle , 4 rectangle

  Map<String, dynamic> toJson() {
    return {
      'points':
          points.map((point) => {'dx': point.dx, 'dy': point.dy}).toList(),
      'strokeSize': strokeSize,
      'estrokeSize': estrokeSize,
      'strokeColor':
          strokeColor.value, // Use the integer representation of color
      'isEraser': isEraser,
      'brushmode': brushmode,
    };
  }

  // Method to convert JSON to a Sketch object
  static Sketch fromJson(Map<String, dynamic> json) {
    return Sketch(
      points: (json['points'] as List)
          .map((point) => Offset(point['dx'], point['dy']))
          .toList(),
      strokeSize: json['strokeSize'] ?? 3.0,
      estrokeSize: json['estrokeSize'] ?? 5.0,
      strokeColor: Color(json['strokeColor'] ?? Colors.black.value),
      isEraser: json['isEraser'] ?? false,
      brushmode: json['brushmode'] ?? 1,
    );
  }
}
