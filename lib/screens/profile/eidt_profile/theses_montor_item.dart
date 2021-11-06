import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/loading_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/eidt_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ThesesGraduatedMontorItem extends StatefulWidget {
  const ThesesGraduatedMontorItem({Key? key}) : super(key: key);

  @override
  _ThesesGraduatedMontorItemState createState() =>
      _ThesesGraduatedMontorItemState();
}

class _ThesesGraduatedMontorItemState extends State<ThesesGraduatedMontorItem> {
  TextEditingController nameTheses = TextEditingController();
  TextEditingController linkTheses = TextEditingController();
  TextEditingController assistantSupervisor = TextEditingController();
  TextEditingController nameSupervisors = TextEditingController();
  TextEditingController degreeTheses = TextEditingController();
  String? thesesStatus;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> Key = GlobalKey<FormState>();

  dynamic indexed;

  void getData() async {
    QuerySnapshot<Map<String, dynamic>> documentSnapshot2 =
        await FirebaseFirestore.instance
            .collection('theses')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .get();
    debugPrint('userType is ${documentSnapshot2.docs[0]['nameTheses']}');
    nameTheses.text = documentSnapshot2.docs[0].get('nameTheses');
    // linkTheses.text = documentSnapshot2.get('faculty');
    // link.text = documentSnapshot2.get('link');
    // phone.text = documentSnapshot2.get('phone');
    // degree.text = documentSnapshot2.get('degree');
    // id.text = documentSnapshot2.get('id');
    // image = documentSnapshot2.get('imageUrl');
    // field = documentSnapshot2.get('fields');
    // accept = documentSnapshot2.get('accept');

    setState(() {});
  }

  @override
  void initState() {
    getData();
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
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              'اسم الاطروحة : ${snapshot.data!.docs[index]['nameTheses']}',
                                              style: hintStyle5,
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
                                        const VerticalDivider(
                                          color: gray,
                                          endIndent: 10,
                                          indent: 10,
// width: 1,
                                          thickness: 2,
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]
                                              ['degreeTheses'],
                                          style: hintStyle5,
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
                                          key: Key,
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
              showDialogTheses(
                context,
                text: 'إضافة اطروحة',
              );
            }),
      ],
    );
  }
}

void editTheses(
  BuildContext context, {
  required String text,
  required indexed,
  // required TextEditingController nameTheses,
  // required TextEditingController linkTheses,
  // required TextEditingController nameSupervisors,
  // required TextEditingController assistantSupervisors,
  // required TextEditingController degreeTheses,
  required String nameTheses,
  required String linkTheses,
  required String nameSupervisors,
  required String assistantSupervisors,
  required String degreeTheses,
  required String? thesesStatus,
  required GlobalKey<FormState> key,
}) {
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
            height: MediaQuery.of(context).size.height / 1.2,
            child: Form(
              key: key,
              child: Column(
                children: [
                  EidtTextFieldUser(
                    // controller: nameTheses,
                    hintText: 'اسم الاطروحة',
                    labelText: "اسم الاطروحة",
                    scure: false,
                    onChanged: (val) {
                      prov.nameTheses = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسم الاطروحة ';
                      }
                    },
                    initialValue: nameTheses,
                  ),
                  EidtTextFieldUser(
                    // controller: linkTheses,
                    onChanged: (val) {
                      prov.linkTheses = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال رابط الاطروحة ';
                      }
                    },
                    hintText: 'رابط الاطروحة',
                    labelText: 'رابط الاطروحة',
                    scure: false,
                    initialValue: linkTheses,
                  ),
                  EidtTextFieldUser(
                    // controller: nameSupervisors,
                    onChanged: (val) {
                      prov.nameSupervisors = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسماء المشرفين  ';
                      }
                    },
                    hintText: 'اسم المشرف',
                    labelText: "المشرف",
                    scure: false,
                    initialValue: nameSupervisors,
                  ),
                  EidtTextFieldUser(
                    // controller: assistantSupervisors,
                    onChanged: (val) {
                      prov.assistantSupervisors = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال اسماء المشرفين المساعدين ';
                      }
                    },
                    hintText: 'اسماء المشرفين المساعدين',
                    labelText: "المشرفون المساعدون",
                    scure: false,
                    initialValue: assistantSupervisors,
                  ),
                  EidtTextFieldUser(
                    // controller: degreeTheses,
                    onChanged: (val) {
                      prov.degreeTheses = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال الدرجة العلمية ';
                      }
                    },
                    hintText: 'اختر الدرجة العمليه',
                    labelText: "الدرجة العلميه",
                    scure: false,
                    initialValue: degreeTheses,
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
                              value: prov.thesesStatus,
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
                                prov.thesesStatus = newValue!;
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
                print(auth.usertype);
                if (auth.usertype == 0) {
                  print(auth.usertype);
                  if (key.currentState!.validate()) {
                    key.currentState!.save();
                    await FirebaseFirestore.instance
                        .collection('theses')
                        .doc(indexed)
                        .update({
                      'nameTheses': prov.nameTheses,
                      'linkTheses': prov.linkTheses,
                      'assistantSupervisors': prov.assistantSupervisors,
                      'nameSupervisors': prov.nameSupervisors,
                      'degreeTheses': prov.degreeTheses,
                      'thesesStatus': prov.thesesStatus,
                    });
                    Navigator.pop(context);
                  }
                } else {
                  if (key.currentState!.validate()) {
                    key.currentState!.save();
                    showLoading(context);
                    await FirebaseFirestore.instance
                        .collection('theses')
                        .doc(indexed)
                        .update({
                      'nameTheses': nameTheses,
                      'linkTheses': linkTheses,
                      'assistantSupervisors': assistantSupervisors,
                      'nameSupervisors': nameSupervisors,
                      'degreeTheses': degreeTheses,
                      'thesesStatus': thesesStatus,
                    });
                  }
                  Navigator.pop(context);
                }
              }),
        ],
      );
    },
  );
}
