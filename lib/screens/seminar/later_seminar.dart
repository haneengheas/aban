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
  LaterSeminar(this.filter, this.seminar, {Key? key}) : super(key: key);

  final List<SeminarModel> seminar;
  final String? filter;

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<LaterSeminar> {

  bool isFav = false;


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
                .where('selectedDay', isGreaterThan: DateTime.now())
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return     InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SeminarDetails(
                                        docid:snapshot.data!.docs[index].id ,
                                        description: snapshot.data!.docs[index]
                                        ['description'],
                                        isFav: snapshot.data!.docs[index]
                                        ['isFav'],
                                        from: snapshot.data!.docs[index]
                                        ['from'],
                                        link: snapshot.data!.docs[index]
                                        ['link'],
                                        location: snapshot.data!.docs[index]
                                        ['location'],
                                        selectday: snapshot.data!.docs[index]
                                        ['selectedDay'],
                                        seminarname: snapshot.data!.docs[index]
                                        ['seminarAddress'],
                                        to: snapshot.data!.docs[index]
                                        ['to'],
                                        type: snapshot.data!.docs[index]
                                        ['type'],
                                        userid: snapshot.data!.docs[index]
                                        ['userId'],
                                        username: snapshot.data!.docs[index]
                                        ['username'],
                                      )));
                        },
                        child: Container(
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
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: [
                                      Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]
                                            ['seminarAddress'],
                                            style: labelStyle3,
                                          ),

                                          Row(
                                            children: [
                                              Text(
                                                // snapshot.data!.docs[index]
                                                // ['selectedDay'].toString(),
                                                '29/5/2021',
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
                                        snapshot.data!.docs[index]['username'],
                                        style: hintStyle3,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            snapshot.data!.docs[index]['to'] +
                                                'pm',
                                            style: hintStyle3,
                                          ),
                                          Text(
                                            ':' +
                                                snapshot.data!
                                                    .docs[index]['from']
                                                    .toString() +
                                                'pm',
                                            style: hintStyle3,
                                          ),
                                        ],
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
                                  width: 10,
                                  thickness: 2,
                                ),
                                Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        snapshot.data!.docs[index]['type'] == 1
                                            ? 'عامة'
                                            : 'خاصة',
                                        style: labelStyle3,
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await FirebaseFirestore.instance
                                              .collection('seminarBookmark')
                                              .doc(
                                              snapshot.data!.docs[index].id)
                                              .set({
                                            'description': snapshot.data!
                                                .docs[index]['description'],
                                            'from': snapshot.data!
                                                .docs[index]['from'],
                                            'to': snapshot.data!
                                                .docs[index][ 'to'],
                                            'link': snapshot.data!
                                                .docs[index]['link'],
                                            'location': snapshot.data!
                                                .docs[index]['location'],
                                            'selectedDay': snapshot.data!
                                                .docs[index]['selectedDay'],
                                            'userId': FirebaseAuth.instance
                                                .currentUser!.uid,
                                            'type': snapshot.data!
                                                .docs[index]['type'],
                                            'seminarAddress': snapshot.data!
                                                .docs[index][ 'seminarAddress'],
                                            'username': snapshot.data!
                                                .docs[index]['username'],
                                            'isFav': isFav ? false : true
                                          });

                                          isFav = !isFav;
                                          await FirebaseFirestore.instance
                                              .collection('seminar')
                                              .doc(
                                              snapshot.data!.docs[index].id)
                                              .update(
                                              {'isFav': isFav});
                                          if (isFav == false) {
                                            FirebaseFirestore.instance
                                                .collection('seminarBookmark')
                                                .doc(
                                                snapshot.data!.docs[index].id)
                                                .delete();
                                          }
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 25,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: !isFav
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
                    });
              }
              return const Text('');
            },
          ),
        ),
      ],
    );
  }
}
