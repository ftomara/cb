import 'package:cb/Presentation/Screens/paintscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Addbutton extends StatelessWidget {
  const Addbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h, left: 25.w, right: 25.w),
      padding: EdgeInsets.symmetric(vertical: 8.h),
      width: 80.w,
      height: 80.h,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0XFF8842EC), width: 2),
          boxShadow: const [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                color: Color.fromARGB(64, 0, 0, 0)),
          ]),
      child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Paintscreen()));
          },
          splashColor: Colors.deepPurple[100],
          child: SvgPicture.asset("assets/add.svg")),
    );
  }
}
