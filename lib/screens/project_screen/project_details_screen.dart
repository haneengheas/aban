// ignore_for_file: must_be_immutable, avoid_print
import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/eidt_text_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailsScreen extends StatefulWidget {
  String nameProject;
  String leader;
  String members;
  String description;
  String status;
  bool isFav;
  String id;
  String userid;
  String projectLink;

  ProjectDetailsScreen({
    Key? key,
    required this.description,
    required this.leader,
    required this.userid,
    required this.members,
    required this.nameProject,
    required this.status,
    required this.isFav,
    required this.projectLink,
    required this.id,
  }) : super(key: key);

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text('مشاريع',
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(
                  color: blue, fontWeight: FontWeight.bold, fontSize: 28),
            )),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);

            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ProjectScreen()));
          },
          icon: const Icon(Icons.arrow_back),
          color: blue,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 320,
              width: sizeFromWidth(context, 1),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: clearblue,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: clearblue),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'اسم المشروع:  ' + widget.nameProject,
                                  style: labelStyle3,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  ' القائد:  ' + widget.leader,
                                  style: hintStyle,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'االاعضاء:  ' + widget.members,
                                  style: hintStyle,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'حالة المشروع',
                                    style: labelStyle3,
                                  ),
                                  Text(widget.status),
                                  prov.counter == 2
                                      ? const SizedBox()
                                      : InkWell(
                                          onTap: () async {
                                            DocumentSnapshot docRef =
                                                await FirebaseFirestore.instance
                                                    .collection('project')
                                                    .doc(widget.id)
                                                    .get();

                                            Map<String, dynamic> docIsFav =
                                                docRef.get("isFav");

                                            if (docIsFav.containsKey(FirebaseAuth
                                                .instance.currentUser!.uid)) {
                                              docIsFav.addAll({
                                                FirebaseAuth
                                                        .instance.currentUser!.uid
                                                        .toString():
                                                    widget.isFav ? false : true
                                              });
                                            } else {
                                              docIsFav.addAll({
                                                FirebaseAuth
                                                        .instance.currentUser!.uid:
                                                    widget.isFav ? false : true
                                              });
                                            }

                                            widget.isFav = !widget.isFav;
                                            setState(() {});

                                            await FirebaseFirestore.instance
                                                .collection('project')
                                                .doc(widget.id)
                                                .update({'isFav': docIsFav});
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 25,
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 10),
                                            child: !widget.isFav
                                                ? const ImageIcon(
                                                    AssetImage(
                                                      'assets/bookmark (1).png',
                                                    ),
                                                    color: blue,
                                                    size: 50,
                                                  )
                                                : const ImageIcon(
                                                    AssetImage(
                                                      'assets/bookmark (2).png',
                                                    ),
                                                    color: blue,
                                                    size: 50,
                                                  ),
                                          ),
                                        ),
                                ]),
                          ),
                        ],
                      ),
                      Text(
                        'وصف المشروع',
                        style: labelStyle3,
                      ),
                      Text(
                        widget.description,
                        style: hintStyle3,
                      ),
                      InkWell(
                          onTap: () async {
                            debugPrint(widget.projectLink);
                            await launch('https://' + widget.projectLink);
                          },
                          child: const Text(
                            'رابط المشروع',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationColor: blue,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: blue),
                          )),
                      widget.userid == FirebaseAuth.instance.currentUser!.uid &&
                              prov.counter != 2
                          ? InkWell(
                              onTap: () {
                                editProject(
                                  context,
                                  text: 'تعديل مشروع',
                                  indexed: widget.id,
                                  projectLink: widget.projectLink,
                                  projectStatus: widget.status,
                                  projectName: widget.nameProject,
                                  memberProjectName: widget.members,
                                  leaderName: widget.leader,
                                  descriptionProject: widget.description,
                                  keys: formKeys,
                                );
                                setState(() {});
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.edit,
                                    color: blue,
                                    size: 15,
                                  ),
                                  Text('تعديل المشروع',
                                      style: TextStyle(
                                          // decoration: TextDecoration.underline,
                                          // decorationThickness: 2,
                                          decorationColor: blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: blue))
                                ],
                              ),
                            )
                          : const SizedBox(),
                      widget.userid == FirebaseAuth.instance.currentUser!.uid &&
                              prov.counter != 2
                          ? InkWell(
                              onTap: () async {
                                print(FirebaseAuth.instance.currentUser!.uid);
                                await showDialogWarning(context,
                                    text: 'هل انت متأكد من حذف المشروع',
                                    ontap: () async {
                                  await FirebaseFirestore.instance
                                      .collection('project')
                                      .doc(widget.id)
                                      .delete()
                                      .then((value) async {
                                    await AwesomeDialog(
                                            context: context,
                                            title: "هام",
                                            body:
                                                const Text("تمت عملية الحذف بنجاح"),
                                            dialogType: DialogType.SUCCES)
                                        .show();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => NavigationFile(
                                                d: studentDrawer(context),
                                                // title:
                                                //     ' مرحبا${provider.userName} ',
                                                counter: prov.counter!)));
                                  });
                                });
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.delete,
                                    color: red,
                                    size: 15,
                                  ),
                                  Text('حذف المشروع',
                                      style: TextStyle(
                                          // decoration: TextDecoration.underline,
                                          // decorationThickness: 2,
                                          decorationColor: red,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: red))
                                ],
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void editProject(BuildContext context,
    {required String text,
    required indexed,
    required String projectName,
    required String descriptionProject,
    required String leaderName,
    required String? projectStatus,
    required String memberProjectName,
    required String projectLink,
    required GlobalKey<FormState> keys}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController? projectName1 =
          TextEditingController(text: projectName);
      TextEditingController? descriptionProject1 =
          TextEditingController(text: descriptionProject);
      TextEditingController? leaderName1 =
          TextEditingController(text: leaderName);
      TextEditingController? memberProjectName1 =
          TextEditingController(text: memberProjectName);
      TextEditingController? projectLink1 =
          TextEditingController(text: projectLink);

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
              key: keys,
              child: Column(
                children: [
                  EidtTextFieldUser(
                    controller: projectName1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسم المشروع ';
                      }
                    },
                    hintText: 'اسم المشروع',
                    labelText: "اسم المشروع",
                    scure: false,
                  ),
                  EidtTextFieldUser(
                    controller: descriptionProject1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال وصف المشروع ';
                      }
                    },
                    hintText: 'وصف المشروع',
                    labelText: "وصف المشروع",
                    scure: false,
                  ),
                  EidtTextFieldUser(
                    controller: leaderName1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسم القائد ';
                      }
                    },
                    hintText: 'اسم القائد',
                    labelText: "القائد",
                    scure: false,
                  ),
                  EidtTextFieldUser(
                    controller: memberProjectName1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسماء الاعضاء ';
                      }
                    },
                    hintText: 'اسم الاعضاء',
                    labelText: "الاعضاء",
                    scure: false,
                  ),
                  EidtTextFieldUser(
                    controller: projectLink1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال رابط المشروع ';
                      }
                    },
                    hintText: 'ادخل رابط المشروع',
                    labelText: "رابط المشروع",
                    scure: false,
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
                              value: projectStatus,
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
                                projectStatus = newValue!;
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
                if (keys.currentState!.validate()) {
                  keys.currentState!.save();
                  await FirebaseFirestore.instance
                      .collection('project')
                      .doc(indexed)
                      .update({
                    'projectName': projectName1.text,
                    'descriptionProject': descriptionProject1.text,
                    'leaderName': leaderName1.text,
                    'projectStatus': projectStatus,
                    'memberProjectName': memberProjectName1.text,
                    'projectLink': projectLink1.text,
                  });
                  Navigator.pop(context);
                  AwesomeDialog(
                          context: context,
                          title: "هام",
                          body: const Text("تمت عملية التعديل بنجاح"),
                          dialogType: DialogType.SUCCES)
                      .show();
                }
              }),
        ],
      );
    },
  );
}
