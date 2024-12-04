import 'package:flutter/material.dart';

class Zoom extends StatelessWidget {
  const Zoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InteractiveViewer(
        maxScale: 10,
          child: Center(
        child: Image.asset('assets/image8.png', width: 200, height: 200),
      )),
    );
  }
}
