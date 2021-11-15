import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class SeminarBookmark extends StatefulWidget {
  const SeminarBookmark({Key? key}) : super(key: key);

  @override
  _SeminarBookmarkState createState() => _SeminarBookmarkState();
}

class _SeminarBookmarkState extends State<SeminarBookmark> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: sizeFromHeight(context, 2),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('seminarBookmark')
              .snapshots(),
          builder:
              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return  Container(
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
                                      if (snapshot.data!
                                          .docs[index]['isFav'] == true) {
                                        FirebaseFirestore.instance
                                            .collection('seminarBookmark')
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                        await FirebaseFirestore.instance
                                            .collection('seminar')
                                            .doc(snapshot.data!.docs[index].id)
                                            .update(
                                            {'isFav': false });
                                      }
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 20,
                                      margin:
                                      const EdgeInsets.symmetric(
                                          vertical: 10,horizontal: 20),
                                      child:snapshot.data!.docs[index]['isFav'] == true? const ImageIcon(
                                        AssetImage(
                                          'assets/bookmark (2).png',

                                        ),
                                        color: blue,
                                        size: 50,
                                      )
                                          : const ImageIcon(
                                        AssetImage(
                                          'assets/bookmark (1).png',
                                        ),
                                        color: blue,
                                        size: 50,
                                      ),
                                    ),
                                  )
                                ]),
                          ],
                        ),
                      ),
                    );
                  });
            }
            return const Text('');
          },
        ));
  }
}
