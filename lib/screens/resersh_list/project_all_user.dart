// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompletedProjectResersh extends StatefulWidget {
  final String text;

  const CompletedProjectResersh({required this.text});

  @override
  State<CompletedProjectResersh> createState() => _CompletedProjectResershState();
}

class _CompletedProjectResershState extends State<CompletedProjectResersh> {
  bool checked = true;

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
                .collection('project')

                .where('projectStatus', isEqualTo: 'مكتملة')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height / 3,
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${snapshot.data!
                                          .docs[index]['projectName']}',
                                      style: labelStyle3,
                                    ),
                                    Text(
                                      'القائد :' +
                                          snapshot.data!.docs[index]
                                          ["leaderName"],
                                      style: hintStyle3,
                                    ),
                                    Text(
                                      'الاعضاء :' +
                                          snapshot.data!.docs[index]
                                          ["memberProjectName"],
                                      style: hintStyle3,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 50,
                                ),
                                const VerticalDivider(
                                  color: gray,
                                  endIndent: 10,
                                  indent: 10,
                                  width: 10,
                                  thickness: 2,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      print('1');
                                      completed[index][2] =
                                      !completed[index][2];
                                    });
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 25,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: completed[index][2]
                                          ? ImageIcon(
                                        AssetImage(
                                          'assets/${completed[index][1]}',
                                        ),
                                        color: blue,
                                      )
                                          : ImageIcon(
                                        AssetImage(
                                          'assets/${completed[index][3]}',
                                        ),
                                        color: blue,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
              return const Text('');
            })
      ],
    );
  }
}

List<List> completed = [
  ['دكتوراه', 'bookmark (1).png', true, 'bookmark (2).png'],
  ['ماجستير', 'bookmark (1).png', false, 'bookmark (2).png'],
  ['دكتوراه', 'bookmark (1).png', true, 'bookmark (2).png'],
  ['ماجستير', 'bookmark (1).png', true, 'bookmark (2).png'],
];
