import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'college_views.dart';

class HomeScreen extends StatefulWidget {
  final  Widget c;
  final  String title;
  const HomeScreen({Key? key,
    required this.c,
    required this.title,
  }) : super(key: key) ;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var token;
  getToken(){
     FirebaseMessaging.instance.getToken().then((value) async{
       await FirebaseFirestore.instance.collection('user').doc(FirebaseAuth.instance.currentUser!.uid).update(
           {
             'token': value,
           });
       await FirebaseFirestore.instance.collection('member').doc(FirebaseAuth.instance.currentUser!.uid).update(
           {
             'token': value,
           });
       print(value);
    } );
  }
  @override
  void initState() {
    getToken();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: blue,
        title: Text(
          widget.title,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.cairo(
            textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                height: 1,
                color: white),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          widget.c,
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            color: blue,
            alignment: Alignment.topCenter,
            height: MediaQuery.of(context).size.height,
            width: sizeFromWidth(context, 1),

          ),
          Container(
              width: sizeFromWidth(context, 1),
              height: MediaQuery.of(context).size.height / 1.17,
              decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20))),
              child: const CollegeView()),
          // Expanded(child: NavigationFile()),
        ],
      ),
    );
  }
}
