// ignore_for_file: avoid_print

import 'package:aban/constant/loading_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/screens/Home/guestdawer.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/registration/edit_password/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/textfield_registation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child:  Scaffold(
          backgroundColor: white,
          body:Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                    } else if (value.length < 5) {
                      return 'برجاء كتابه البريد الالكتروني بشكل صحيح';
                    }
                  }),
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'برجاء كتابه كلمة المرور بشكل صحيح';
                    } else if (value.length < 5) {
                      return 'برجاء كتابه كلمة المرور بشكل صحيح';
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              SubmitButton(
                  gradient: blueGradient,
                  text: 'تسجيل دخول',
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      showLoading(context);
                        var login = await provider.login(email, password,context);
                        if (login != null) {
                          // provider.getUserStatus();
                          print(provider.userName);
                          print('===================');
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationFile(
                                        d: studentDrawer(context),
                                        title: ' مرحبا${provider.userName}ً ',
                                        counter: provider.usertype,
                                      )));
                        }

                  }}),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
      ),
    );
  }
}
