import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'college_views.dart';

class HomeScreen extends StatelessWidget {
  final  Widget c;
  final  String title;
  HomeScreen({
    required this.c,
    required this.title,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        title: Text(
          title,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1,
                color: white),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          c,
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: blue,
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height,
            width: sizeFromWidth(context, 1),

          ),
          Container(
              width: sizeFromWidth(context, 1),
              height: MediaQuery.of(context).size.height / 1.17,
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: CollegeView()),
          // Expanded(child: NavigationFile()),
        ],
      ),
    );
  }
}
