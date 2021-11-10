import 'package:aban/constant/style.dart';
import 'package:aban/screens/registration/regist_screen/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  TextEditingController editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Column(
        children: [
          AppBar(
            backgroundColor: white,
            title: Text('إعادة ضبط كلمة المرور',
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                      color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                )),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegistScreen()));
              },
              icon:const Icon(Icons.arrow_back),
              color: blue,
            ),
          ),
          const SizedBox(height: 20),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: editController,

                decoration: InputDecoration(
                  labelText: 'بريديك الجامعي',
                  labelStyle: labelStyle,
                  hintText:'Researcher@ksuedu.sa',
                  hintStyle: hintStyle,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          SubmitButton(
            text: 'إرسال',
            gradient: blueGradient,
            onTap: () {
              resetPassword(context);},
          ),
        ],
      ),
    );
  }

  void resetPassword(BuildContext context) async {
    if (editController.text.isEmpty  ) {
      AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("الرجاء ادخال البريد الجامعي"),
          dialogType: DialogType.ERROR)
          .show();
      // Fluttertoast.showToast(msg: "Enter valid email", backgroundColor: blue);
      return;
    }
    else if (!editController.text.contains("@")){
      AwesomeDialog(
          context: context,
          title: "هام",
          body: const Text("@ إيميل الاستعادة خطأ ،يجب ان يحتوي علي"),
          dialogType: DialogType.ERROR)
          .show();
      // Fluttertoast.showToast(msg: "Enter valid email", backgroundColor: blue);
      return;
    }


    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: editController.text);
    AwesomeDialog(
        context: context,
        title: "هام",
        body: const Text(
            "الرجاء التحقق من بريديك الالكتروني لتغيير كلمة المرور"),
        dialogType: DialogType.SUCCES)
        .show();
    // Fluttertoast.showToast(
    //   msg:
    //   "Reset password link has sent your mail please use it to change the password.",
    //   backgroundColor: blue,);
    // Navigator.pop(context);
  }
}
