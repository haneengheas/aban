// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:flutter/material.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/widgets/textField.dart';
import 'package:aban/widgets/textfieldtime.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class EditSeminar extends StatefulWidget {
  const EditSeminar({Key? key}) : super(key: key);

  @override
  _EditSeminarState createState() => _EditSeminarState();
}

class _EditSeminarState extends State<EditSeminar> {
  var val;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text('تعديل ندوة',
            style: GoogleFonts.cairo(
              textStyle:const TextStyle(
                  color: blue, fontWeight: FontWeight.bold, fontSize: 28),
            )),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon:const Icon(Icons.arrow_back),
          color: blue,
        ),
      ),
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Container(
          width: sizeFromWidth(context, 1),
          padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          // height: MediaQuery
          //     .of(context)
          //     .size
          //     .height,
          margin:const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: clearblue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              const TextFieldItem(
                labelText: "العنوان",
                scure: true,
                hintText: "عنوان الندوة",
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  'التاريخ',
                  style: hintStyle4,
                ),
              ),
              Container(
                margin:const  EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                padding:const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: TableCalendar(
                  rowHeight: 25,
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
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
                      const TimeTextField(
                        text: '00:00   ص م',
                      ),
                      Text(
                        'إلى',
                        style: hintStyle,
                      ),
                      const  TimeTextField(
                        text: '00:00   ص م',
                      ),
                    ],
                  ),
                ),
              ),
              const TextFieldItem(
                labelText: "الموقع",
                scure: true,
                hintText: "موقع الندوة",
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
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
             const TextFieldItem(
                labelText: "الوصف",
                scure: true,
                hintText: "وصف الندوة",
              ),
              const TextFieldItem(
                labelText: "رابط الوصول الى الندوة",
                scure: true,
                hintText: "الرابط",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [

                    ButtonUser(text: 'حذف الندوة', color: redGradient, onTap: (){
                      showDialogWarning(context, text: 'هل انت متأكد من حذف هذة الندوة');
                    }),
                    ButtonUser(text: 'حفظ التغييرات', color: blueGradient, onTap: (){
                     Navigator.pop(context);
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>SeminarScreen()));
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
