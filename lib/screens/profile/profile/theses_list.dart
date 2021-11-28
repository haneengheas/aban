// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:aban/screens/theses_screen/theses_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CompeletedTheses extends StatefulWidget {
  const CompeletedTheses();

  @override
  State<CompeletedTheses> createState() => _CompeletedThesesState();
}

class _CompeletedThesesState extends State<CompeletedTheses> {
  List<ModelTheses> unCompletedTheses = <ModelTheses>[];
  List<ModelTheses> completedTheses = <ModelTheses>[];
  TextEditingController searchController = TextEditingController();
  String filter = '';

  @override
  void initState() {
    getCompletedTheses();
    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });

    super.initState();
  }

  getCompletedTheses() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('theses')
        .where('thesesStatus', isEqualTo: 'مكتملة')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> docIsFav = doc['isFav'];
      bool isFav = false;
      if (docIsFav
          .containsKey(FirebaseAuth.instance.currentUser!.uid.toString())) {
        isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
      } else {
        isFav = false;
      }
      print(isFav);
      print("=============================");

      completedTheses.add(ModelTheses(
          nameTheses: doc['nameTheses'],
          assistantSupervisors: doc['assistantSupervisors'],
          degreeTheses: doc['degreeTheses'],
          nameSupervisors: doc['nameSupervisors'],
          linkTheses: doc['linkTheses'],
          thesesStatus: doc['thesesStatus'],
          isFav: isFav,
          department: doc['department'],
          college: doc['college'],
          userId: doc['userId'],
          id: doc.id));
    }
    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: SizedBox(
          child: ListView.builder(
              itemCount: completedTheses.length,
              itemBuilder: (context, index) {
                return _buildthesesbox(completedTheses[index]);
              }),
        ),
      )
    ]);
  }

  Widget _buildthesesbox(ModelTheses theses) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: sizeFromWidth(context, 1),
      height: 100,
      decoration: BoxDecoration(
        color: clearblue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "اسم الاطروحة: " + theses.nameTheses!,
                    maxLines: 2,
                    style: GoogleFonts.cairo(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1,
                        color: black,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ),
                  Text(
                    'المشرف:' + theses.nameSupervisors!,
                    style: hintStyle3,
                  ),
                  Text(
                    'المشرفون المساعدون:' + theses.assistantSupervisors!,
                    style: hintStyle3,
                  ),
                ],
              ),
            ),
            const VerticalDivider(
              color: gray,
              endIndent: 10,
              indent: 10,
              width: 10,
              thickness: 2,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    theses.degreeTheses!,
                    style: hintStyle4,
                  ),
                  InkWell(
                    onTap: () async {
                      DocumentSnapshot docRef = await FirebaseFirestore.instance
                          .collection('theses')
                          .doc(theses.id)
                          .get();

                      Map<String, dynamic> docIsFav = docRef.get("isFav");

                      if (docIsFav.containsKey(
                          FirebaseAuth.instance.currentUser!.uid)) {
                        docIsFav.addAll({
                          FirebaseAuth.instance.currentUser!.uid.toString():
                              theses.isFav! ? false : true
                        });
                      } else {
                        docIsFav.addAll({
                          FirebaseAuth.instance.currentUser!.uid:
                              theses.isFav! ? false : true
                        });
                      }
                      theses.isFav = !theses.isFav!;
                      await FirebaseFirestore.instance
                          .collection('theses')
                          .doc(theses.id)
                          .update({'isFav': docIsFav});
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: 25,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: !theses.isFav!
                          ? const ImageIcon(
                              AssetImage(
                                'assets/bookmark (1).png',
                              ),
                              color: blue,
                              size: 50,
                            )
                          : const ImageIcon(
                              AssetImage(
                                'assets/bookmark (2).png',
                              ),
                              color: blue,
                              size: 50,
                            ),
                    ),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}

List<List> completed = [
  ['دكتوراه', 'bookmark (1).png', 'bookmark (2).png', true],
  ['ماجستير', 'bookmark (1).png', 'bookmark (2).png', true],
  ['دكتوراه', 'bookmark (1).png', 'bookmark (2).png', true],
  ['ماجستير', 'bookmark (1).png', 'bookmark (2).png', true],
];
