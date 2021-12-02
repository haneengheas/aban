// ignore_for_file: avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/seminar/seminar_details.dart';
import 'package:aban/screens/seminar/seminar_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'add_seminar.dart';

class LaterSeminar extends StatefulWidget {
  const LaterSeminar(this.filter, this.seminar, {Key? key}) : super(key: key);

  final List<SeminarModel> seminar;
  final String? filter;

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<LaterSeminar> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddSeminar()));
          },
          child: prov.counter == 2
              ? const SizedBox()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'أضف ندوة  ',
                      style: hintStyle2,
                    ),
                    const Icon(
                      Icons.add_circle_outline,
                      color: blue,
                      size: 20,
                    ),
                  ],
                ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.seminar.length,
            itemBuilder: (context, index) {
              print(widget.seminar.length);
              return widget.filter == null || widget.filter == ""
                  ? buildSeminarBox(
                      widget.seminar[index],
                    )
                  : widget.seminar[index].seminartitle!
                              .toLowerCase()
                              .contains(widget.filter!.toLowerCase()) ||
                          widget.seminar[index].username!
                              .toLowerCase()
                              .contains(widget.filter!.toLowerCase())
                      ? buildSeminarBox(
                          widget.seminar[index],
                        )
                      : Container();
            },
          ),
        ),
      ],
    );
  }

  Widget buildSeminarBox(SeminarModel seminar) {
    var prov = Provider.of<ProfileProvider>(context);
    return prov.counter == 2 && seminar.type == 2
        ? const SizedBox()
        : InkWell(
            onTap: () {
              print("=/=/=/=/=/=/=//=/=//==/=/=/=/");
              print(seminar.selectday);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SeminarDetails(
                            docid: seminar.docId,
                            description: seminar.discription,
                            isFav: seminar.isFav,
                            from: seminar.from,
                            link: seminar.link,
                            dropdown: seminar.dropdown,
                            dropdown2: seminar.dropdown2,
                            location: seminar.location,
                            selectday: seminar.selectday,
                            seminarname: seminar.seminartitle,
                            to: seminar.to,
                            type: seminar.type,
                            userid: seminar.userid,
                            username: seminar.username,
                          )));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  seminar.seminartitle!,
                                  maxLines: 1,
                                  style: labelStyle3,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${seminar.selectday!.toDate().year}-${seminar.selectday!.toDate().month}-${seminar.selectday!.toDate().day}',
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
                                seminar.to.toString() + seminar.dropdown2!,
                                style: hintStyle3,
                              ),
                              Text(
                                ':' +
                                    seminar.from.toString() +
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            seminar.type == 1 ? 'عامة' : 'خاصة',
                            style: labelStyle3,
                          ),
                          prov.counter == 2
                              ? const SizedBox()
                              : InkWell(
                                  onTap: () async {
                                    DocumentSnapshot docRef =
                                        await FirebaseFirestore.instance
                                            .collection('seminar')
                                            .doc(seminar.docId)
                                            .get();

                                    Map<String, dynamic> docIsFav =
                                        docRef.get("isFav");

                                    if (docIsFav.containsKey(FirebaseAuth
                                        .instance.currentUser!.uid)) {
                                      docIsFav.addAll({
                                        FirebaseAuth.instance.currentUser!.uid
                                                .toString():
                                            seminar.isFav! ? false : true
                                      });
                                    } else {
                                      docIsFav.addAll({
                                        FirebaseAuth.instance.currentUser!.uid:
                                            seminar.isFav! ? false : true
                                      });
                                    }
                                    // await FirebaseFirestore.instance
                                    //     .collection('seminarBookmark')
                                    //     .doc(
                                    //     seminar.docId)
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
                                    //   'isFav': docIsFav
                                    // });

                                    seminar.isFav = !seminar.isFav!;
                                    setState(() {});
                                    await FirebaseFirestore.instance
                                        .collection('seminar')
                                        .doc(seminar.docId)
                                        .update({'isFav': docIsFav});

                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 25,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
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
                                ),
                        ]),
                  ],
                ),
              ),
            ),
          );
  }
}
