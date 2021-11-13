import 'package:aban/constant/style.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/textField.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatelessWidget {
   HelpScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
   TextEditingController descriptionController = TextEditingController();
   TextEditingController problemTitleController = TextEditingController();


   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text('مساعدة',
            style: GoogleFonts.cairo(
              textStyle:const TextStyle(
                  color: blue, fontWeight: FontWeight.bold, fontSize: 28),
            )),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:const  Icon(Icons.arrow_back),
          color: blue,
        ),
      ),
      backgroundColor: white,
      body: ListView(
        children: [
          Container(
            width: sizeFromWidth(context, 1),
            height: sizeFromHeight(context, 1.5),
            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: clearblue,
            ),
            child:  Column(
              children: [
                 TextFieldItem(
                  controller: emailController,
                  labelText: "البريد الالكترونى",
                  scure: true,
                  hintText: "Reasearsh@ksuedu.sa",
                ),
                 TextFieldItem(
                   controller: problemTitleController,
                  labelText: "عنوان المشكلة",
                  scure: true,
                  hintText: "العنوان",
                ),
                   TextFieldItem(
                     controller: descriptionController,
                  labelText: "وصف المشكلة",
                  scure: true,
                  hintText: "الوصف",
                ),
                const SizedBox(
                  height: 50,
                ),
                SubmitButton(
                    gradient: blueGradient, text: "ارسال", onTap: () async{
                      await FirebaseFirestore.instance.collection('help').add(
                          {
                            'email':emailController.text,
                            'problemTitle':problemTitleController.text,
                            'description':descriptionController.text,
                            'userId':FirebaseAuth.instance.currentUser!.uid,
                          });
                      Navigator.pop(context);

                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
