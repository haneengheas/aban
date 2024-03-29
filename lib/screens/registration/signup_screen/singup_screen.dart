// ignore_for_file: avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/textfield_registation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// var val;
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String name, email, password, password1;

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
  bool validate(String value) {
    String pattern =
        r'^[a-zA-Z_][a-zA-Z0-9_]*';

    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: white,
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFieldRegistation(
                      hintText: 'اسمك',
                      labelText: "الاسم",
                      scure: false,
                      onChanged: (val) {
                        name = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'برجاءادخال الاسم';
                        } else if (value.length < 3) {
                          return 'يجب ان يتكون الاسم علي الاقل من ثلاثة احرف';
                        }
                      }),
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
                        } else if (!validate(value)) {
                          return 'يجب أن لا يبدأ البريد الالكتروني برقم';
                        } else if (!value
                                .toString()
                                .contains('@std.mans.edu.eg')
                            &&
                            //!value.toString().contains('ksu.edu.sa') &&
                            !value.toString().contains('@gmail.com')) {
                          return ' يجب ان يحتوي البريد الالكتروني علي student@std.mans.edu.eg ';
                        }
                      }),
                  TextFieldRegistation(
                      hintText: "*****",
                      labelText: "كلمة المرور",
                      scure: true,
                      onChanged: (val) {
                        password = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'الرجاء ادخال كلمة المرور ';
                        } else if (value.length < 5) {
                          return 'يجب ان تتكون كلمة المرور علي الاقل من ثمانيه خانات';
                        } else if (!validateStructure(value)) {
                          return 'يجب ان تحتوى كلمة المرور على ثمانيه خانات رقم واحد على الأقل  \n وأحرف الكبيرة وأحرف الصغيرة ورموز @#%&* ';
                        }
                      }),
                  TextFieldRegistation(
                      hintText: "*****",
                      labelText: "تاكيد كلمة المرور",
                      scure: true,
                      onChanged: (val) {
                        password1 = val;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          print(value);
                          print('==============================');
                          return 'الرجاء كتابه كلمة المرور بشكل صحيح';
                        } else if (value != password) {
                          print(value);
                          print('================sss==============');
                          return 'كلمة المرور غير متطابقة';
                        } else if (value.length <= 5) {
                          return 'يجب ان تتكون كلمة المرور علي الاقل من ستة حروف وارقام';
                        }
                      }),
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
                        Consumer<AuthProvider>(
                            builder: (context, object, child) {
                          return Radio(
                              value: 0,
                              groupValue: object.usertype,
                              onChanged: (value) {
                                setState(() {
                                  object.usertype = value;
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
                                value: 1,
                                groupValue: object.usertype,
                                onChanged: (value) {
                                  print(value);
                                  setState(() {
                                    object.usertype = value;
                                  });
                                });
                          },
                        ),
                        Text(
                          'طالب ',
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
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            String userType = Provider.of<AuthProvider>(context,
                                            listen: false)
                                        .usertype ==
                                    0
                                ? 'member'
                                : 'student';
                            print(userType);
                            provider.singup(
                                email, password, name, userType, context);
                          } else {
                            (e) {
                              print(e);
                            };
                          }
                        }),
                  ),
                  const Center(
                    child: Text(
                      'خطوة 1 من 2',
                      style: TextStyle(
                          fontSize: 18,
                          color: blue,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ))),
    );
  }
}
