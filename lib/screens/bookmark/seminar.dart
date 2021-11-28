// ignore_for_file: avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/screens/seminar/seminar_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SeminarBookmark extends StatefulWidget {
  const SeminarBookmark({Key? key}) : super(key: key);

  @override
  _SeminarBookmarkState createState() => _SeminarBookmarkState();
}

class _SeminarBookmarkState extends State<SeminarBookmark> {
  List<SeminarModel> unCompletedSeminar = <SeminarModel>[];
  List<SeminarModel> completedSeminar = <SeminarModel>[];
  TextEditingController searchController = TextEditingController();
  String filter = '';
  int? indexed;

  @override
  void initState() {
    getCompletedSeminar();

    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });

    super.initState();
  }

  getCompletedSeminar() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('seminar')
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
      if (docIsFav
          .containsKey(FirebaseAuth.instance.currentUser!.uid.toString()) && isFav == true) {
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
    }}

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(
          height: sizeFromHeight(context, 2),
          child: ListView.builder(
              itemCount: completedSeminar.length,
              itemBuilder: (context, index) {
                return _buildProjectBox( completedSeminar[index]);
              }),
        )
      ],
    );
  }
  Widget _buildProjectBox(SeminarModel seminar){
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      width: sizeFromWidth(context, 1),
      height: 125,
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
                mainAxisAlignment:
                MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        seminar.seminartitle!,
                        style: labelStyle3,
                      ),
                      Row(
                        children: [
                          Text(
                            // snapshot.data!.docs[index]
                            // ['selectedDay'].toString(),
                            '${seminar.selectday!.toDate().year }-${seminar.selectday!.toDate().month }-${seminar.selectday!.toDate().day}',
                            style: hintStyle3,
                          ),
                          const Icon(
                            Icons.date_range,
                            color: blue,
                            size: 20,
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    seminar.username!,
                    style: hintStyle3,
                  ),
                  Row(
                    children: [
                      Text(
                        seminar.to!.toString() +
                            seminar.dropdown2!,
                        style: hintStyle3,
                      ),
                      Text(
                        ':' +
                            seminar.from.toString()
                                .toString() +
                            seminar.dropdown!,
                        style: hintStyle3,
                      ),
                    ],
                  ),
                  Text(
                    seminar.location!,
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
                crossAxisAlignment:
                CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    seminar.type == 1
                        ? 'عامة'
                        : 'خاصة',
                    style: labelStyle3,
                  ),
                  InkWell(
                    onTap: () async {
                      DocumentSnapshot docRef = await FirebaseFirestore
                          .instance
                          .collection('seminar')
                          .doc(seminar.docId)
                          .get();

                      Map<String, dynamic> docIsFav =
                      docRef.get("isFav");

                      if (docIsFav.containsKey(
                          FirebaseAuth.instance.currentUser!.uid)) {
                        docIsFav.addAll({
                          FirebaseAuth.instance.currentUser!.uid
                              .toString(): seminar.isFav! ? false : true
                        });
                      } else {
                        docIsFav.addAll({
                          FirebaseAuth.instance.currentUser!.uid:
                          seminar.isFav! ? false : true
                        });
                      }
                      // FirebaseFirestore.instance
                      //     .collection('seminarBookmark')
                      //     .doc(seminar.docId)
                      //     .set({
                      //   'description': seminar.discription,
                      //   'from': seminar.from,
                      //   'to': seminar.to,
                      //   'link': seminar.link,
                      //   'location': seminar.location,
                      //   'selectedDay': seminar.selectday,
                      //   'userId': FirebaseAuth.instance.currentUser!.uid,
                      //   'type': seminar.type,
                      //   'seminarAddress': seminar.seminartitle,
                      //   'username': seminar.username,
                      //   'isFav': seminar.isFav! ? false : true
                      //
                      // });

                      seminar.isFav = !seminar.isFav!;
                      await FirebaseFirestore.instance
                          .collection('seminar')
                          .doc(seminar.docId)
                          .update(
                          {'isFav': docIsFav });
                      // if (seminar.isFav== false) {
                      //   FirebaseFirestore.instance
                      //       .collection('seminarBookmark')
                      //       .doc(seminar.docId)
                      //       .delete();
                      // }
                      setState(() {
                      });

                    },
                    child: Container(
                      height: 40,
                      width: 25,
                      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: !seminar.isFav!
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
                  ),                ]),
          ],
        ),
      ),
    );
  }

}
