import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/eidt_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProjectItem extends StatelessWidget {
  ProjectItem({Key? key}) : super(key: key);
  TextEditingController projectName = TextEditingController();
  TextEditingController descriptionProject = TextEditingController();
  TextEditingController leaderName = TextEditingController();
  TextEditingController memberProjectName = TextEditingController();
  String? projectStatus;
  GlobalKey<FormState> formKeys = GlobalKey<FormState>();
  GlobalKey<FormState> Keys = GlobalKey<FormState>();

  dynamic indexed;

  @override
  Widget build(BuildContext context) {
    return Column(
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
                                        Padding(
                                          padding:
                                          const EdgeInsets.symmetric(
                                              vertical: 15,
                                              horizontal: 10),
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
                                    onPressed: () {
                                      eidtProject(
                                        context,
                                        text: 'تعديل مشروع',
                                        descriptionProject:
                                        snapshot.data!.docs[index]
                                        ['descriptionProject'],
                                        leaderName: snapshot.data!
                                            .docs[index]['leaderName'],
                                        memberProjectName:
                                        snapshot.data!.docs[index]
                                        ['memberProjectName'],
                                        projectName: snapshot.data!
                                            .docs[index]['projectName'],
                                        projectStatus: snapshot.data!
                                            .docs[index]['projectStatus'],
                                        indexed:
                                        snapshot.data!.docs[index].id,
                                        Keys: Keys,
                                      );
                                    },
                                    icon: const Icon(Icons.edit),
                                    color: blue,
                                    iconSize: 20,
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
                                                .collection('member')
                                                .doc(FirebaseAuth
                                                .instance.currentUser!.uid)
                                                .collection('project')
                                                .doc(snapshot
                                                .data!.docs[index].id)
                                                .delete();
                                            Navigator.pop(context);
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
                text: 'إضافة مشروع',
              );
            }),
      ],
    );
  }
}

void eidtProject(BuildContext context,
    {required String text,
    required indexed,
    // required TextEditingController projectName,
    // required TextEditingController descriptionProject,
    // required TextEditingController leaderName,
    // required String? projectStatus,
    // required TextEditingController memberProjectName,
    required String projectName,
    required String descriptionProject,
    required String leaderName,
    required String? projectStatus,
    required String memberProjectName,
    required GlobalKey<FormState> Keys}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var prov = Provider.of<ProfileProvider>(context);
      var auth = Provider.of<AuthProvider>(context);

      return AlertDialog(
        title: Center(child: Text(text)),
        titleTextStyle: labelStyle,
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        elevation: 10,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: clearblue, width: 10),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Form(
              key: Keys,
              child: Column(
                children: [
                  EidtTextFieldUser(
                    // controller: projectName,
                    onChanged: (val) {
                      prov.projectName = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسم المشروع ';
                      }
                    },
                    hintText: 'اسم المشروع',
                    labelText: "اسم المشروع",
                    scure: false,
                    initialValue: projectName,
                  ),
                  EidtTextFieldUser(
                    // controller: descriptionProject,
                    onChanged: (val) {
                      prov.descriptionProject = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال وصف المشروع ';
                      }
                    },
                    hintText: 'وصف المشروع',
                    labelText: "وصف المشروع",
                    scure: false,
                    initialValue: descriptionProject,
                  ),
                  EidtTextFieldUser(
                    // controller: leaderName,
                    onChanged: (val) {
                      prov.leaderName = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسم القائد ';
                      }
                    },
                    hintText: 'اسم القائد',
                    labelText: "القائد",
                    scure: false,
                    initialValue: leaderName,
                  ),
                  EidtTextFieldUser(
                    // controller: memberProjectName,
                    onChanged: (val) {
                      prov.memberProjectName = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسماء الاعضاء ';
                      }
                    },
                    hintText: 'اسم الاعضاء',
                    labelText: "الاعضاء",
                    scure: false,
                    initialValue: memberProjectName,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'حالة المشروع',
                          style: labelStyle3,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            child: DropdownButton<String>(
                              hint: Text(
                                'اختر حالة المشروع',
                                style: hintStyle,
                              ),
                              value: prov.projectStatus,
                              underline: Container(
                                width: 30,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 1,
                                decoration: const BoxDecoration(
                                    color: gray,
                                    boxShadow: [
                                      BoxShadow(
                                        color: blue,
                                      )
                                    ]),
                              ),
                              onChanged: (newValue) {
                                prov.projectStatus = newValue!;
                              },
                              items: <String>[
                                'غير مكتملة',
                                'مكتملة'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: sizeFromWidth(context, 2.3),
                                    // for example
                                    child:
                                        Text(value, textAlign: TextAlign.left),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          ButtonUser(
              text: 'إالغاء',
              color: redGradient,
              onTap: () {
                Navigator.pop(context);
              }),
          ButtonUser(
              text: 'أضافة',
              color: blueGradient,
              onTap: () async {
                if (auth.usertype == 0) {
                  if (Keys.currentState!.validate()) {
                    Keys.currentState!.save();
                    await FirebaseFirestore.instance
                        .collection('project')
                        .doc(indexed)
                        .update({
                      'projectName': prov.projectName,
                      'descriptionProject': prov.descriptionProject,
                      'leaderName': prov.leaderName,
                      'projectStatus': prov.projectStatus,
                      'memberProjectName': prov.memberProjectName,
                    });
                    Navigator.pop(context);
                  }
                } else if (auth.usertype == 1) {
                  if (Keys.currentState!.validate()) {
                    Keys.currentState!.save();
                    await FirebaseFirestore.instance
                        .collection('project')
                        .doc(indexed)
                        .update({
                      'projectName': prov.projectName,
                      'descriptionProject': prov.descriptionProject,
                      'leaderName': prov.leaderName,
                      'projectStatus': prov.projectStatus,
                      'memberProjectName': prov.memberProjectName,
                    });
                    Navigator.pop(context);
                  }
                }
              }),
        ],
      );
    },
  );
}
