import 'package:aban/constant/style.dart';
import 'package:aban/screens/seminar/seminar_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_seminar.dart';

class LaterSeminar extends StatefulWidget {
  const LaterSeminar({Key? key}) : super(key: key);

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<LaterSeminar> {
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('seminar')
            .where('selectedDay', isGreaterThan: DateTime.now())
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Column(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddSeminar()));
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
                child: ListView.builder(
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

                                )));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                        // snapshot.data!.docs[index]
                                        // ['selectedDay'].toString(),
                                        '9999999',
                                        style: hintStyle3,
                                      ),
                                      const Icon(
                                        Icons.date_range,
                                        color: blue,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    snapshot.data!.docs[index]['username'],
                                    style: hintStyle3,
                                  ),
                                ],
                              ),
                              const VerticalDivider(
                                color: gray,
                                endIndent: 10,
                                indent: 10,
                                width: 5,
                                thickness: 2,
                              ),
                              Padding(

                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['type'] == 1
                                            ? 'عامة'
                                            : 'خاصة',
                                        style: labelStyle3,
                                      ),
                                      // InkWell(
// onTap: () {
// setState(() {
// checked = !checked;
// });
// },
// child: Container(
// height: 40,
// width: 25,
// margin: const EdgeInsets.symmetric(
// vertical: 10),
// child: checked
// ? const ImageIcon(
// AssetImage(
// 'assets/bookmark (1).png',
// ),
// color: blue,
// size: 50,
// )
// : const ImageIcon(
// AssetImage(
// 'assets/bookmark (2).png',
// ),
// color: blue,
// size: 50,
// ),
// ),
// ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
