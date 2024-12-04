import 'package:cb/Presentation/Screens/paintscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 24.h, left: 25.w, right: 25.w),
      width: 361.w,
      height: 76.h,
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
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
                onTap: () {},
                splashColor: Colors.deepPurple[100],
                child: SvgPicture.asset("assets/profile.svg")),
            SizedBox(
              width: 64.w,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Paintscreen()));
                },
                splashColor: Colors.deepPurple[100],
                child: SvgPicture.asset("assets/add.svg")),
            SizedBox(
              width: 64.w,
            ),
            InkWell(
                onTap: () {},
                splashColor: Colors.deepPurple[100],
                child: SvgPicture.asset("assets/home.svg")),
          ]),
    );
  }
}
