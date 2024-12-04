import 'package:cb/Presentation/Screens/paintscreen.dart';
import 'package:flutter/material.dart';

class ColoringPages extends StatelessWidget {
  ColoringPages({super.key});
  List<String> list = [
    "assets/image9.png",
    "assets/image3.png",
    "assets/image8.png",
    "assets/image10.png",
    "assets/image11.png",
    "assets/image2.png",
    "assets/image5.png",
    "assets/image6.png",
    "assets/image7.png",
    "assets/image1.png",
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Paintscreen(impath: list[index])));
          },
          splashColor: Colors.deepPurple[100],
          child: Image.asset(list[index]),
        );
      },
      itemCount: list.length,
    );
  }
}
