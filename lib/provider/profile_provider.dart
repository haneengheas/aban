import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
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
  late String thesesStatus;






  // late String imageurl;
  addData({
    required String name,
    required String faculty,
    required String phone,
    // required String imageUrl,
    required String id,
    required String degree,
    required String link,
    required var accept,
    // required var fields,
    // required File file,
    // required Reference ref,
  }) async {
    // await ref.putFile(file);
    // imageUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('member').add({
      'name': name,
      'faculty': faculty,
      'phone': phone,
      // 'imageUrl': imageUrl,
      'id': id,
      'degree': degree,
      'link': link,
      'accept':accept,
      // 'field':fields,
      // 'userId':FirebaseAuth.instance.currentUser!.uid,
    });
    notifyListeners();
  }
}
