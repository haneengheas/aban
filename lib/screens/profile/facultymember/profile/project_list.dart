// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedProject extends StatefulWidget {
  final String text;

  const CompletedProject({required this.text});

  @override
  State<CompletedProject> createState() => _CompletedProjectState();
}

class _CompletedProjectState extends State<CompletedProject> {
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
                .where('userId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .where('projectStatus', isEqualTo: 'مكتملة')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
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
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'اسم المشروع:'+
                                        '${snapshot.data!.docs[index]['projectName']}',
                                        style: GoogleFonts.cairo(
                                          textStyle: const TextStyle(
                                              overflow: TextOverflow.clip,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                              height: 1,
                                              color: black),
                                        ),
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
                                ),
                                // const SizedBox(
                                //   width: 50,
                                // ),
                                const VerticalDivider(
                                  color: gray,
                                  endIndent: 10,
                                  indent: 10,
                                  width: 20,
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
                                          vertical: 10,horizontal: 10),
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
