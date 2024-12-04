import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(MediaQuery.of(context).size.width, 100)),
        gradient: const LinearGradient(colors: [
          Color(0xFF8842EC),
          Color(0xFF8878CA),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "!اهلًا فريدة",
            style: GoogleFonts.notoSansArabic(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
          "عايزة  ترسمي اية النهاردة؟",
            style: GoogleFonts.notoSansArabic(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
