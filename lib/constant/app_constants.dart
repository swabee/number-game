
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


const appname = 'DoctorToken';
// const Color basecolor = Color.fromARGB(255, 190, 212, 231);
const Color primaryColor = Color.fromARGB(255, 39, 8, 111);
const Color bottombarSecondaryColor = Color.fromARGB(255, 180, 180, 212);
const Color primaryColorLight = Color.fromARGB(116, 26, 126, 213);
Color secondaryColor = primaryColor.withOpacity(.1);
const Color appbg=Color.fromARGB(255, 255, 249, 249);
const Color lightGreen = Color(0xffEAFBF2);
const Color lightGreenHover = Color(0xffE0F9EB);
const Color textDarkBLue = Color(0xFF3C65E8);
const Color darkGreen = Color(0xff23A15C);
const Color containerbgColor = Color.fromARGB(255, 105, 204, 228);
Color greyBlue = const Color.fromARGB(255, 28, 119, 223);
const whiteColor = Colors.white;
const Color neutrals3 = Color(0xffF5F5F5);
const Color neutrals4 = Color(0xffF0F0F0);
const Color neutrals5 = Color(0xffD9D9D9);
const Color neutrals6 = Color(0xffC0C0C0);
const Color neutrals7 = Color(0xff8D8D8D);
const Color neutrals8 = Color(0xff5B5B5B);
const Color neutrals9 = Color(0xff464646);
const Color error500 = Color(0xffEF4444);

final double horizontalMargin = 51.w;

//! New colors
const Color textColorBlue = Color(0xff1C2E6A);

//





// image urls


//Pages document ids


var headingStyle= TextStyle(
                      fontFamily: 'Poppins',fontSize: 16.sp,fontWeight: FontWeight.w600);
var subHeadingStyle= TextStyle(
                      fontFamily: 'Poppins',fontSize: 14.sp,fontWeight: FontWeight.w400);
var buttonTextgStyle= TextStyle(
                      fontFamily: 'Poppins',fontSize: 15.sp,fontWeight: FontWeight.w500,color: whiteColor);
var contentTextStyle= TextStyle(
                      fontFamily: 'Poppins',fontSize: 13.sp,fontWeight: FontWeight.w400);





String firstLetterToCap(String input) {
  if (input.isEmpty) return input;

  return input
      .split(' ')
      .map((word) =>
          word.isNotEmpty ? word[0].toUpperCase() + word.substring(1) : '')
      .join(' ');
}


Color getColorForNumber(int numb) {
  switch (numb) {
    case 1:
      return Colors.white;
    case 2:
      return Colors.blueAccent;
    case 3:
      return Colors.orangeAccent;
    case 4:
      return Colors.pink; 
    case 5:
      return Colors.yellow;
    case 6:
      return Colors.pink.shade900; 
    case 7:
      return Colors.deepOrange;
    case 8:
      return Colors.lightBlueAccent; 
    case 9:
      return Colors.purpleAccent.shade100; 
    default:
      return Colors.grey;
  }
}


String formatTime(int seconds) {
  final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
  final secs = (seconds % 60).toString().padLeft(2, '0');
  return "$minutes:$secs";
}
String formatDate(DateTime date) {
  return DateFormat("MMMM d").format(date);
}

bool isTodayOrPast(DateTime date) {
  final now = DateTime.now();

  // Normalize both dates to remove time component
  final inputDate = DateTime(date.year, date.month, date.day);
  final today = DateTime(now.year, now.month, now.day);

  // If inputDate is today or earlier
  return !inputDate.isAfter(today);
}
