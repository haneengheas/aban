import 'package:aban/constant/style.dart';
import 'package:aban/screens/registration/regist_screen/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  _EditPasswordScreenState createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
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
                  textStyle: TextStyle(
                      color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                )),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistScreen()));
              },
              icon: Icon(Icons.arrow_back),
              color: blue,
            ),
          ),
          SizedBox(height: 20),
          TextFieldItem(
              hintText: 'Researcher@ksuedu.sa',
              labelText: 'بريديك الجامعي',
              scure: false),
          SizedBox(
            height: 20,
          ),
          SubmitButton(
            text: 'إرسال',
            gradient: blueGradient,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
