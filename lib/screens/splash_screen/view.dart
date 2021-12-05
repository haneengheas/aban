import 'dart:async';

import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/registration/regist_screen/view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  login(context) {
    var prov = Provider.of<ProfileProvider>(context, listen: false);
    var provider = Provider.of<AuthProvider>(context, listen: false);

    if (islogin == false) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const RegistScreen()));
    } else if (islogin == true) {
      prov.counter = 1;
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => NavigationFile(
                    counter: prov.counter!,
                    // title: ' مرحبا${provider.userName}',
                    d: studentDrawer(context),
                  )));
    }
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      login(context);
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
