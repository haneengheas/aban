// ignore_for_file: avoid_print, must_be_immutable

import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/screens/profile/facultymember/create_profile/view.dart';
import 'package:aban/screens/profile/graduatedmember/create_profile/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WellcomeScreen extends StatefulWidget {
  // final int value;
  String ? email , name;
   WellcomeScreen({
    Key? key,
    this.name,
    this.email,
    // required this.value,
  }) : super(key: key);

  @override
  _WellcomeScreenState createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height,
                width: sizeFromWidth(context, 1),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(color: blue),
                child: const Image(
                  image: AssetImage('assets/logo.png'),
                  height: 190,
                ),
              ),
              Container(
                  width: sizeFromWidth(context, 1),
                  height: MediaQuery.of(context).size.height / 1.4,
                  decoration: const BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        'مرحبا',
                        style: labelStyle,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        width: 110,
                        height: 110,
                        child: const ImageIcon(
                          AssetImage('assets/user.png'),
                          color: blue,
                          size: 200,
                        ),
                      ),
                      Consumer<AuthProvider>(builder: (context, object, child) {
                        return SubmitButton(
                            gradient: blueGradient,
                            text: ' أنشيء ملفك الشخصي     ',
                            onTap: () {
                              print(provider.usertype);
                              if (provider.usertype == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             CreateMemberProfile(
                                               email: widget.email,
                                               nameuser: widget.name,
                                            )));
                              } else if (provider.usertype== 1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                             CreateGraduatedProfile(
                                               email: widget.email,
                                               nameuser: widget.name,
                                            )));
                              }
                            });
                      }),
                      SubmitButton(
                          gradient: grayGradient,
                          text: 'إلغاء التسجيل',
                          onTap: () {
                            Navigator.pop(
                              context,
                            );
                          }),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: Text(
                            'خطوة 2 من 2',
                            style: TextStyle(
                                fontSize: 18,
                                color: blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
