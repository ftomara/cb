
import 'package:cb/Presentation/Widgets/addbutton.dart';
import 'package:cb/Presentation/Widgets/appbar.dart';
import 'package:cb/Presentation/Widgets/coloring_pages.dart';
import 'package:cb/Presentation/Widgets/drawing_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {

  bool box = Hive.box("IMbox").isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const Appbar(),
                box == true
                    ? SizedBox(
                        height:
                            150.h, // Adjust height as needed for DrawingHistory
                        child: const DrawingHistory(),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 700
                      .h, // Set a height to make ColoringPages part of the scrollable content
                  child: ColoringPages(),
                ),
              ],
            ),
          ),
          const Positioned(bottom: -4, right: -10, child: Addbutton())
        ],
      ),
      // bottomNavigationBar:
    );
  }
}
