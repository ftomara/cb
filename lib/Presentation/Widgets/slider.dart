import 'package:cb/Logic/propertiescubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vertical_slider/vertical_slider.dart';

class MySlider extends StatefulWidget {
  MySlider({super.key, this.isEraser = false});
  bool isEraser = false;

  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  double _currentSliderValue = 3;
  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.isEraser
        ? context.read<Propertiescubit>().list[3]
        : context.read<Propertiescubit>().list[2];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "الحجم: ${_currentSliderValue.round()}",
          style: GoogleFonts.notoSansArabic(
              fontSize: 18,
              color: const Color(0XFF8B79CC),
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        VerticalSlider(
          value: _currentSliderValue,
          min: 1,
          max: 50,
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              if (!widget.isEraser) {
                context.read<Propertiescubit>().setstroke(_currentSliderValue);
              } else {
                context
                    .read<Propertiescubit>()
                    .setEraserstroke(_currentSliderValue);
              }
            });
            debugPrint("${_currentSliderValue.round()}");
          },
        ),
      ],
    );
  }
}
