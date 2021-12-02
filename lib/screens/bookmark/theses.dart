// ignore_for_file: avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/theses_screen/theses_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ThesesBookMark extends StatefulWidget {
  const ThesesBookMark({Key? key}) : super(key: key);

  @override
  _ThesesBookMarkState createState() => _ThesesBookMarkState();
}

class _ThesesBookMarkState extends State<ThesesBookMark> {
  List<ModelTheses> completedTheses = <ModelTheses>[];
  @override
  void initState() {
    getCompletedTheses();
    super.initState();
  }
  getCompletedTheses() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('theses')
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
    }
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
              itemCount: completedTheses.length,
              itemBuilder: (context, index) {

                return _buildThesesBox( completedTheses[index]);
              }),
        )

      ],
    );
  }
  Widget _buildThesesBox(ModelTheses theses){
    var prov = Provider.of<ProfileProvider>(context);

    return  Container(
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

                    style: labelStyle3,
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
                      DocumentSnapshot docRef = await FirebaseFirestore
                          .instance
                          .collection('theses')
                          .doc(theses.id)
                          .get();

                      Map<String, dynamic> docIsFav =
                      docRef.get("isFav");

                      if (docIsFav.containsKey(
                          FirebaseAuth.instance.currentUser!.uid)) {
                        docIsFav.addAll({
                          FirebaseAuth.instance.currentUser!.uid
                              .toString(): theses.isFav! ? false : true
                        });
                      } else {
                        docIsFav.addAll({
                          FirebaseAuth.instance.currentUser!.uid:
                          theses.isFav! ? false : true
                        });
                      }
                      theses.isFav = !theses.isFav!;

                      if (theses.isFav == false) {
                        docIsFav.remove(FirebaseAuth.instance.currentUser!.uid);
                        await FirebaseFirestore.instance
                            .collection('theses')
                            .doc(theses.id)
                            .update({'isFav': docIsFav});
                      }
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
  }}