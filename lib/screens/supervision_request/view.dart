import 'package:aban/constant/style.dart';
import 'package:aban/screens/profile/facultymember/overview_profile/view.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:aban/widgets/textField.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SupervisionScreen extends StatelessWidget {
  const SupervisionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: customAppBar(context, title: 'طلب اشراف'),
          preferredSize: Size.fromHeight(50)),
      body: Column(
        children: [
          Text(
            'ارسال طلب اشراف علي اطروحة',
            style: hintStyle3,
          ),
          Container(
            height: 400,
            margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: lightgray,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                TextFieldItem(
                    hintText: 'العنوان',
                    labelText: "عنوان الاطروحة",
                    scure: false),
                TextFieldItem(
                    hintText: 'الوصف', labelText: "وصف الاطروحة", scure: false),
                Expanded(
                  child: SizedBox(
                  ),
                ),
                SubmitButton(gradient: blueGradient, text: 'ارسال', onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MemberProfile()));
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
