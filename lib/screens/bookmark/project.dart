import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class ProjectBookMark extends StatefulWidget {
  const ProjectBookMark({Key? key}) : super(key: key);

  @override
  _ProjectBookMarkState createState() => _ProjectBookMarkState();
}

class _ProjectBookMarkState extends State<ProjectBookMark> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: sizeFromHeight(context, 2),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('projectBookmark')
              .snapshots(),
          builder:
              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      padding:  const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      width: sizeFromWidth(context, 1),
                      height: 120,
                      decoration: BoxDecoration(
                        color: clearblue,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'اسم المشروع:'+snapshot.data!.docs[index]['projectName'],
                                    style: labelStyle2,
                                  ),
                                  Text(
                                    'القائد:'+snapshot.data!.docs[index]['leaderName'],
                                    style: hintStyle3,
                                  ),
                                  Text(
                                    'الاعضاء:'+snapshot.data!.docs[index]['memberProjectName'],
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
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (snapshot.data!
                                          .docs[index]['isFav'] == true) {
                                        FirebaseFirestore.instance
                                            .collection('projectBookmark')
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                        await FirebaseFirestore.instance
                                            .collection('theses')
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
                                          vertical: 30,horizontal: 10),
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
