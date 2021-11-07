import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class ThesesBookMark extends StatefulWidget {
  const ThesesBookMark({Key? key}) : super(key: key);

  @override
  _ThesesBookMarkState createState() => _ThesesBookMarkState();
}

class _ThesesBookMarkState extends State<ThesesBookMark> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: sizeFromHeight(context, 2.2),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('thesesBookmark')
              .snapshots(),
          builder:
              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context,
                  index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 10),
                  padding:  const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 20),
                  width: sizeFromWidth(context, 1),
                  height: 120,
                  decoration: BoxDecoration(
                    color: clearblue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'اسم الاطروحة: ' + snapshot.data!
                                    .docs[index]['nameTheses'],
                                maxLines: 2,
                                style: GoogleFonts.cairo(
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                    color: black,
                                    overflow: TextOverflow.clip,
                                  ),

                                )
                              ),
                              Text(
                                'المشرف: ' + snapshot.data!
                                    .docs[index]['nameSupervisors'],
                                style: hintStyle3,
                              ),
                              Text(
                                'المشرفون المساعدون :' +
                                    snapshot.data!
                                        .docs[index]['assistantSupervisors'],
                                style: hintStyle3,
                              ),
                            ],
                          ),
                        ),

                        const VerticalDivider(
                          color: gray,
                          endIndent: 5,
                          indent: 5,
                          width: 10,
                          thickness: 2,
                        ),
                        Column(
                            // crossAxisAlignment: CrossAxisAlignment
                            //     .center,
                          mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data!
                                    .docs[index]['degreeTheses'],
                                style: labelStyle3,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (snapshot.data!
                                      .docs[index]['isFav'] == true) {
                                    FirebaseFirestore.instance
                                        .collection('thesesBookmark')
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
                                  margin: const EdgeInsets
                                      .symmetric(
                                      vertical: 10,horizontal: 10),
                                  child: snapshot.data!
                                      .docs[index]['isFav'] == true
                                      ? const ImageIcon(
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
        )
    );
  }
}
