import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformationItem extends StatefulWidget {
  const InformationItem({Key? key}) : super(key: key);

  @override
  State<InformationItem> createState() => _InformationItemState();
}

class _InformationItemState extends State<InformationItem> {
  TextEditingController name = TextEditingController();
  TextEditingController emailuser = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController faculty = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController link = TextEditingController();

  void getData() async {
    DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
        .collection("member")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    debugPrint('userType is ${documentSnapshot2.get('userId')}');
    name.text = documentSnapshot2.get('name');
    faculty.text = documentSnapshot2.get('faculty');
    emailuser.text = FirebaseAuth.instance.currentUser!.email!;
    link.text = documentSnapshot2.get('link');
    phone.text = documentSnapshot2.get('phone');
    degree.text = documentSnapshot2.get('degree');
    id.text = documentSnapshot2.get('id');

    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            const Image(
              image: AssetImage(
                'assets/user.png',
              ),
              color: blue,
              height: 80,
            ),
            SizedBox(
              width: sizeFromWidth(context, 1.5),
              child: TextFieldUser(
                onChanged: (val) {},
                controller: name,
                labelText: "اسم الباحث",
                hintText: "أسمك",
                scure: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'برجاءادخال اسماء المشرفين المساعدين ';
                  }
                }, // initialValue: name,
              ),
            ),
          ],
        ),
      ),
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: TextFieldUser(
              onChanged: (val) {},
              validator: (value) {
                if (value.isEmpty) {
                  return 'برجاءادخال اسماء المشرفين المساعدين ';
                }
              },
              controller: faculty,
              hintText: "الكلية/التخصص",
              labelText: "الكلية/التخصص",
              scure: false,
              // initialValue: faculty,
            ),
          ),
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: TextFieldUser(
              onChanged: (val) {
                prov.email = val;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'برجاءادخال اسماء المشرفين المساعدين ';
                }
              },
              controller: emailuser,
              hintText: "Reasearsh@ksuedu.sa",
              labelText: "البريد الجامعى",
              scure: false,
              // initialValue: emailuser,
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: TextFieldUser(
              onChanged: (val) {
                prov.email = val;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'برجاءادخال اسماء المشرفين المساعدين ';
                }
              },
              controller: degree,
              hintText: "اختر درجتك",
              labelText: "الدرجة العلمية",
              scure: false,
              // initialValue: degree,
            ),
          ),
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: TextFieldUser(
              onChanged: (val) {
                prov.phone = val;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'برجاءادخال اسماء المشرفين المساعدين ';
                }
              },
              controller: phone,
              hintText: "+96655...",
              labelText: "رقم الهاتف",
              scure: false,
              // initialValue: phone,
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: TextFieldUser(
              onChanged: (val) {
                prov.id = val;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'برجاءادخال اسماء المشرفين المساعدين ';
                }
              },
              controller: id,
              hintText: "المعرف الخاص بك",
              labelText: "orcid iD",
              scure: false,
              // initialValue: id,
            ),
          ),
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: TextFieldUser(
              onChanged: (val) {
                prov.link = val;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'برجاءادخال اسماء المشرفين المساعدين ';
                }
              },
              controller: link,
              hintText: "ادخل رابط GooGel School",
              labelText: " ابحاثى",
              scure: false,
              // initialValue: link,
            ),
          ),
        ],
      ),
    ]);
  }
}
