

import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/screens/registration/wellcome_screen/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';

import 'package:aban/widgets/textfield_registation.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// var val;
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String name, email, password;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    var prov = Provider.of<MyModel>(context);

    return Scaffold(
      backgroundColor: white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            TextFieldRegistation(
              hintText: 'اسمك',
              labelText: "الاسم",
              scure: false,
              onChanged: (val) {
                name = val;
              },
            ),
            TextFieldRegistation(
              hintText: "Reasearsh@ksuedu.sa",
              labelText: 'بريدك الجامعي',
              scure: false,
              onChanged: (val) {
                email = val;
              },
            ),
            TextFieldRegistation(
              hintText: "*****",
              labelText: "كلمة المرور",
              scure: true,
              onChanged: (val) {
                password = val;
              },
            ),
            // TextFieldItem(
            //  hintText: "*****", labelText: 'تأكيد كلمة المرور', scure: true,
            //    onChanged: (val){name=val;},),
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 10),
              child: Text(
                'انا...',
                style: labelStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Consumer<AuthProvider>(builder: (context, object, child) {
                    return Radio(

                        value: 1,
                        groupValue: object.val,
                        onChanged: (value) {
                          setState(() {
                            object.val = value;
                            print("============////////=========");
                            print(prov.departments);
                          });
                        });
                  }),
                  Text(
                    'عضو هيئة تدريس',
                    style: hintStyle,
                  ),
                  // SizedBox(
                  //   width: sizeFromWidth(context, 8),
                  // ),
                  Consumer<AuthProvider>(
                    builder: (context, object, child) {
                      return Radio(
                          value: 2,
                          groupValue: object.val,
                          onChanged: (value) {
                            setState(() {
                              object.val = value;
                            });
                          });
                    },
                  ),
                  Text(
                    'طالب دراسات عليا',
                    style: hintStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SubmitButton(
                  gradient: blueGradient,
                  text: 'متابعة',
                  onTap: () {
                    provider.singup(email, password, name);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WellcomeScreen()));

                  }),
            ),
            const Center(
              child: Text(
                'خطوة 1 من 2',
                style: TextStyle(
                    fontSize: 18, color: blue, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
