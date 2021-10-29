import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/eidt_text_field.dart';
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
  var name;
  var emailuser;
  var degree;
  var phone;
  var faculty;
  var id;
  var link;

  getData() async {
    DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
        .collection("member")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    debugPrint('userType is ${documentSnapshot2.get('userid')}');
    name = documentSnapshot2.get('name');
    faculty = documentSnapshot2.get('faculty');
    emailuser = documentSnapshot2.get('email');
    link = documentSnapshot2.get('link');
    phone = documentSnapshot2.get('phone');
    degree = documentSnapshot2.get('degree');
    id = documentSnapshot2.get('id');
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    var auth = Provider.of<AuthProvider>(context);

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
              child: EidtTextFieldUser(
                onChanged: (val) {
                  prov.name = val;
                },
                labelText: "اسم الباحث",
                hintText: "أسمك",
                scure: true,
                validator: (String) {},
                initialValue: name,
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
            child: EidtTextFieldUser(
              onChanged: (val) {
                prov.faculty = val;
              },
              validator: (String) {},
              hintText: "الكلية/التخصص",
              labelText: "الكلية/التخصص",
              scure: true,
              initialValue: faculty,
            ),
          ),
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: EidtTextFieldUser(
              onChanged: (val) {
                prov.email = val;
              },
              validator: (String) {},
              hintText: "Reasearsh@ksuedu.sa",
              labelText: "البريد الجامعى",
              scure: true,
              initialValue: emailuser,
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: EidtTextFieldUser(
              onChanged: (val) {
                prov.email = val;
              },
              validator: (String) {},
              hintText: "اختر درجتك",
              labelText: "الدرجة العلمية",
              scure: true,
              initialValue: degree,
            ),
          ),
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: EidtTextFieldUser(
              onChanged: (val) {
                prov.phone = val;
              },
              validator: (String) {},
              hintText: "+96655...",
              labelText: "رقم الهاتف",
              scure: true,
              initialValue: phone,
            ),
          ),
        ],
      ),
      Row(
        children: [
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: EidtTextFieldUser(
              onChanged: (val) {
                prov.id = val;
              },
              validator: (String) {},
              hintText: "المعرف الخاص بك",
              labelText: "orcid iD",
              scure: true,
              initialValue: id,
            ),
          ),
          SizedBox(
            width: sizeFromWidth(context, 2),
            child: EidtTextFieldUser(
              onChanged: (val) {
                prov.link = val;
              },
              validator: (String) {},
              hintText: "ادخل رابط GooGel School",
              labelText: " ابحاثى",
              scure: true,
              initialValue: link,
            ),
          ),
        ],
      ),
    ]);
  }
}
