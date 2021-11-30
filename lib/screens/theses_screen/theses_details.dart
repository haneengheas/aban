// ignore_for_file: must_be_immutable, avoid_print
import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
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

class ThesesDetails extends StatefulWidget {
  String? nameTheses,
      assistantSupervisors,
      degreeTheses,
      nameSupervisors,
      linkTheses,
      thesesStatus,
      docid,
      userId;
  bool? isFav;

  ThesesDetails({required this.degreeTheses,
    required this.isFav,
    required this.assistantSupervisors,
    required this.linkTheses,
    required this.nameSupervisors,
    required this.nameTheses,
    required this.thesesStatus,
    required this.docid,
    required this.userId,
    Key? key})
      : super(key: key);

  @override
  _ThesesDetailsState createState() => _ThesesDetailsState();
}

class _ThesesDetailsState extends State<ThesesDetails> {
  GlobalKey<FormState> formKeys = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    var provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text('اطروحة',
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
          icon: const Icon(Icons.arrow_back),
          color: blue,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: sizeFromWidth(context, 1),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(
              color: clearblue,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: clearblue),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
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
                              'اسم الاطروحة:  ' + widget.nameTheses!,
                              style: labelStyle3,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              ' المشرف:  ' + widget.nameSupervisors!,
                              style: hintStyle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'المشرفون المساعدون:  ' +
                                  widget.assistantSupervisors!,
                              style: hintStyle,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              ' الدرجة العلمية : ' + widget.degreeTheses!,
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
                                'حالة الاطروحة',
                                style: labelStyle3,
                              ),
                              Text(widget.thesesStatus!),
                              InkWell(
                                onTap: () async {
                                  DocumentSnapshot docRef = await FirebaseFirestore
                                      .instance
                                      .collection('theses')
                                      .doc(widget.docid)
                                      .get();

                                  Map<String, dynamic> docIsFav =
                                  docRef.get("isFav");

                                  if (docIsFav.containsKey(
                                      FirebaseAuth.instance.currentUser!.uid)) {
                                    docIsFav.addAll({
                                      FirebaseAuth.instance.currentUser!.uid
                                          .toString(): widget.isFav! ? false : true
                                    });
                                  } else {
                                    docIsFav.addAll({
                                      FirebaseAuth.instance.currentUser!.uid:
                                      widget.isFav! ? false : true
                                    });
                                  }


                                  widget.isFav = !widget.isFav!;
                                  await FirebaseFirestore.instance
                                      .collection('theses')
                                      .doc(widget.docid)
                                      .update({'isFav': docIsFav});


                                  setState(() {});
                                },
                                child: Container(
                                  height: 40,
                                  width: 25,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: !widget.isFav!
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
                  InkWell(
                      onTap: () async {
                        debugPrint(widget.linkTheses!);
                        await launch('https://' + widget.linkTheses!);
                      },
                      child: const Text(
                        'رابط الاطروحة',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                            decorationColor: blue,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: blue),
                      )),

                  widget.userId == FirebaseAuth.instance.currentUser!.uid
                      ? InkWell(
                    onTap: () {
                      editTheses(context,
                          text: 'تعديل اطروحة',
                          indexed: widget.docid,
                          nameTheses: widget.nameTheses,
                          linkTheses: widget.linkTheses,
                          nameSupervisors: widget.nameSupervisors,
                          assistantSupervisors:
                          widget.assistantSupervisors,
                          degreeTheses: widget.degreeTheses,
                          thesesStatus: widget.thesesStatus,
                          key: formKeys);
                      setState(() {});
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.edit,
                          color: blue,
                          size: 15,
                        ),
                        Text('تعديل الاطروحة',
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
                  widget.userId == FirebaseAuth.instance.currentUser!.uid
                      ? InkWell(
                    onTap: () async {
                      await showDialogWarning(context,
                          text: 'هل انت متأكد من حذف الاطروحة',
                          ontap: () async {

                            await FirebaseFirestore.instance
                                .collection('theses')
                                .doc(widget.docid)
                                .delete().then((value) async{
                             await  AwesomeDialog(
                                  context: context,
                                  title: "هام",
                                  body:
                                  const Text("تمت عملية الحذف بنجاح"),
                                  dialogType: DialogType.SUCCES)
                                  .show();
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                     NavigationFile( d: studentDrawer(context),
                                         title: ' مرحبا${provider.userName} ',
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
                        Text('حذف الاطروحة',
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
          )
        ],
      ),
    );
  }
}

void editTheses(BuildContext context, {
  required String text,
  required indexed,
  required String? nameTheses,
  required String? linkTheses,
  required String? nameSupervisors,
  required String? assistantSupervisors,
  required String? degreeTheses,
  required String? thesesStatus,
  required GlobalKey<FormState> key,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController? nameTheses1 =
      TextEditingController(text: nameTheses);
      TextEditingController? linkTheses1 =
      TextEditingController(text: linkTheses);
      TextEditingController? nameSupervisors1 =
      TextEditingController(text: nameSupervisors);

      TextEditingController? assistantSupervisors1 =
      TextEditingController(text: assistantSupervisors);

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
            height: MediaQuery
                .of(context)
                .size
                .height / 1.2,
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
                                'Master',
                                'Phd'
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
