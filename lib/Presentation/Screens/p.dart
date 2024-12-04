import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class P extends StatefulWidget {
  const P({super.key});

  @override
  State<P> createState() => _PState();
}

class _PState extends State<P> {
  double _scale = 1.0;
  double _prevScale = 1.0;
  Offset _offset = Offset.zero;
  Offset _initialFocalPoint = Offset.zero;
  bool _isScaling = false;
  final List<Offset> _points = [];

  Offset transformCoordinate(Offset point) {
    // Apply inverse scaling and offset to point
    return (point - _offset) / _scale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Zoom and Draw")),
      body: GestureDetector(
        onScaleStart: (details) {
          _initialFocalPoint = details.focalPoint;
          _prevScale = _scale;
          setState(() {
            _isScaling = details.pointerCount > 1; // Detect multi-touch
          });
        },
        onScaleUpdate: (details) {
          setState(() {
            if (_isScaling) {
              // Update scale and offset for zoom
              _scale = _prevScale * details.scale;
              _offset += (details.focalPoint - _initialFocalPoint) / _scale;
              _initialFocalPoint = details.focalPoint;
            } else {
              // Add new transformed point to points list for drawing
              _points.add(transformCoordinate(details.localFocalPoint));
            }
          });
        },
        onScaleEnd: (details) {
          setState(() {
            _isScaling = false;
          });
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: _CanvasPainter(_points, _scale, _offset),
        ),
      ),
    );
  }
}

class _CanvasPainter extends CustomPainter {
  final List<Offset> points;
  final double scale;
  final Offset offset;

  _CanvasPainter(this.points, this.scale, this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    // Apply scaling and translation transformations
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(scale);

    // Draw points or paths
    final paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
