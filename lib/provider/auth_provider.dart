// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:aban/screens/registration/wellcome_screen/view.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum AuthStatus { unAuthenticated, authentecating, authenticated }

class AuthProvider with ChangeNotifier {
  late FirebaseAuth _auth;
  late User _user;
  late AuthStatus _authStatus;
  late String errorMessage;
 var usertype;
  var userName;


  authProvider() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        _authStatus = AuthStatus.unAuthenticated;
      } else {
        _user = user;
      }
      notifyListeners();
    });
  }

  AuthStatus get authStatus => _authStatus;

  User get user => _user;

  singup(String email, String password, String name, String userType, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential != null) {
        // ignore: unnecessary_null_comparison
        await FirebaseFirestore.instance
            .collection("user")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "username": name,
          "email": email,
          "userid": FirebaseAuth.instance.currentUser!.uid,
          "userType": userType,
          "var": usertype,
        }).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                   WellcomeScreen(email: email,name: name,)));
        });
      }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
            context: context,
            title: "Error",
            dialogType: DialogType.ERROR,
            body: const Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                    "كلمة المرور ضعيفة يجب ان تتكون علي الاقل من ستة ارقام او حروف")))
            .show();
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
            context: context,
            title: "Error",
            dialogType: DialogType.ERROR,
            body: const Text(
                "البريد الالكتروني موجود بالفعل ، الرجاء ادخال بريد اخر"))
            .show();
      }
      else if (e.code == 'The email address is already in use by another account.') {
        AwesomeDialog(
            context: context,
            title: "Error",
            dialogType: DialogType.ERROR,
            body: const Text(
                "البريد الالكتروني موجود بالفعل ، الرجاء ادخال بريد اخر"))
            .show();
      }
    }  catch (e) {
      print(e);
      debugPrint('=========================');
    }
  }

  login(String email, String password, context) async {
    authProvider();
    try {
        await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _authStatus = AuthStatus.authentecating;

      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("user")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      debugPrint('userType is ${documentSnapshot.get('userType')}');
      debugPrint('userName is ${documentSnapshot.get('username')}');


      usertype = documentSnapshot.get('userType') == 'student' ? 1 : 0;
      userName = documentSnapshot.get('username') ;
      print(usertype);

      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            title: "خطأ",
            body: const Text("لا يوجد حساب لهذا البريد الالكتروني"))
            .show();
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            title: "خطأ",
            body: const Text("كلمة المرور خطأ"))
            .show();
      }
      else if (e.code == 'invalid-email'){
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            title: "خطأ",
            body: const Text("تم ادخال الايميل بشكل خاطيء"))
            .show();
      }
    }
  }
//test
  getUserStatus() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    debugPrint('userType is ${documentSnapshot.get('userType')}');
    debugPrint('userName is ${documentSnapshot.get('username')}');


    usertype = documentSnapshot.get('userType') == 'student' ? 1 : 0;
    userName = documentSnapshot.get('username') ;
    print(usertype);
    notifyListeners();

  }

  logout() async {
    await _auth.signOut();
    _authStatus = AuthStatus.unAuthenticated;
    notifyListeners();
  }

}

