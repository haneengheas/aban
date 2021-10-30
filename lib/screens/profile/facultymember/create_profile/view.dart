// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/profile/facultymember/create_profile/accept_supervision.dart';
import 'package:aban/screens/profile/facultymember/create_profile/profile_information.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class CreateMemberProfile extends StatefulWidget {
  const CreateMemberProfile({
    Key? key,
  }) : super(key: key);

  @override
  _CreateMemberProfileState createState() => _CreateMemberProfileState();
}

class _CreateMemberProfileState extends State<CreateMemberProfile> {
  var cards = <Card>[];
  var text;
  var name;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void getData() async {
    DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
        .collection("member")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    debugPrint('userType is ${documentSnapshot2.get('userId')}');
    name.text = documentSnapshot2.get('name');
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var prov = Provider.of<ProfileProvider>(context, listen: false);
      prov.fields.clear();
      prov.file = File('');
      setState(() {});
    });
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: white,
          title: Text('إنشىء ملفك الشخصي',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                    color: blue, fontWeight: FontWeight.bold, fontSize: 28),
              )),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: blue,
            ),
          )),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // widget for user information example( name , phone)
              const ProfileInformation(),
              // widget for accept supervision
              const AcceptSupervision(),
              const Divider(
                height: 10,
                thickness: 1,
                color: lightGray,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'المجالات',
                  style: labelStyle3,
                ),
              ),
              Column(
                children: prov.fields
                    .map((e) => Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: e,
                              decoration: InputDecoration(
                                  hintText: "المجال ${cards.length + 1}",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              TextButton.icon(
                  onPressed: () =>
                      setState(() => prov.fields.add(TextEditingController())),
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: black,
                    size: 20,
                  ),
                  label: Text(
                    'اضافة مجال',
                    style: hintStyle4,
                  )),
              const Divider(
                height: 10,
                thickness: 1,
                color: lightGray,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "اطروحات تحت اشرافك :",
                  style: labelStyle3,
                ),
              ),
              ButtonUser(
                  text: "اضافة اطروحة",
                  color: blueGradient,
                  onTap: () {
                    showDialogTheses(context, text: 'اضافة اطروحة');
                  }),
              const Divider(
                height: 20,
                thickness: 1,
                color: lightGray,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "المشاريع:",
                  style: labelStyle3,
                ),
              ),
              ButtonUser(
                  text: "اضافة مشروع",
                  color: blueGradient,
                  onTap: () {
                    showDialogProject(context, text: 'إضافة مشروع');
                  }),
              Center(
                child: SubmitButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (prov.file!.path == '') {
                        return AwesomeDialog(
                            context: context,
                            title: "هام",
                            body: const Text("please choose Image"),
                            dialogType: DialogType.ERROR)
                          ..show();
                      } else {
                        print(prov.file!.path);
                        List<String> fieldsStr = <String>[];

                        for (var element in prov.fields) {
                          fieldsStr.add(element.text);
                        }

                        print('Str list is => $fieldsStr');

                        await prov.createMemberProfile(
                          context: context,
                          faculty: prov.faculty,
                          degree: prov.degree,
                          file: prov.file!,
                          id: prov.id,
                          fields: fieldsStr,
                          accept: prov.accept,
                          name: prov.name,
                          phone: prov.phone,
                          link: prov.link,
                        );

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavigationFile(
                                  d: studentDrawer(context),
                                  title: 'مرحبا"اسم الباحث"',
                                  counter: 1,
                                )));
                      }
                    }
                  },
                  text: "حفظ",
                  gradient: blueGradient,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
