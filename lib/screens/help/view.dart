import 'package:aban/constant/style.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/textField.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

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
                const TextFieldItem(
                  labelText: "البريد الالكترونى",
                  scure: true,
                  hintText: "Reasearsh@ksuedu.sa",
                ),
                const TextFieldItem(
                  labelText: "عنوان المشكلة",
                  scure: true,
                  hintText: "العنوان",
                ),
                const   TextFieldItem(
                  labelText: "وصف المشكلة",
                  scure: true,
                  hintText: "الوصف",
                ),
                const SizedBox(
                  height: 50,
                ),
                SubmitButton(
                    gradient: blueGradient, text: "ارسال", onTap: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
