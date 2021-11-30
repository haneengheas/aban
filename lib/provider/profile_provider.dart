// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:aban/constant/loading_methods.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
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
  String? degreeMember;
  String? degreeGraduated;
  int? counter;

  late String seminaraddress,
      location,
      description,
      seminarlink,
      from,
      dropdownValue = 'pm',
      dropdownValue2 = 'pm',
      to;
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
  late String phoneview;
  late String descriptionProject;
  late String leaderName;
  late String memberProjectName;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? projectDegree;
  String? linkProject;
  String? projectStatus;
  bool isFav = false;
  List? isFavorite = [];
  String? college;
  late String key;

  String? department;
  Map<String, dynamic>? docIsFav={};

// methods to add and create member profile in fire base
  createMemberProfile({
    required String key,
    required BuildContext context,
    required String name,
    required String phoneview ,
    required String department,
    required String faculty,
    required String phone,
    required List<String> fields,
    required String id,
    required String degree,
    required String link,
    required var accept,
    File? file,
    required String email,
  }) async {
    showLoading(context);
    var imageUrl;
    if (file!.path != "") {
      await ref.putFile(file);
      imageUrl = await ref.getDownloadURL();
    }
    await FirebaseFirestore.instance
        .collection('member')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'faculty': faculty,
      'phone': phone,
      'key': key,
      'phoneview': phoneview,
      'name': name,
      'email': email,
      'imageUrl': file.path == "" ? "https://firebasestorage.googleapis.com/v0/b/aban-9b0ba.appspot.com/o/user.png?alt=media&token=9d9b6b7d-f436-4fd3-99a2-e5b8bdf6f8d1" : imageUrl,
      'id': id,
      'fields': fields,
      'degree': degree,
      'link': link,
      'accept': accept,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'department': department,
    });
    showLoading(context);
    counter = 1;
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NavigationFile(
                  d: studentDrawer(context),
                  title: '   مرحبا $name ',
                  counter: counter!,
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
    required String? college,
    required String? department,
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance.collection('theses').add({
      'nameTheses': nameTheses,
      'linkTheses': linkTheses,
      'assistantSupervisors': assistantSupervisors,
      'nameSupervisors': nameSupervisors,
      'degreeTheses': degreeTheses,
      'thesesStatus': thesesStatus,
      'isFav': docIsFav,
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'college': college,
      'department': department,
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
    required String? college,
    required String? department,
    required String? linkProject,
    // required String ? projectDegree,
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance.collection('project').add({
      'projectName': projectName,
      'descriptionProject': descriptionProject,
      'leaderName': leaderName,
      'projectStatus': projectStatus,
      'memberProjectName': memberProjectName,
      'college': college,
      'department': department,
      'projectLink': linkProject,
      // 'projectDegree':projectDegree,
      'isFav': docIsFav,
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
    degreeMember = documentSnapshot.get('degree');
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
    required String? name,
    required String? timedrop,
    required String? timedrop2,
    required int? type,
    required DateTime? selectedDay,
  }) async {
    await FirebaseFirestore.instance.collection('seminar').add({
      'seminarAddress': seminaraddress,
      'location': location,
      'description': description,
      'link': seminarlink,
      'timedrop': timedrop,
      'timedrop2': timedrop2,
      'selectedDay': selectedDay,
      //'username': auth.userName,
      'from': from,
      'to': to,
      'type': type,
      'username': name,
      'isFav': docIsFav,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    }).then((value) async {
      Navigator.pop(context);
      await AwesomeDialog(
              context: context,
              title: "هام",
              body: const Text("تم الاضافة بنجاح"),
              dialogType: DialogType.SUCCES)
          .show();
    });
    showLoading(context);
    Navigator.pop(context);
    notifyListeners();
  }
}
