import 'package:aban/constant/style.dart';
import 'package:aban/screens/seminar/seminar_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_seminar.dart';

class CompleteSeminar extends StatefulWidget {
  const CompleteSeminar({Key? key}) : super(key: key);

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<CompleteSeminar> {
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddSeminar()));
          },
          child: Row(
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
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('seminar')
                  .where('selectedDay', isLessThanOrEqualTo: DateTime.now())
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>  SeminarDetails(
                                  description: snapshot.data!.docs[index]['description'],
                                  seminarname:  snapshot.data!.docs[index]['username'],
                                  location:  snapshot.data!.docs[index]['location'],
                                  type:  snapshot.data!.docs[index]['type'],
                                  username:  snapshot.data!.docs[index]['username'],

                                ))
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        width: sizeFromWidth(context, 1),
                        height: 120,
                        decoration: BoxDecoration(
                          color: clearblue,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data!.docs[index]
                                              ['seminaraddress'],
                                          style: labelStyle2,
                                        ),
                                        SizedBox(
                                          width: sizeFromWidth(context, 5),
                                        ),
                                        Text(
                                          '24 ابريل2021',
                                          style: hintStyle3,
                                        ),
                                        const Icon(
                                          Icons.date_range,
                                          color: blue,
                                          size: 20,
                                        )
                                      ],
                                    ),
                                    Text(
                                      '8:00-8:30pm',
                                      style: hintStyle3,
                                    ),
                                    Text(
                                     snapshot.data!.docs[index]['username'],
                                      style: hintStyle3,
                                    ),
                                    Text(
                                      snapshot.data!.docs[index]['location'],
                                      style: hintStyle3,
                                    ),
                                  ],
                                ),
                              ),
                              const VerticalDivider(
                                color: gray,
                                endIndent: 10,
                                indent: 10,
                                width: 5,
                                thickness: 2,
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'عامة',
                                      style: labelStyle3,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          print(snapshot.data!.docs.length);
                                          print(
                                              '=/=/=/=/=/=/=/=/=//=/=/=/=/=/=/=/=/');
                                          checked = !checked;
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: checked
                                            ? const ImageIcon(
                                                AssetImage(
                                                  'assets/bookmark (1).png',
                                                ),
                                                color: blue,
                                              )
                                            : const ImageIcon(
                                                AssetImage(
                                                  'assets/bookmark (2).png',
                                                ),
                                                color: blue,
                                              ),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}
