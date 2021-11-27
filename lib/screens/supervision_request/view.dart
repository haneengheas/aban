// ignore_for_file: avoid_print, must_be_immutable

import 'dart:convert';
import 'package:aban/constant/style.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:aban/widgets/textField.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SupervisionScreen extends StatefulWidget {
  String? userid;
  String ? token;

  SupervisionScreen({required this.userid,required this.token, Key? key}) : super(key: key);

  @override
  State<SupervisionScreen> createState() => _SupervisionScreenState();
}

class _SupervisionScreenState extends State<SupervisionScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController cvController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();



  var serverToken =
      'AAAAbeSU8yI:APA91bGd-C-K5jzv88l-BgOph56JG-jATdZGMwGWwa1hmHG1P_F7xuZu7C0poeb2Pf2upHDmJsT-Q0YRAPgZ9CyJLMr_29Oexf5_AfpmsJxRtE_tNbNZAPvsENC8GsTAwpMyADFM5Ozl';

  sendNotification(
      {required String body, required String title}) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString(),
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': widget.token,
        },
      ),
    );
  }

  getMassege() {
    FirebaseMessaging.onMessage.listen((event) {
      print('===============notification===========');
      print(event.notification!.title);
      print(event.notification!.body);
      print(event.data['id']);
      print(event.data['status']);
    });
  }

  @override
  void initState() {
    print('-------------------------------');
    print(widget.token);
    getMassege();
    super.initState();
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
              child: Form(
                key:formKey,
                child: Column(
                  children: [
                    TextFieldItem(
                        controller: nameController,
                        hintText: 'العنوان',
                        labelText: "عنوان الاطروحة",
                        validator: (val){
                          if(val.isEmpty){
                            return 'يجب ادخال عنوان الاطروحة' ;
                          }
                        },
                        scure: false),
                    TextFieldItem(
                        controller: descriptionController,
                        hintText: 'الوصف',
                        labelText: "وصف الاطروحة",
                        validator: (val){
                          if(val.isEmpty){
                            return 'يجب ادخال وصف الاطروحة' ;
                          }
                        },
                        scure: false),
                    TextFieldItem(
                        controller: cvController,
                        hintText: 'ادخل سيرتك الذاتية',
                        labelText: "السيرة الذاتية",
                        scure: false),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    SubmitButton(
                        gradient: blueGradient,
                        text: 'ارسال',
                        onTap: () async {
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();
                            await FirebaseFirestore.instance
                                .collection('super')
                                .add({
                              'name': nameController.text,
                              'description': descriptionController.text,
                              'receiveId': widget.userid,
                              'Cv':cvController.text,
                              'sendId': FirebaseAuth.instance.currentUser!.uid,
                            }).then((value) {
                              Navigator.pop(context);
                              return AwesomeDialog(
                                  context: context,
                                  title: "هام",
                                  body: const Text("تم الارسال بنجاح"),
                                  dialogType: DialogType.SUCCES)
                                ..show();

                            });
                            await sendNotification(body:nameController.text ,title: 'طلب أشراف جديد');

                          }

                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
