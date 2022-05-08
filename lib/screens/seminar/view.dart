// ignore_for_file: avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/guestdawer.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/seminar/complete_seminar.dart';
import 'package:aban/screens/seminar/later_seminar.dart';
import 'package:aban/screens/seminar/seminar_model.dart';
import 'package:aban/widgets/search_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SeminarScreen extends StatefulWidget {
  const SeminarScreen({Key? key, }) : super(key: key);

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<SeminarScreen> {
  List<SeminarModel> unCompletedSeminar = <SeminarModel>[];
  List<SeminarModel> completedSeminar = <SeminarModel>[];
  TextEditingController searchController = TextEditingController();
  String filter = '';

  @override
  void initState() {
    getCompletedSeminar();
    getUnCompletedSeminar();

    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });

    super.initState();
  }

  getCompletedSeminar() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('seminar')
        .where('selectedDay', isLessThanOrEqualTo: DateTime.now())
        .get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> docIsFav = doc['isFav'];
      bool isFav = false;
      if (docIsFav.containsKey(
          FirebaseAuth.instance.currentUser!.uid.toString())) {
        isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
      } else {
        isFav = false;
      }
      print(isFav);
      print("=============================");

      completedSeminar.add(SeminarModel(

          type: doc['type'],
          discription: doc['description'],
          from: doc['from'],
          link: doc['link'],
          location: doc['location'],
          selectday: doc['selectedDay'],
          seminartitle: doc['seminarAddress'],
          to: doc['to'],
          userid:  doc['userId'],
          dropdown: doc['timedrop'],
          dropdown2: doc['timedrop2'],
          docId: doc.id,
          isFav: isFav,
          username: doc['username']
      )
      );
    }

    setState(() {});
  }

  getUnCompletedSeminar() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('seminar')
        .where('selectedDay', isGreaterThan: DateTime.now())
        .get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> docIsFav = doc['isFav'];
      bool isFav = false;
      if (docIsFav.containsKey(
          FirebaseAuth.instance.currentUser!.uid.toString())) {
        isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
      } else {
        isFav = false;
      }
      print(isFav);
      print("=============================");
      unCompletedSeminar.add(SeminarModel(
          type: doc['type'],
          discription: doc['description'],
          from: doc['from'],
          link: doc['link'],
          dropdown: doc['timedrop'],
          dropdown2: doc['timedrop2'],
          location: doc['location'],
           selectday: doc['selectedDay'],
          seminartitle: doc['seminarAddress'],
          to: doc['to'],
          userid:  doc['userId'],
          docId: doc.id,
          isFav: isFav,
          username: doc['username']));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Text('ندوة',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                    color: blue, fontWeight: FontWeight.bold, fontSize: 28),
              )),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (prov.counter == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationFile(
                            d: studentDrawer(context),
                            // title: ' مرحبا${provider.userName} ',
                            counter: prov.counter!)));
              } else if (prov.counter == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationFile(
                            d: guestDrawer(context),
                            // title: 'مرحبا',
                            counter: prov.counter!)));
              }
            },
            icon: const Icon(Icons.arrow_back),
            color: blue,
          ),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchTextField(
                text: "البحث عن ندوة",
                controller: searchController,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.4,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  border: Border.fromBorderSide(
                      BorderSide(color: lightBlue, width: 1.5)),
                ),
                child: Column(children: [
                  SizedBox(
                    height: 60,
                    child: (TabBar(
                      labelColor: blue,
                      unselectedLabelColor: gray,
                      labelStyle: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                            fontSize: 22,
                            height: 1.5,
                            fontWeight: FontWeight.w800),
                      ),
                      isScrollable: false,
                      unselectedLabelStyle: labelStyle,
                      indicatorWeight: 0.1,
                      tabs: const <Widget>[
                        Tab(
                          text: "قادمة",
                        ),
                        Tab(
                          text: " مكتملة",
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TabBarView(
                        children: [
                          LaterSeminar(filter, unCompletedSeminar),
                          CompleteSeminar(filter, completedSeminar)
                        ],
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
