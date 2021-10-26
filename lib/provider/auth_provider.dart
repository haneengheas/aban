
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
   var val;
   authProvider() {
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen(( user) {
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

   singup(String email, String password,String name) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential != null) {
        // ignore: unnecessary_null_comparison
        await FirebaseFirestore.instance.collection("user")
            .add({
          "username": name,
          "email": email,
          "userid": FirebaseAuth.instance.currentUser!.uid,
          "var":val,
        });
      }

    } catch (e) {
      print(e);
      print('=========================');
    }
  }
  login (String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _authStatus = AuthStatus.authentecating;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
    }
  }


  logout() async {
    await _auth.signOut();
    _authStatus = AuthStatus.unAuthenticated;
    notifyListeners();
  }
}