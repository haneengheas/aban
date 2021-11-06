// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/profile/facultymember/create_profile/profile_information.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGraduatedProfile extends StatefulWidget {
  const CreateGraduatedProfile({
    Key? key,
  }) : super(key: key);

  @override
  _CreateGraduatedProfileState createState() => _CreateGraduatedProfileState();
}

class _CreateGraduatedProfileState extends State<CreateGraduatedProfile> {
  var cards = <Card>[];
  var text;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var prov = Provider.of<ProfileProvider>(context, listen: false);
      prov.fields.clear();
      prov.file = File('');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: customAppBar(context, title: 'إنشىء ملفك الشخصي')),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileInformation(),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 10,
              thickness: 1,
              color: lightGray,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "اطروحات تحت اشرافك :",
                style: labelStyle3,
              ),
            ),
            ButtonUser(
                text: "اضافة اطروحة",
                color: blueGradient,
                onTap: () {
                  showDialogTheses(context, text: 'إضافة اطروحة',);
                }),
            const Divider(
              height: 30,
              thickness: 1,
              color: lightGray,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "المشاريع:",
                style: labelStyle3,
              ),
            ),
            ButtonUser(
                text: "اضافة مشروع",
                color: blueGradient,
                onTap: () {
                  showDialogProject(context, text: 'إضافة مشروع',);
                }),
            Center(
              child: SubmitButton(
                onTap: () async {
                  await prov.createGraduatedProfile(
                      context: context,
                      name: prov.name,
                      faculty: prov.faculty,
                      phone: prov.phone,
                      id: prov.id,
                      degree: prov.degree!,
                      link: prov.link,
                      accept: prov.accept,
                      file: prov.file!);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationFile(
                                d: studentDrawer(context),
                                title: prov.name +'اسم الباحث',
                                counter: 1,
                              )));
                },
                text: "حفظ",
                gradient: blueGradient,
              ),
            )
          ],
        )),
      ),
    );
  }
}
