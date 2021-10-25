// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:aban/constant/style.dart';
import 'package:aban/model.dart';
import 'package:aban/screens/registration/wellcome_screen/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// var val;
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            const  TextFieldItem(hintText: 'اسمك', labelText: "الاسم", scure: false),
            const  TextFieldItem(
                hintText: "Reasearsh@ksuedu.sa",
                labelText: 'بريدك الجامعي',
                scure: false),
            const  TextFieldItem(
                hintText: "*****", labelText: "كلمة المرور", scure: true),
            const  TextFieldItem(
                hintText: "*****", labelText: 'تأكيد كلمة المرور', scure: true),
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
                  Consumer<MyModel>(builder: (context,object,child){
                    return  Radio(
                        value: 1,
                        groupValue: object.val,
                        onChanged: (value) {
                          setState(() {
                            object.val = value;
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
                  Consumer<MyModel>(builder: (context,object,child){
                    return Radio(
                        value: 2,
                        groupValue: object.val,
                        onChanged: (value) {
                          setState(() {
                            object. val = value;
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WellcomeScreen()));
                  }),
            ),
            const Center(
              child: Text(
                'خطوة 1 من 2',
                style:  TextStyle(
                    fontSize: 18, color: blue, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
