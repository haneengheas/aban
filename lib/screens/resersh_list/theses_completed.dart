// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CompeletedThesesresersh extends StatefulWidget {
  final String text;
  final String? userId;

  const CompeletedThesesresersh({required this.text, required this.userId});

  @override
  State<CompeletedThesesresersh> createState() =>
      _CompeletedThesesresershState();
}

class _CompeletedThesesresershState extends State<CompeletedThesesresersh> {
  void getData() async {
    QuerySnapshot<Map<String, dynamic>> documentSnapshot2 =
        await FirebaseFirestore.instance
            .collection("theses")
            .where('userId', isEqualTo: widget.userId)
            .where('thesesStatus', isEqualTo: 'مكتملة')
            .get();
    debugPrint('userType is ${documentSnapshot2.docs[0]['nameTheses']}');
    // name.text = documentSnapshot2.get('name');
    // faculty.text = documentSnapshot2.get('faculty');
    // emailuser.text = FirebaseAuth.instance.currentUser!.email!;
    // link.text = documentSnapshot2.get('link');
    // phone.text = documentSnapshot2.get('phone');
    // degree.text = documentSnapshot2.get('degree');
    // id.text = documentSnapshot2.get('id');
    // image = documentSnapshot2.get('imageUrl');
    // field = documentSnapshot2.get('fields');
    // accept = documentSnapshot2.get('accept');

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
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
                .where('userId', isEqualTo: widget.userId)
                .where('thesesStatus', isEqualTo: "مكتملة")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
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
                          width: sizeFromWidth(context, 1),
                          height: 100,
                          decoration: BoxDecoration(
                            color: clearblue,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              snapshot.data!.docs[index]
                                                  ['degreeTheses'],
                                              style: labelStyle3,
                                            ),
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
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
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
                              )),
                        );
                      }),
                );
              }
              return const Text('');
            },
          )
        ],
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
