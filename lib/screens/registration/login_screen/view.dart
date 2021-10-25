import 'package:aban/constant/style.dart';
import 'package:aban/screens/Home/guestdawer.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/registration/edit_password/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/textField.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: white,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'مرحباً بك !',
                style: hintStyle,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextFieldItem(
                hintText: "Reasearsh@ksuedu.sa",
                labelText: 'بريدك الجامعي',
                scure: false),
            const SizedBox(
              height: 20,
            ),
            const TextFieldItem(
                hintText: "*****", labelText: "كلمة المرور", scure: true),
            const  SizedBox(
              height: 20,
            ),
            SubmitButton(
                gradient: blueGradient,
                text: 'تسجيل دخول',
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>NavigationFile(d: studentDrawer(context),title: 'مرحبا"اسم الباحث"',counter: 1,)));
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditPasswordScreen()));
                },
                child: Text(
                  'هل نسيت كلمة المرور',
                  style: hintStyle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationFile(d: guestDrawer(context),title: 'مرحبا',counter: 2,)));
                },
                child: Text(
                  'المواصلة كزائر',
                  style: hintStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
