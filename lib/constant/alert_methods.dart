import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showDialogWarning(BuildContext context, {required String text}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: clearblue, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: Container(
            width: sizeFromWidth(context, 1),
            height: 40,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              text,
              style: labelStyle2,
            )),
        actions: <Widget>[
          ButtonUser(
              text: 'لا',
              color: blueGradient,
              onTap: () {
                Navigator.pop(context);
              }),
          ButtonUser(
              text: 'نعم',
              color: redGradient,
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      );
    },
  );
}

void showDialogTheses(BuildContext context, {required String text}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var prov = Provider.of<ProfileProvider>(context);
      return AlertDialog(
        title: Center(child: Text(text)),
        titleTextStyle: labelStyle,
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        elevation: 10,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: clearblue, width: 10),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.7,
            child: Column(
              children: [
                TextFieldUser(
                  hintText: 'اسم الاطروحة',
                  labelText: "اسم الاطروحة",
                  scure: false,
                  onChanged: (val) {
                    prov.nameTheses = val;
                  },
                ),
                TextFieldUser(
                    onChanged: (val) {
                      prov.linkTheses = val;
                    },
                    hintText: 'رابط الاطروحة',
                    labelText: 'رابط الاطروحة',
                    scure: false),
                TextFieldUser(
                    onChanged: (val) {
                      prov.nameSupervisors = val;
                    },
                    hintText: 'اسم المشرف',
                    labelText: "المشرف",
                    scure: false),
                TextFieldUser(
                    onChanged: (val) {
                      prov.assistantSupervisors = val;
                    },
                    hintText: 'اسماء المشرفين المساعدين',
                    labelText: "المشرفون المساعدون",
                    scure: false),
                TextFieldUser(
                    onChanged: (val) {
                      prov.degreeTheses = val;
                    },
                    hintText: 'اختر الدرجة العمليه',
                    labelText: "الدرجة العلميه",
                    scure: false),
                TextFieldUser(
                    onChanged: (val) {
                      prov.thesesStatus = val;
                    },
                    hintText: 'اختر حالة الاطروحة',
                    labelText: "حالة الاطروحة",
                    scure: false),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          ButtonUser(
              text: 'إالغاء',
              color: redGradient,
              onTap: () {
                Navigator.pop(context);
              }),
          ButtonUser(
              text: 'أضافة',
              color: blueGradient,
              onTap: () {
                Navigator.pop(context);
              }),
        ],
      );
    },
  );
}

// void showDialogProject(BuildContext context, {required String text}) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Center(child: Text(text)),
//         titleTextStyle: labelStyle,
//         titlePadding: const EdgeInsets.symmetric(vertical: 20),
//         elevation: 10,
//         shape: const RoundedRectangleBorder(
//             side: BorderSide(color: clearblue, width: 10),
//             borderRadius: BorderRadius.all(Radius.circular(15))),
//         content: SingleChildScrollView(
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height / 2.5,
//             child: Column(
//               children: [
//                 TextFieldUser(
//                     onChanged: () {},
//                     hintText: 'اسم المشروع',
//                     labelText: "اسم المشروع",
//                     scure: false),
//                 TextFieldUser(
//                     onChanged: () {},
//                     hintText: 'وصف المشروع',
//                     labelText: "وصف المشروع",
//                     scure: false),
//                 TextFieldUser(
//                     onChanged: () {},
//                     hintText: 'اسم القائد',
//                     labelText: "القائد",
//                     scure: false),
//                 TextFieldUser(
//                     onChanged: () {},
//                     hintText: 'اختر حالة المشروع',
//                     labelText: "حالة المشروع",
//                     scure: false),
//               ],
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           ButtonUser(
//               text: 'إالغاء',
//               color: redGradient,
//               onTap: () {
//                 Navigator.pop(context);
//               }),
//           ButtonUser(
//               text: 'أضافة',
//               color: blueGradient,
//               onTap: () {
//                 Navigator.pop(context);
//               }),
//         ],
//       );
//     },
//   );
// }
