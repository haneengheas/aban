// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UnComletedThesesList extends StatefulWidget {
  final String text;

  const UnComletedThesesList({required this.text});

  @override
  State<UnComletedThesesList> createState() => _UnComletedThesesListState();
}

class _UnComletedThesesListState extends State<UnComletedThesesList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            widget.text,
            style: hintStyle,
          ),
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("theses")
              .where('userId',
                  isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('thesesStatus', isEqualTo: "غير مكتملة")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if(snapshot.hasError){
              return Text("${snapshot.error}");
            }
            if (snapshot.hasData) {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
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
                                      "اسم الاطروحة: " +
                                      '${snapshot.data!.docs[index]['nameTheses']}',
                                      style: labelStyle3,
                                    ),
                                    Text(
                                      'المشرف:' +
                                          snapshot.data!.docs[index]
                                              ["nameSupervisors"],
                                      style: hintStyle3,
                                    ),
                                    Text(
                                      'المشرفون المساعدون:' +
                                          snapshot.data!.docs[index]
                                              ["assistantSupervisors"],
                                      style: hintStyle3,
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                color: gray,
                                endIndent: 5,
                                indent:5,
                                width: 10,
                                thickness: 2,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(

                                      snapshot.data!.docs[index]
                                          ['degreeTheses'],
                                      style: labelStyle3,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          print('1');
                                          completed[index][3] =
                                              !completed[index][3];
                                        });
                                      },
                                      child: Container(
                                          height: 40,
                                          width: 25,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: completed[index][3]
                                              ? ImageIcon(
                                                  AssetImage(
                                                    'assets/${completed[index][1]}',
                                                  ),
                                                  color: blue,
                                                )
                                              : ImageIcon(
                                                  AssetImage(
                                                    'assets/${completed[index][2]}',
                                                  ),
                                                  color: blue,
                                                )),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            }
            return const Text('');
          },
        )
      ],
    );
  }
}

List<List> completed = [
  ['دكتوراه', 'bookmark (1).png', 'bookmark (2).png', true],
  ['ماجستير', 'bookmark (1).png', 'bookmark (2).png', true],
  ['دكتوراه', 'bookmark (1).png', 'bookmark (2).png', true],
  ['ماجستير', 'bookmark (1).png', 'bookmark (2).png', true],
];
