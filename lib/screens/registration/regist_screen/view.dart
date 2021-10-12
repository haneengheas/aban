import 'dart:ui';
import 'package:aban/constant/style.dart';
import 'package:aban/screens/registration/login_screen/view.dart';
import 'package:aban/screens/registration/signup_screen/singup_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistScreen extends StatefulWidget {
  @override
  _RegistScreenState createState() => _RegistScreenState();
}

class _RegistScreenState extends State<RegistScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height,
              width: sizeFromWidth(context, 1),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: blue,
              ),
              child: Image(
                image: AssetImage('assets/logo.png'),height: 185,
              ),
            ),
            Container(
              width: sizeFromWidth(context, 1),
              height: MediaQuery.of(context).size.height / 1.4,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15))),
              child: Column(children: [
                SizedBox(
                  height: 65,
                  child: (TabBar(
                    labelColor: blue,
                    unselectedLabelColor: gray,
                    isScrollable: true,
                    labelStyle: GoogleFonts.cairo(
                      textStyle: TextStyle(
                          fontSize: 25,
                          height: 1.5,
                          fontWeight: FontWeight.w800),
                    ),
                    tabs: <Widget>[
                      Tab(
                        text: 'تسجيل جديد',

                      ),
                      Tab(
                        text: "تسجيل دخول",
                      ),
                    ],
                  )),
                ),
                Expanded(
                  child: SizedBox(
                    child: TabBarView(
                      children: [
                        SignUpScreen(),
                        LoginScreen(),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            // Expanded(

          ],
        ),
      ),
    );
  }
}
