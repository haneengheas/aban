// ignore_for_file: avoid_print

import 'package:aban/constant/loading_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/profile_provider.dart';
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
    Future.delayed(Duration.zero, () {
      var prov = Provider.of<ProfileProvider>(context, listen: false);
      prov.counter!= null;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    var prov = Provider.of<ProfileProvider>(context);

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
                  hintText: "student@std.mans.edu.eg",
                  labelText: 'بريدك الجامعي',
                  scure: false,
                  onChanged: (val) {
                    email = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'الرجاء كتابه البريد الالكتروني ';
                    } else if (value.length < 5) {
                      return 'الرجاء كتابه البريد الالكتروني بشكل صحيح';
                    } else if (!value.toString().contains('@')) {
                      return ' @ يجب ان يحتوي البريد الالكتروني علي  ';
                    } else if (!value
                        .toString()
                        .contains('@std.mans.edu.eg')
                         &&
                        // !value.toString().contains('ksu.edu.sa') &&
                        !value.toString().contains('@gmail.com')
                    ) {
                      return ' يجب ان يحتوي البريد الالكتروني علي @std.mans.edu.eg ';
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
                      return 'الرجاء كتابه كلمة المرور ';
                    }
                  }),
              const SizedBox(
                height: 20,
              ),
              SubmitButton(
                  gradient: blueGradient,
                  text: 'تسجيل دخول',
                  onTap: () async {
                    prov.counter =1;
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      showLoading(context);
                        var login = await provider.login(email, password,context);

                        if (login != null) {
                          await prov.getUserName();
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NavigationFile(
                                        d: studentDrawer(context),
                                        // title: '   مرحبا  ${provider.userName} ',
                                        counter: prov.counter!,
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
                    prov.counter=2;
                    print(prov.counter);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NavigationFile(
                                  d: guestDrawer(context),
                                  // title: 'مرحبا',
                                  counter: prov.counter!,
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
