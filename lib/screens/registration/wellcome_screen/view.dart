import 'package:aban/constant/style.dart';
import 'package:aban/screens/profile/facultymember/create_profile/view.dart';
import 'package:aban/screens/profile/graduatedmember/create_profile/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';

class WellcomeScreen extends StatefulWidget {
  final int value;
  WellcomeScreen({
    required this.value,
  });

  @override
  _WellcomeScreenState createState() => _WellcomeScreenState();
}

class _WellcomeScreenState extends State<WellcomeScreen> {
  @override
  Widget build(BuildContext context) {
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
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(color: blue),
                child: Image(
                  image: AssetImage('assets/logo.png'),
                  height: 190,
                ),
              ),
              Container(
                  width: sizeFromWidth(context, 1),
                  height: MediaQuery.of(context).size.height / 1.4,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'مرحبا',
                        style: labelStyle,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        width: 110,
                        height: 110,
                        child: ImageIcon(
                          AssetImage('assets/user.png'),
                          color: blue,
                          size: 200,
                        ),
                      ),
                      SubmitButton(
                          gradient: blueGradient,
                          text: ' أنشيء ملفك الشخصي     ',
                          onTap: () {
                            if (widget.value == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateMemberProfile(value: 1,)));
                            } else if (widget.value == 2) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CreateGraduatedProfile(value: 2,)));
                            }
                          }),
                      SubmitButton(
                          gradient: grayGradient,
                          text: 'إلغاء التسجيل',
                          onTap: () {
                            Navigator.pop(
                              context,
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
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
