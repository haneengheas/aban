
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

  Future singup(String email, String password,String name) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
          email: email, password: password);

      if (userCredential != null) {
        // ignore: unnecessary_null_comparison
        await FirebaseFirestore.instance.collection("user")
            .add({
          "username": name,
          "email": email,
          "userid": FirebaseAuth.instance.currentUser!.uid,
        });
      }

    } catch (e) {
      print(e);
      print('=========================');
    }
  }
  Future login (String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _authStatus = AuthStatus.authentecating;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        errorMessage = "Your email is invalid";
        print('Invalid email');
      }
      if (e.code == 'user-not-found') {
        errorMessage = "User not found";
        print('Hi, User not found');
      } else if (e.code == 'wrong-password') {
        errorMessage = "Your password is not correct";
      }
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