import 'dart:async';
import 'package:aban/screens/registration/regist_screen/view.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer( const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>const RegistScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(image: AssetImage('assets/logo.png')),
      ),
    );
  }
}
