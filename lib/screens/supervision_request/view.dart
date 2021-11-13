import 'package:aban/constant/style.dart';
import 'package:aban/screens/theses_screen/theses_model.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:aban/widgets/textField.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupervisionScreen extends StatefulWidget {
  String? userid;

  SupervisionScreen({required this.userid, Key? key}) : super(key: key);

  @override
  State<SupervisionScreen> createState() => _SupervisionScreenState();
}

class _SupervisionScreenState extends State<SupervisionScreen> {
  List<ModelTheses> thesesList = <ModelTheses>[];
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String filter = '';

  @override
  void initState() {
    getTheses();
    nameController.addListener(() {
      filter = nameController.text;
      setState(() {});
    });
    print('-------------------------------');

    super.initState();
  }

  getTheses() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('theses').get();

    for (var doc in querySnapshot.docs) {
      thesesList.add(ModelTheses(
          nameTheses: doc['nameTheses'],
          assistantSupervisors: doc['assistantSupervisors'],
          degreeTheses: doc['degreeTheses'],
          nameSupervisors: doc['nameSupervisors'],
          linkTheses: doc['linkTheses'],
          thesesStatus: doc['thesesStatus'],
          isFav: doc['isFav'],
          id: doc.id));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: customAppBar(context, title: 'طلب اشراف'),
          preferredSize: const Size.fromHeight(50)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'ارسال طلب اشراف علي اطروحة',
              style: hintStyle3,
            ),
            Container(
              height: 400,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: lightgray,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  TextFieldItem(
                      controller: nameController,
                      hintText: 'العنوان',
                      labelText: "عنوان الاطروحة",
                      scure: false),
                  TextFieldItem(
                      controller: descriptionController,
                      hintText: 'الوصف',
                      labelText: "وصف الاطروحة",
                      scure: false),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  SubmitButton(
                      gradient: blueGradient,
                      text: 'ارسال',
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('super')
                            .add({
                          'name': nameController.text,
                          'description':descriptionController.text,
                          'reciveid': widget.userid,
                          'sendid': FirebaseAuth.instance.currentUser!.uid,
                        }).then((value) {
                          Navigator.pop(context);
                          return AwesomeDialog(
                              context: context,
                              title: "هام",
                              body: const Text("تم الارسال بنجاح"),
                              dialogType: DialogType.SUCCES)
                            ..show();
                        });
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
