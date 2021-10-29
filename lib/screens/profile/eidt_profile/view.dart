// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/screens/profile/eidt_profile/list_project_item.dart';
import 'package:aban/screens/profile/eidt_profile/project_item.dart';
import 'package:aban/screens/profile/eidt_profile/theses_montor_accpet_item.dart';
import 'package:aban/screens/profile/eidt_profile/theses_montor_item.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'information_items.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var val;
  // getData()async{
  //   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //       .collection("member")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //
  //   debugPrint('userType is ${documentSnapshot.get('name')}');
  //
  //   var usertype = documentSnapshot.get('name') ;
  //
  // }

  @override
void initState(){
    // getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text('تعديل ملفك الشخصي',
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
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const InformationItem(),
            const ThesesMontorAccpetItem(),
            const Divider(
              height: 10,
              thickness: 1,
              color: lightGray,
            ),
            const ListProjectItem(),
            const Divider(
              height: 10,
              thickness: 1,
              color: lightGray,
            ),
            const ThesesGraduatedMontorItem(),
            const Divider(
              height: 20,
              thickness: 1,
              color: lightGray,
            ),
            const ProjectItem(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  ButtonUser(
                      text: 'حفظ التغيرات',
                      color: blueGradient,
                      onTap: () {
                        showDialogWarning(context,
                            text: 'هل انت متاكد من إالغاء التغييرات ؟');
                      }),
                  ButtonUser(text: 'الغاء', color: redGradient, onTap: () {}),
                ],
              ),
            ),
            Center(
                child: ButtonUser(
                    text: 'حذف الحساب',
                    color: grayGradient,
                    onTap: () {
                      showDialogWarning(context,
                          text: 'هل انت متاكد من حذف الحساب ؟');
                    }))
          ],
        )),
      ),
    );
  }
}
