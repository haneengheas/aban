import 'dart:io';

import 'package:aban/constant/loading_methods.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ProfileProvider with ChangeNotifier {
  late String name;
  var name2;
  late String faculty;
  late String phone;
  File? file = File('');
  late Reference ref;
  late String imageurl;
  late String email;
  late String id;
  late String link;
  var accept;
  String? degree;

  String? seminaraddress, location, description, seminarlink,from , to;
  int? type;
  DateTime? selectedDay;
  DateTime? focusedDay;
  CalendarFormat calendarFormat = CalendarFormat.month;


  List<TextEditingController> fields = <TextEditingController>[];
  late String nameTheses;
  late String linkTheses;
  late String assistantSupervisors;
  late String nameSupervisors;
  String? degreeTheses;

  String? thesesStatus;

  late String projectName;
  late String descriptionProject;
  late String leaderName;
  late String memberProjectName;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  String? projectStatus;
  bool? isFav;

  String college = '';
  String department = '';

// methods to add and create member profile in fire base
  createMemberProfile({
    required BuildContext context,
    required String name,
    required String department,
    required String faculty,
    required String phone,
    required List<String> fields,
    required String id,
    required String degree,
    required String link,
    required var accept,
    required File file,
    required String email,
  }) async {
    // if (file == null)
    //   return AwesomeDialog(
    //       context: context,
    //       title: "هام",
    //       body: Text("please choose Image"),
    //       dialogType: DialogType.ERROR)
    //     ..show();
    showLoading(context);
    await ref.putFile(file);
    var imageUrl = await ref.getDownloadURL();
    await FirebaseFirestore.instance
        .collection('member')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'faculty': faculty,
      'phone': phone,
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'id': id,
      'fields': fields,
      'degree': degree,
      'link': link,
      'accept': accept,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'department': department,
    });
    showLoading(context);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NavigationFile(
                  d: studentDrawer(context),
                  title: 'مرحبا $name  ً',
                  counter: 1,
                )));
    notifyListeners();
  }

// methods to add theses for member in fire base
  addThesesMember({
    required BuildContext context,
    required String nameTheses,
    required String linkTheses,
    required String assistantSupervisors,
    required String nameSupervisors,
    required String? degreeTheses,
    required String? thesesStatus,
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance.collection('theses').add({
      'nameTheses': nameTheses,
      'linkTheses': linkTheses,
      'assistantSupervisors': assistantSupervisors,
      'nameSupervisors': nameSupervisors,
      'degreeTheses': degreeTheses,
      'thesesStatus': thesesStatus,
      'isFav': false,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    Navigator.pop(context);
    notifyListeners();
  }

// methods to add project for member in fire base
  addProjectsMember({
    required BuildContext context,
    required String projectName,
    required String descriptionProject,
    required String leaderName,
    required String? projectStatus,
    required String memberProjectName,
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance.collection('project').add({
      'projectName': projectName,
      'descriptionProject': descriptionProject,
      'leaderName': leaderName,
      'projectStatus': projectStatus,
      'memberProjectName': memberProjectName,
      'isFav': false,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    Navigator.pop(context);
    notifyListeners();
  }

// methods to create graduated profile  in fire base
//   createGraduatedProfile({
//     required BuildContext context,
//     required String name,
//     required String faculty,
//     required String phone,
//     required String id,
//     required String department,
//     required String degree,
//     required String link,
//     required var accept,
//     required List<String> fields,
//     required File file,
//   }) async {
//     // if (file == null)
//     //   return AwesomeDialog(
//     //       context: context,
//     //       title: "هام",
//     //       body: Text("please choose Image"),
//     //       dialogType: DialogType.ERROR)
//     //     ..show();
//
//     await ref.putFile(file);
//     var imageUrl = await ref.getDownloadURL();
//     await FirebaseFirestore.instance
//         .collection('member')
//         .doc(FirebaseAuth.instance.currentUser!.uid)
//         .set({
//       'faculty': faculty,
//       'phone': phone,
//       'name': name,
//       'imageUrl': imageUrl,
//       'id': id,
//       'degree': degree,
//       'link': link,
//       'accept': accept,
//       'fields': fields,
//       'userId': FirebaseAuth.instance.currentUser!.uid,
//       'department': department,
//     });
//     showLoading(context);
//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => NavigationFile(
//               d: studentDrawer(context),
//               title: '$name مرحبا  ً',
//               counter: 1,
//             )));
//     notifyListeners();
//   }

  // methods to add theses for member in fire base
  addGraduatedTheses({
    required BuildContext context,
    required String nameTheses,
    required String linkTheses,
    required String assistantSupervisors,
    required String nameSupervisors,
    required String degreeTheses,
    required String? thesesStatus,
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance.collection('theses').add({
      'nameTheses': nameTheses,
      'linkTheses': linkTheses,
      'assistantSupervisors': assistantSupervisors,
      'nameSupervisors': nameSupervisors,
      'degreeTheses': degreeTheses,
      'thesesStatus': thesesStatus,
      'isFav': false,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    Navigator.pop(context);
    notifyListeners();
  }

// methods to add project for member in fire base
  addGraduatedProject({
    required BuildContext context,
    required String projectName,
    required String descriptionProject,
    required String leaderName,
    required String? projectStatus,
    required String memberProjectName,
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance.collection('project').add({
      'projectName': projectName,
      'descriptionProject': descriptionProject,
      'leaderName': leaderName,
      'projectStatus': projectStatus,
      'isFav': false,
      'memberProjectName': memberProjectName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    Navigator.pop(context);
    notifyListeners();
  }

  getData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("member")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    debugPrint('userType is ${documentSnapshot.get('name')}');
    name2 = documentSnapshot.get('name');
    faculty = documentSnapshot.get('faculty');
    email = documentSnapshot.get('email');
    link = documentSnapshot.get('link');
    phone = documentSnapshot.get('phone');
    degree = documentSnapshot.get('degree');
    id = documentSnapshot.get('id');

    notifyListeners();
  }

  addSeminar({
    required BuildContext context,
    required String seminaraddress,
    required String location,
    required String description,
    required String seminarlink,
    required String from,
    required String? to,
    required String? type,
    required String? selectedDay,
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance.collection('seminar').add({
      'seminaraddress': seminaraddress,
      'location': location,
      'description':description,
      'link': seminarlink,
      'selectedDay': selectedDay,
      //'username': auth.userName,
      'from': from,
      'to': to,
      'type': type,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    Navigator.pop(context);
    notifyListeners();
  }
}
