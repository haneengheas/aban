import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileProvider with ChangeNotifier {
  late String name;
  late String fuclty;
  late String phone;

  // ProfileProvider(this.name, this.fuclty, this.phone);

  addData(String name, String fuclty, String phone) async {
    await FirebaseFirestore.instance.collection('users').add({
      'name': name,
      'fuclty': fuclty,
      'phone': phone,
    });
    notifyListeners();
  }
}
