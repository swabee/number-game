import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:number_game/custom/container_custom.dart';
import 'package:number_game/custom/text_custom.dart';

class HomeButtonCustom extends StatelessWidget {
  const HomeButtonCustom(
      {super.key,
      required this.gradientColorOne,
      required this.buttonName,
      required this.onClick,
      required this.buttonTextColor,
      required this.gradientColorTwo});
  final Color gradientColorOne;
  final Color gradientColorTwo;
  final Color buttonTextColor;
  final String buttonName;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return ContainerCustom(callback: onClick,
      borderRadius: BorderRadius.circular(37.r),
      width: 280.w,
      height: 57.h,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          gradientColorOne,gradientColorTwo
          // const Color.fromARGB(255, 236, 175, 21),
          // const Color.fromARGB(255, 204, 148, 8),
        ],
      ),
      child: TextCustomWidget(
        containerAlignment: Alignment.center,
        text: buttonName,
        textStyle: GoogleFonts.fredoka(
          color: buttonTextColor,
          // color: const Color.fromARGB(255, 90, 66, 7),
          fontSize: 21.sp,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
