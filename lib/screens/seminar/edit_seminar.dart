// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:aban/widgets/textfieldtime.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class EditSeminar extends StatefulWidget {
  const EditSeminar({Key? key}) : super(key: key);

  @override
  _EditSeminarState createState() => _EditSeminarState();
}

class _EditSeminarState extends State<EditSeminar> {
  var val;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController from = TextEditingController();

  TextEditingController to = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController link = TextEditingController();
  DateTime? _selectedDay;
  DateTime? _focusedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  void getData() async {
    QuerySnapshot documentSnapshot2 = await FirebaseFirestore.instance
        .collection("seminar")
        .where('userId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

    name.text = documentSnapshot2.docs[0]['seminarAddress'];
    from.text = documentSnapshot2.docs[0]['from'];
    to.text = documentSnapshot2.docs[0]['to'];
    link.text = documentSnapshot2.docs[0]['link'];
    discription.text = documentSnapshot2.docs[0]['description'];
    location.text = documentSnapshot2.docs[0]['location'];
    _selectedDay = documentSnapshot2.docs[0]['selectedDay'];
    print(name);
    print(link);
    print("=/=/=/=//==/=//==/=/=//=//=/==/=/=/");


    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var prov = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      // prov.fields.clear();
      // prov.file = File('');
      setState(() {});
    });
    getData();
    print(name.text);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text('تعديل ندوة',
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
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Container(
            width: sizeFromWidth(context, 1),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            // height: MediaQuery
            //     .of(context)
            //     .size
            //     .height,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: clearblue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextFieldUser(
                    labelText: "العنوان",
                    scure: false,
                    hintText: "ادخل العنوان",
                    onChanged: (val) {
                      prov.seminaraddress = val ;
                    },
                    controller: name,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'فضلا أدخل عنوان الندوة';
                      }
                    }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'التاريخ',
                    style: hintStyle4,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child:TableCalendar(
                    rowHeight: 30,
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay =
                            focusedDay; // update `_focusedDay` here as well
                      });
                    },
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    'الوقت',
                    style: hintStyle4,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: [
                        Text(
                          'من',
                          style: hintStyle,
                        ),
                        TimeTextField(
                          onChanged: (val) {
                            prov.from = val ;
                          },
                          controller: from,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'فضلا أدخل وقت بداية الندوة';
                            }
                          },
                          text: '00:00   ص م',
                        ),
                        Text(
                          'إلى',
                          style: hintStyle,
                        ),
                        TimeTextField(
                          onChanged: (val) {
                            prov.to= val ;
                          },
                          controller: to,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'فضلا أدخل وقت بداية الندوة';
                            }
                          },
                          text: '00:00   ص م',
                        ),
                      ],
                    ),
                  ),
                ),
                 TextFieldUser(
                   onChanged: (val){
                     prov.location = val;
                   },
                   controller: location,
                   validator: (value) {
                     if (value.isEmpty) {
                       return 'فضلا أدخل موقع الندوة';
                     }
                   },
                  labelText: "الموقع",
                  scure: true,
                  hintText: "موقع الندوة",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Text(
                    'النوع',
                    style: hintStyle4,
                  ),
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Radio(
                              value: 1,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value;
                                });
                              }),
                          Text('عامة', style: hintStyle3),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: 2,
                              groupValue: val,
                              onChanged: (value) {
                                setState(() {
                                  val = value;
                                });
                              }),
                          Text(
                            'خاصة',
                            style: hintStyle3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                TextFieldUser(
                    labelText: "الوصف",
                    scure: false,
                    hintText: "وصف الندوة",
                    onChanged: (val) {
                      prov.description=val;
                    },
                    controller: discription,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'فضلا أضف وصفا للندوة';
                      }
                    }),
                TextFieldUser(
                    labelText: "رابط الوصول الى الندوة",
                    scure: true,
                    hintText: "الرابط",
                    onChanged: (val) {
                      prov.seminarlink=val;
                    },
                    controller: link,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'فضلا أدخل رابط الوصول للندوة';
                      }
                    }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      ButtonUser(
                          text: 'حذف الندوة',
                          color: redGradient,
                          onTap: () {
                            showDialogWarning(context,
                                ontap: () {},
                                text: 'هل انت متأكد من حذف هذة الندوة');
                          }),
                      ButtonUser(
                          text: 'حفظ التغييرات',
                          color: blueGradient,
                          onTap: () async {
                            showDialogWarning(context, ontap: () async {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();

                                await FirebaseFirestore.instance
                                    .collection('seminar')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  'seminaraddress': name.text,
                                  'description': discription.text,
                                  'location': location.text,
                                  'link': link.text,
                                  'from':from.text,
                                  'to': to.text

                                }).then((value) {
                                  Navigator.pop(context);
                                  AwesomeDialog(
                                          context: context,
                                          title: "هام",
                                          body: const Text(
                                              "تمت عملية التعديل بنجاح"),
                                          dialogType: DialogType.SUCCES)
                                      .show();
                                });
                              }

                              print(name);
                            }, text: 'هل انت متاكد من حفظ التغييرات ؟');
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
