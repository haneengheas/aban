// ignore_for_file: avoid_print, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'college_views.dart';

class HomeScreen extends StatefulWidget {
  final Widget c;
  String? title;

  HomeScreen({
    Key? key,
    required this.c,
    this.title,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  getToken() {
    FirebaseMessaging.instance.getToken().then((value) async {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'token': value,
      });
      await FirebaseFirestore.instance
          .collection('member')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'token': value,
      });
      // DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
      //     .collection("member")
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
      //     .get();
      //
      // debugPrint('userType is ${documentSnapshot.get('userType')}');
      // debugPrint('userName is ${documentSnapshot.get('name')}');
      //
      //
      //
      // provider.nameUser = documentSnapshot.get('name') ;
      // print(provider.nameUser);
      // print(value);
    });
  }

  @override
  void initState() {
    getToken();
    var prov;
    Future.delayed(Duration.zero, () async {
      prov = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("member")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      debugPrint('userName is ${documentSnapshot.get('name')}');
      prov.nameUser = documentSnapshot.get('name');
      print(prov.nameUser);
      print('prov.nameUser');
      setState(() {});
    });

    FirebaseMessaging.onMessage.listen((event) {
      print(event.notification!.body);
      print('+++++++++++++++++++++++++++');
      AwesomeDialog(
          context: context,
          title: 'title',
          body: Text('${event.notification!.body}'));
    });
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: blue,
        title: Text(
          provider.counter == 2 ? 'مرحبا' : '  مرحبا ${provider.nameUser!}',
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
