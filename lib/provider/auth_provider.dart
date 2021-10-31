// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

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

  singup(String email, String password, String name, String userType) async {
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
        });
      }
    } catch (e) {
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
    } on FirebaseAuthException  catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Text("No user found for that email"))
            .show();
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
            context: context,
            title: "Error",
            body: const Text("Wrong password provided for that user"))
            .show();
      }
    }
  }

  getUserStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        //get all docs and make for loop in it and get what i need ==> userid == my unique id
        .where('userid', isEqualTo: (FirebaseAuth.instance.currentUser!).uid)
        // get it
        .get()
        .then((value) {
      //this return a list of query snapshot , but it include a one item - because the firebase uid is unique for each user -
      print(value.docs[0]['val']);
    });
  }

  logout() async {
    await _auth.signOut();
    _authStatus = AuthStatus.unAuthenticated;
    notifyListeners();
  }

}

