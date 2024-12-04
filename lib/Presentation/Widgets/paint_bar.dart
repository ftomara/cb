
import 'package:cb/Logic/propertiescubit.dart';
import 'package:cb/Logic/undo_redo_cubit.dart';
import 'package:cb/Presentation/Widgets/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PaintBar extends StatefulWidget {
  const PaintBar({super.key});

  @override
  State<PaintBar> createState() => _PaintBarState();
}

class _PaintBarState extends State<PaintBar> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);
  bool picked = false;
  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {
                    context.read<UndoRedoCubit>().undo();
                  },
                  highlightColor: const Color.fromARGB(255, 221, 213, 248),
                  icon: const Icon(Icons.undo_outlined,
                      color: Color(0XFF8B79CC), size: 40)),
              IconButton(
                  onPressed: () {
                    context.read<UndoRedoCubit>().redo();
                  },
                  highlightColor: const Color.fromARGB(255, 221, 213, 248),
                  icon: const Icon(Icons.redo_outlined,
                      color: Color(0XFF8B79CC), size: 40))
            ],
          ),
          Container(
            width: 361.w,
            height: 76.h,
            margin: EdgeInsets.only(bottom: 24.h, left: 25.w, right: 25.w),
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
                      onTap: () {
                        stroksize(context, 'اختاري حجم الممسحة', true);
                        setState(() {
                          context.read<Propertiescubit>().setmode(true);
                        });
                      },
                      child: SvgPicture.asset("assets/eraser.svg")),
                  SizedBox(
                    width: 64.w,
                  ),
                  InkWell(
                      onTap: () {
                        colorpicker(context);
                      },
                      child: SvgPicture.asset(
                        "assets/color_p.svg",
                        colorFilter: ColorFilter.mode(
                            picked ? currentColor : const Color(0XFF8B79CC),
                            BlendMode.srcIn),
                      )),
                  SizedBox(
                    width: 64.w,
                  ),
                  BlocBuilder<Propertiescubit, List<dynamic>>(
                      builder: (context, state) {
                    List<dynamic> list = state;
                    return InkWell(
                        onTap: () {
                          stroksize(
                              context, 'اختاري حجم او نوع الفرشاة', false);
                          setState(() {
                            context.read<Propertiescubit>().setmode(false);
                          });
                        },
                        child: list[4] == 1
                            ? SvgPicture.asset("assets/brush.svg")
                            : list[4] == 2
                                ? const Icon(
                                    Icons.horizontal_rule_outlined,
                                    color: Color(0XFF8B79CC),
                                    size: 40,
                                  )
                                : list[4] == 3
                                    ? const Icon(Icons.circle_outlined,
                                        color: Color(0XFF8B79CC), size: 40)
                                    : const Icon(Icons.rectangle_outlined,
                                        color: Color(0XFF8B79CC), size: 40));
                  }),
                ]),
          ),
        ],
      ),
    );
  }

  Future<dynamic> colorpicker(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'اختاري لون',
            textDirection: TextDirection.rtl,
            style: GoogleFonts.notoSansArabic(
                fontSize: 18,
                color: const Color(0XFF8B79CC),
                fontWeight: FontWeight.w500),
          ),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                'تم',
                style: GoogleFonts.notoSansArabic(
                    fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                setState(() {
                  currentColor = pickerColor;
                  picked = true;
                });
                context.read<Propertiescubit>().setcolor(currentColor);

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> stroksize(BuildContext context, String text, bool isEraser) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              text,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.notoSansArabic(
                  fontSize: 18,
                  color: const Color(0XFF8B79CC),
                  fontWeight: FontWeight.w500),
            ),
          ),
          content: MySlider(
            isEraser: isEraser,
          ),
          actions: <Widget>[
            !isEraser
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              context.read<Propertiescubit>().setbrushmode(4);
                            },
                            highlightColor:
                                const Color.fromARGB(255, 221, 213, 248),
                            icon: const Icon(Icons.rectangle_outlined,
                                color: Color.fromARGB(255, 92, 74, 156))),
                        IconButton(
                            highlightColor:
                                const Color.fromARGB(255, 221, 213, 248),
                            onPressed: () {
                              context.read<Propertiescubit>().setbrushmode(3);
                            },
                            icon: const Icon(Icons.circle_outlined,
                                color: Color.fromARGB(255, 92, 74, 156))),
                        IconButton(
                            highlightColor:
                                const Color.fromARGB(255, 221, 213, 248),
                            onPressed: () {
                              context.read<Propertiescubit>().setbrushmode(2);
                            },
                            icon: const Icon(Icons.horizontal_rule_outlined,
                                color: Color.fromARGB(255, 92, 74, 156))),
                        IconButton(
                          highlightColor:
                              const Color.fromARGB(255, 221, 213, 248),
                          onPressed: () {
                            context.read<Propertiescubit>().setbrushmode(1);
                          },
                          icon: SvgPicture.asset(
                            "assets/brush.svg",
                            width: 24.w,
                            height: 24.h,
                            colorFilter: const ColorFilter.mode(
                                Color.fromARGB(255, 92, 74, 156),
                                BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Center(
              child: ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color(0XFF8B79CC))),
                child: Text(
                  'تم',
                  style: GoogleFonts.notoSansArabic(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
