import 'dart:typed_data';
import 'package:cb/Data/hiveservices.dart';
import 'package:cb/Presentation/Screens/paintscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawingHistory extends StatefulWidget {
  const DrawingHistory({super.key});

  @override
  State<DrawingHistory> createState() => _DrawingHistoryState();
}

class _DrawingHistoryState extends State<DrawingHistory> {
  List<Uint8List> list = [];
  // List<List<Sketch>> sklist = [];
  Hiveservices hive = Hiveservices();
  @override
  initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    var images = await hive.getImages();
    // var sk =  await hive.getSketches();
    setState(() {
      list = images;
      // sklist = sk;
    });
  }

  void refreshImages() {
    _loadImages();
  }

  @override
  Widget build(BuildContext context) {
    refreshImages();
    return list.isNotEmpty
        ? ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              Uint8List image = list[index];
              return Container(
                margin: EdgeInsets.only(
                  top: 20.h,
                  right: 5.w,
                  left: 5.w,
                ), // Adjust margins
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Paintscreen(
                                  history: list[index],
                                  index: index,
                                  // list: sklist[index],
                                )));
                    // _loadImages();
                  },
                  splashColor: Colors.deepPurple[100],
                  child: Image.memory(
                    image,
                    width: 150.w,
                    fit: BoxFit.contain,
                  ),
                ),
              );
            },
          )
        : const SizedBox();
  }
}
