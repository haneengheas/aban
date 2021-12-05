// ignore_for_file: avoid_print, must_be_immutable

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/eidt_text_field.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ThesesGraduatedMontorItem extends StatefulWidget {
  String ?college ;
  String ?department;
  ThesesGraduatedMontorItem({
    this.department,
    this.college,
    Key? key}) : super(key: key);

  @override
  _ThesesGraduatedMontorItemState createState() =>
      _ThesesGraduatedMontorItemState();
}

class _ThesesGraduatedMontorItemState extends State<ThesesGraduatedMontorItem> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  dynamic indexed;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "اطروحات تحت اشرافك :",
            style: labelStyle3,
          ),
        ),
        Row(
          children: [
            SizedBox(
              height: 100,
              width: sizeFromWidth(context, 1),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('theses')
                      .where('userId',
                          isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('');
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  width: sizeFromWidth(context, 1.5),
                                  padding:  const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: clearblue,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                'اسم الاطروحة : ${snapshot.data!.docs[index]['nameTheses']}',
                                                style: hintStyle5
                                              ),
                                              Text(
                                                'المشرف: ${snapshot.data!.docs[index]['nameSupervisors']}',
                                                style: hintStyle5,
                                              ),
                                              Text(
                                                ' المشرفون المساعدون: ${snapshot.data!.docs[index]['assistantSupervisors']}',
                                                style: hintStyle5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const VerticalDivider(
                                          color: gray,
                                          endIndent: 10,
                                          indent: 10,
                                          thickness: 2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                ['degreeTheses'],
                                            style: hintStyle5,
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
                                      editTheses(context,
                                          text: 'تعديل اطروحة',
                                          key: key,
                                          indexed:
                                              snapshot.data!.docs[index].id,
                                          degreeTheses: snapshot.data!
                                              .docs[index]['degreeTheses'],
                                          assistantSupervisors:
                                              snapshot.data!.docs[index]
                                                  ['assistantSupervisors'],
                                          linkTheses: snapshot.data!.docs[index]
                                              ['linkTheses'],
                                          nameSupervisors: snapshot.data!
                                              .docs[index]['nameSupervisors'],
                                          nameTheses: snapshot.data!.docs[index]
                                              ['nameTheses'],
                                          thesesStatus: snapshot.data!
                                              .docs[index]['thesesStatus']);
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
                                            .collection('theses')
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();

                                        // setState(() {
                                        //
                                        // });

                                        Navigator.pop(context);
                                        AwesomeDialog(
                                                context: context,
                                                title: "هام",
                                                body: const Text(
                                                    "تمت عملية الحذف بنجاح"),
                                                dialogType: DialogType.SUCCES)
                                            .show();
                                      });
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    iconSize: 20,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
          ],
        ),
        ButtonUser(
            text: "اضافة اطروحة",
            color: blueGradient,
            onTap: () {
              print(widget.college);
              print(widget.department);
              showDialogTheses(
                context,
                text: 'إضافة اطروحة',
                department:widget.department!,
               college: widget.college!);
            }),
      ],
    );
  }
}

void editTheses(
  BuildContext context, {
  required String text,
  required indexed,

  required String? nameTheses,
  required String ? linkTheses,
  required String ? nameSupervisors,
  required String ? assistantSupervisors,
  required String ? degreeTheses,
  required String? thesesStatus,
  required GlobalKey<FormState> key,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController? nameTheses1= TextEditingController(text: nameTheses);
      TextEditingController? linkTheses1= TextEditingController(text: linkTheses);
      TextEditingController? nameSupervisors1= TextEditingController(text: nameSupervisors);
      TextEditingController? assistantSupervisors1= TextEditingController(text: assistantSupervisors);





      //     TextEditingController linkTheses1,
      // TextEditingController nameSupervisors1,
      // TextEditingController assistantSupervisors1,
      // TextEditingController degreeTheses1,
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
            height: MediaQuery.of(context).size.height / 1.2,
            child: Form(
              key: key,
              child: Column(
                children: [
                  EidtTextFieldUser(
                   controller: nameTheses1,
                    hintText: 'اسم الاطروحة',
                    labelText: "اسم الاطروحة",
                    scure: false,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسم الاطروحة ';
                      }
                    },

                  ),
                  EidtTextFieldUser(
                     controller: linkTheses1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال رابط الاطروحة ';
                      }
                    },
                    hintText: 'رابط الاطروحة',
                    labelText: 'رابط الاطروحة',
                    scure: false,

                  ),
                  EidtTextFieldUser(
                   controller: nameSupervisors1,

                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسماء المشرفين  ';
                      }
                    },
                    hintText: 'اسم المشرف',
                    labelText: "المشرف",
                    scure: false,

                  ),
                  EidtTextFieldUser(
                    controller: assistantSupervisors1,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسماء المشرفين المساعدين ';
                      }
                    },
                    hintText: 'اسماء المشرفين المساعدين',
                    labelText: "المشرفون المساعدون",
                    scure: false,

                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الدرجة العلمية',
                          style: labelStyle3,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            child: DropdownButton<String>(
                              hint: Text(
                                'اخترالدرجة العلمية',
                                style: hintStyle,
                              ),
                              value: degreeTheses,
                              underline: Container(
                                width: 30,
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                height: .5,
                                decoration: const BoxDecoration(
                                    color: gray,
                                    boxShadow: [
                                      BoxShadow(
                                        color: blue,
                                      )
                                    ]),
                              ),
                              onChanged: (newValue) {
                                degreeTheses = newValue!;
                              },
                              items: <String>[
                                'Bachelor',
                                'Master',
                                'PhD'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: sizeFromWidth(context, 2.3),
                                    // for example
                                    child:
                                    Text(value, textAlign: TextAlign.right),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'حالة الاطروحة',
                          style: labelStyle3,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            child: DropdownButton<String>(
                              hint: Text(
                                'اختر حالة الاطروحة',
                                style: hintStyle,
                              ),
                              value: thesesStatus,
                              underline: Container(
                                width: 30,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: .5,
                                decoration: const BoxDecoration(
                                    color: gray,
                                    boxShadow: [
                                      BoxShadow(
                                        color: blue,
                                      )
                                    ]),
                              ),
                              onChanged: (newValue) {
                                thesesStatus = newValue!;
                              },
                              items: <String>[
                                'غير مكتملة',
                                'مكتملة'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: sizeFromWidth(context, 2.3),
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
                print(indexed);
                if (key.currentState!.validate()) {
                  key.currentState!.save();
                  print(indexed);
                  await FirebaseFirestore.instance
                      .collection('theses')
                      .doc(indexed)
                      .update({
                    'nameTheses': nameTheses1.text,
                    'linkTheses': linkTheses1.text,
                    'assistantSupervisors': assistantSupervisors1.text,
                    'nameSupervisors': nameSupervisors1.text,
                    'degreeTheses': degreeTheses,
                    'thesesStatus': thesesStatus,
                  });
                  Navigator.pop(context);
                  AwesomeDialog(
                      context: context,
                      title: "هام",
                      body: const Text("تمت عملية التعديل  بنجاح"),
                      dialogType: DialogType.SUCCES)
                      .show();
                }
              }),
        ],
      );
    },
  );
}
