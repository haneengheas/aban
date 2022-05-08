// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, must_be_immutable

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:aban/widgets/textfieldtime.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AddSeminar extends StatefulWidget {
  String? seminaraddress, location, description, link, from, to;
  int? type;

  AddSeminar({Key? key}) : super(key: key);

  @override
  _AddSeminarState createState() => _AddSeminarState();
}

class _AddSeminarState extends State<AddSeminar> {
  var val;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text('إضافة ندوة',
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
        child: SingleChildScrollView(
          child: Container(
            width: sizeFromWidth(context, 1),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: clearblue,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFieldUser(
                    labelText: "العنوان",
                    scure: false,
                    hintText: "عنوان الندوة",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'ادخل عنوان الندوة';
                      }
                    },
                    onChanged: (val) {
                      prov.seminaraddress = val;
                    },
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
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: TableCalendar(
                      rowHeight: 30,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: DateTime.now(),
                      selectedDayPredicate: (day) {
                        return isSameDay(prov.selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          prov.selectedDay = selectedDay;
                          prov.focusedDay = focusedDay; //
                          // update `_focusedDay` here as well
                        });
                      },
                      calendarFormat: prov.calendarFormat,
                      onFormatChanged: (format) {
                        setState(() {
                          prov.calendarFormat = format;
                        });
                      },
                      onPageChanged: (focusedDay) {
                        prov.focusedDay = focusedDay;
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

                  // ),

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
                          SizedBox(
                            width: 90,
                            child: TimeTextField(
                              onChanged: (val) {
                                prov.from = val;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'فضلا أدخل وقت بداية الندوة';
                                }
                              },
                              text: '00:00',
                            ),
                          ),
                          // TimeDropDown(val: prov.dropdownValue,)
                          DropdownButton<String>(
                            value: prov.dropdownValue,
                              onChanged: ( newValue) {
                                setState(() {
                                  prov.dropdownValue = newValue!;
                                });
                              },

                              items: <String>[ 'pm', 'am'].map<DropdownMenuItem<String>>
                                ((String? value ){
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value!));
                              }).toList()),

                          Text(
                            'إلى',
                            style: hintStyle,
                          ),
                          SizedBox(width: 90,
                            child: TimeTextField(
                              onChanged: (val) {
                                prov.to = val;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'فضلا أدخل وقت انتهاء الندوة';
                                }
                              },
                              text: '00:00 ',
                            ),
                          ),
                          // TimeDropDown(val: prov.dropdownValue2,)
                          DropdownButton<String>(
                              value: prov.dropdownValue2,
                              onChanged: ( newValue) {
                                setState(() {
                                  prov.dropdownValue2 = newValue!;
                                });
                              },

                              items: <String>[ 'pm', 'am'].map<DropdownMenuItem<String>>
                                ((String? value ){
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value!));
                              }).toList()),
                        ],
                      ),
                    ),
                  ),
                  TextFieldUser(
                    labelText: "الموقع",
                    scure: false,
                    hintText: "موقع الندوة",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'ادخل موقع الندوة';
                      }
                    },
                    onChanged: (val) {
                      prov.location = val;
                    },
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
                                groupValue: prov.type,
                                onChanged: (value) {
                                  setState(() {
                                    prov.type = value as int?;
                                  });
                                }),
                            Text('عامة', style: hintStyle3),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                value: 2,
                                groupValue: prov.type,
                                onChanged: (value) {
                                  setState(() {
                                    prov.type = value as int?;
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
                    labelText: "الندوة",
                    scure: false,
                    hintText: "وصف الندوة",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'ادخل وصفا للندوة';
                      }
                    },
                    onChanged: (val) {
                      prov.description = val;
                    },
                  ),
                  TextFieldUser(
                    labelText: "الرابط",
                    scure: false,
                    hintText: "ادخل رابط الندوة",
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'ادخل رابط الندوة';
                      }
                    },
                    onChanged: (val) {
                      prov.seminarlink = val;
                    },
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: RichText(
                      text: TextSpan(
                          text: 'ملاحظة: ',
                          style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12)),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  'عند اضافة ندوة قادمة سيتم حذفها تلقائيابعد انتهاء موعدها؛ و يمكنك اضافتهالاحقا كندوة مكتملة لاجل توثيقها',
                              style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11)),
                            ),
                          ]),
                    ),
                  ),
                  Center(
                    child: SubmitButton(
                        gradient: blueGradient,
                        text: "إضافة",
                        onTap: () async {
                          print(prov.calendarFormat);
                          print(prov.focusedDay);
                          print(prov.selectedDay);
                          print(prov.seminaraddress);
                          print(prov.location);
                          print(prov.type);
                          print(prov.from);
                          print(prov.nameUser);

                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            await prov.addSeminar(
                                context: context,
                                seminaraddress: prov.seminaraddress,
                                name: prov.nameUser,
                                location: prov.location,
                                description: prov.description,
                                seminarlink: prov.seminarlink,
                                from: prov.from,
                                to: prov.to,
                                type: prov.type,
                                selectedDay: prov.selectedDay,
                                timedrop: prov.dropdownValue,
                                timedrop2: prov.dropdownValue2,
                            );
                          }

                          print('=/=//=/=/////=====/=//=/=/=/');
                        }),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
