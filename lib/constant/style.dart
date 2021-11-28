import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color lightBlue = Color(0xffaabfe9);
const Color lightgray = Color(0xfff1f1ff);
const Color black = Color(0xff1d1d1d);
const Color white = Color(0xffffffff);
const Color blue = Color(0xff2855ae);
const Color gray = Color(0xff7c7c7c);
const Color lightGray = Color(0xffc7c7c7);
const Color clearblue = Color(0xfff5f6fc);
const Color red = Color(0xffaf2e2e);
const Color red2 = Color(0xffcc6b6b);
const Color green = Color(0xff32CD32);

const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [.5, 1],
    colors: [blue, lightBlue]);

const LinearGradient grayGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [.5, .9],
    colors: [gray, lightGray]);

const LinearGradient redGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: [.5, .9],
    colors: [red, red2]);

TextStyle labelStyle = GoogleFonts.cairo(
  textStyle: const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w600, height: 1, color: black),
);
TextStyle bluebold = GoogleFonts.cairo(
  textStyle: const TextStyle(
      fontSize: 24, fontWeight: FontWeight.bold, height: 1, color: blue),
);
TextStyle labelStyle2 = GoogleFonts.cairo(
  textStyle: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1,
    color: black,
    overflow: TextOverflow.clip,
  ),
);
TextStyle labelStyle3 = GoogleFonts.cairo(
  textStyle: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1,
    color: black,
    overflow: TextOverflow.clip,
  ),
);
TextStyle hintStyle = GoogleFonts.cairo(
  textStyle: const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, height: 1.5, color: gray),
);
TextStyle hintStyle2 = GoogleFonts.cairo(
  textStyle: const TextStyle(
      fontSize: 15, fontWeight: FontWeight.w400, height: 1.5, color: blue),
);
TextStyle hintStyle3 = GoogleFonts.cairo(
  textStyle: const TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: gray,
    overflow: TextOverflow.clip,
  ),
);

TextStyle hintStyle4 = GoogleFonts.cairo(
  textStyle: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    height: 1.5,
    color: black,
    overflow: TextOverflow.clip,
  ),
);
TextStyle hintStyle5 = GoogleFonts.cairo(
  textStyle: const TextStyle(
      overflow: TextOverflow.clip,
      fontSize: 10,
      fontWeight: FontWeight.bold,
      height: 1.5,
      color: black),
);

TextStyle submitButtonStyle =
    GoogleFonts.cairo(fontSize: 18, color: white, fontWeight: FontWeight.w600);
TextStyle submitButtonStyle2 =
    GoogleFonts.cairo(fontSize: 15, color: white, fontWeight: FontWeight.w600);
TextStyle submitButtonStyle3 =
    GoogleFonts.cairo(fontSize: 15, color: white, fontWeight: FontWeight.bold);
TextStyle appBarStyle = GoogleFonts.cairo(
  textStyle:
      const TextStyle(color: blue, fontWeight: FontWeight.bold, fontSize: 28),
);

double sizeFromHeight(BuildContext context, double fraction,
    {bool hasAppBar = true}) {
  final screenHeight = MediaQuery.of(context).size.height;
  fraction = (hasAppBar
          ? (screenHeight -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top)
          : screenHeight) /
      fraction;
  return fraction;
}

double sizeFromWidth(
  BuildContext context,
  double fraction,
) {
  return MediaQuery.of(context).size.width / fraction;
}
