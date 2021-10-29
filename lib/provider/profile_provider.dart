// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:aban/constant/loading_methods.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
class ProfileProvider with ChangeNotifier {
  final GlobalKey<FormState> formKeyTheses = GlobalKey<FormState>();
  final GlobalKey<FormState> formKeyProject = GlobalKey<FormState>();
  late String name;
  late String faculty;
  late String phone;
  late File file;
  late Reference ref;
  late String imageurl;
  late String email;
  late String id;
  late String link;
  var accept;
  late String degree;
  var fields = <TextEditingController>[];
  late String nameTheses;
  late String linkTheses;
  late String assistantSupervisors;
  late String nameSupervisors;
  late String degreeTheses;
  String? thesesStatus;
  late String projectName;
  late String descriptionProject;
  late String leaderName;
  String? projectStatus;
// methods to add and create member profile in fire base
  createMemberProfile({
    required BuildContext context,
    required String name,
    required String faculty,
    required String phone,
    required String id,
    required String degree,
    required String link,
    required var accept,
    required File file,
  }) async {
    // if (file == null)
    //   return AwesomeDialog(
    //       context: context,
    //       title: "هام",
    //       body: Text("please choose Image"),
    //       dialogType: DialogType.ERROR)
    //     ..show();

    await ref.putFile(file);
    var imageUrl = await ref.getDownloadURL();
    showLoading(context);
    await FirebaseFirestore.instance
        .collection('member')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'faculty': faculty,
      'phone': phone,
      'name': name,
      'imageUrl': imageUrl,
      'id': id,
      'degree': degree,
      'link': link,
      'accept': accept,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => NavigationFile(
              d: studentDrawer(context),
              title: 'مرحبا"اسم الباحث"',
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
    required String degreeTheses,
    required String? thesesStatus,
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance
        .collection('member')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('theses')
        .add({
      'nameTheses': nameTheses,
      'linkTheses': linkTheses,
      'assistantSupervisors': assistantSupervisors,
      'nameSupervisors': nameSupervisors,
      'degreeTheses': degreeTheses,
      'thesesStatus': thesesStatus,
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
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance
        .collection('member')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('project')
        .add({
      'projectName': projectName,
      'descriptionProject': descriptionProject,
      'leaderName': leaderName,
      'projectStatus': projectStatus,
    });
    Navigator.pop(context);
    notifyListeners();
  }


// methods to create graduated profile  in fire base
  createGraduatedProfile({
    required BuildContext context,
    required String name,
    required String faculty,
    required String phone,
    required String id,
    required String degree,
    required String link,
    required var accept,
    required File file,
  }) async {
    // if (file == null)
    //   return AwesomeDialog(
    //       context: context,
    //       title: "هام",
    //       body: Text("please choose Image"),
    //       dialogType: DialogType.ERROR)
    //     ..show();

    await ref.putFile(file);
    var imageUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('graduated')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        'faculty': faculty,
        'phone': phone,
        'name': name,
        'imageUrl': imageUrl,
        'id': id,
        'degree': degree,
        'link': link,
        'accept': accept,
        'userId': FirebaseAuth.instance.currentUser!.uid,

    });
    notifyListeners();
  }
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
    await FirebaseFirestore.instance
        .collection('graduated')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('theses')
        .add({
      'nameTheses': nameTheses,
      'linkTheses': linkTheses,
      'assistantSupervisors': assistantSupervisors,
      'nameSupervisors': nameSupervisors,
      'degreeTheses': degreeTheses,
      'thesesStatus': thesesStatus,
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
  }) async {
    showLoading(context);
    await FirebaseFirestore.instance
        .collection('graduated')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('project')
        .add({
      'projectName': projectName,
      'descriptionProject': descriptionProject,
      'leaderName': leaderName,
      'projectStatus': projectStatus,
    });
    Navigator.pop(context);
    notifyListeners();
  }

  getData()async{
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("member")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
     debugPrint('userType is ${documentSnapshot.get('name')}');
    name = documentSnapshot.get('name') ;
    faculty =documentSnapshot.get('faculty');
    email =documentSnapshot.get('email');
    link =documentSnapshot.get('link');
    phone =documentSnapshot.get('phone');
    degree =documentSnapshot.get('degree');
    id =documentSnapshot.get('id');


    notifyListeners();
  }

}

