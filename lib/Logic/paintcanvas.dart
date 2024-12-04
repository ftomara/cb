import 'package:cb/Data/sketch.dart';
import 'package:flutter/material.dart';

class PaintCanvas extends CustomPainter {
  List<Sketch> sketches = [];
  final double scale;
  final Offset offset;
  PaintCanvas({
    required this.scale,
    required this.offset,
    required this.sketches,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);
    if (sketches.isEmpty) return;
    // sketches.add(list);
    for (Sketch sk in sketches) {
      if (sk.points.isEmpty) continue;
      Paint paint = Paint()
        ..color = sk.isEraser ? Colors.white : sk.strokeColor
        ..strokeWidth = sk.isEraser ? sk.estrokeSize : sk.strokeSize
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      Path path = Path();
      Offset p1 = sk.points[0];
      Offset p2 = sk.points[sk.points.length - 1];
      Rect rect = Rect.fromPoints(p1, p2);
      path.moveTo(sk.points[0].dx, sk.points[0].dy);
      if (sk.brushmode == 1 || sk.isEraser) {
        for (int i = 1; i < sk.points.length; i++) {
          path.lineTo(sk.points[i].dx, sk.points[i].dy);
        }
        canvas.drawPath(path, paint);
      } else if (sk.brushmode == 2) {
        canvas.drawLine(p1, p2, paint);
      } else if (sk.brushmode == 3) {
        canvas.drawOval(rect, paint);
      } else {
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
