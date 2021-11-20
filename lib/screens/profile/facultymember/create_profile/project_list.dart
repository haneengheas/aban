// ignore_for_file: must_be_immutable

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ProjectList extends StatefulWidget {
  String ?college ;
  String ?department;
   ProjectList({
     this.college,
     this.department,
    Key? key}) : super(key: key);

  @override
  _ProjectListState createState() => _ProjectListState();
}

class _ProjectListState extends State<ProjectList> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "المشاريع:",
            style: labelStyle3,
          ),
        ),
        Row(
          children: [
            SizedBox(
              height: 120,
              width: sizeFromWidth(context, 1),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('project')
                      .where('userId',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                              children: [
                                Container(
                                  padding :const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  width: sizeFromWidth(context, 1.5),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: clearblue,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceEvenly,
                                            children: [
                                              Text(
                                                ' اسم المشروع : ${snapshot.data!.docs[index]['projectName']}',
                                                style: hintStyle4,
                                              ),
                                              Text(
                                                'القائد ${snapshot.data!.docs[index]['leaderName']}',
                                                style: hintStyle5,
                                              ),
                                              Text(
                                                'الاعضاء ${snapshot.data!.docs[index]['memberProjectName']}',
                                                style: hintStyle5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30,
                                  child: IconButton(
                                    onPressed: () async {
                                      await showDialogWarning(context,
                                          text: 'هل انت متاكد من الحذف ',
                                          ontap: () async {
                                            await FirebaseFirestore.instance
                                                .collection('project')
                                                .doc(snapshot
                                                .data!.docs[index].id)
                                                .delete();
                                            Navigator.pop(context);
                                            AwesomeDialog(
                                                context: context,
                                                title: "هام",
                                                body: const Text("تمت عملية الحذف بنجاح"),
                                                dialogType: DialogType.SUCCES)
                                                .show();
                                          });
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    iconSize: 20,
                                  ),
                                ),
                              ],
                            );
                          });
                    } else {
                      return const SizedBox();
                    }
                  }),
            ),
          ],
        ),
        ButtonUser(
            text: "اضافة مشروع",
            color: blueGradient,
            onTap: () {
              showDialogProject(
                context,
                department: widget.department!,
                college: widget.college!,
                text: 'إضافة مشروع',
              );
            }),
      ],
    );
  }
}
