import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/screens/Home/guestdawer.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/registration/edit_password/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/textField.dart';
import 'package:aban/widgets/textfield_registation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  getUserStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
    //get all docs and make for loop in it and get what i need ==> userid == my unique id
        .where('userid', isEqualTo: (FirebaseAuth.instance.currentUser!).uid)
    // get it
        .get()
        .then((value) {
      //this return a list of query snapshot , but it include a one item - because the firebase uid is unique for each user -
      print(value.docs[0]['var']);
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    print('---------------------///-------------');
    getUserStatus();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);

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
            TextFieldRegistation(
              hintText: "Reasearsh@ksuedu.sa",
              labelText: 'بريدك الجامعي',
              scure: false,
              onChanged: (val) {
                email = val;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFieldRegistation(
              hintText: "*****",
              labelText: "كلمة المرور",
              scure: true,
              onChanged: (val) {
                password = val;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SubmitButton(
                gradient: blueGradient,
                text: 'تسجيل دخول',
                onTap: () {
                  try {
                    var login = provider.login(email, password);
                    if (login != null) {
                     provider.getUserStatus();
                     print('===================');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NavigationFile(
                                    d: studentDrawer(context),
                                    title: 'مرحبا"اسم الباحث"',
                                    counter: provider.val,
                                  )));
                    }
                  } catch (e) {
                    print(e);
                  }
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
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationFile(
                                d: guestDrawer(context),
                                title: 'مرحبا',
                                counter: 2,
                              )));
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
