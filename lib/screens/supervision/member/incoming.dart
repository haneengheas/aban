// ignore_for_file: avoid_print

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class IncomingSuperMember extends StatefulWidget {
  const IncomingSuperMember({Key? key}) : super(key: key);

  @override
  _IncomingSuperMemberState createState() => _IncomingSuperMemberState();
}

class _IncomingSuperMemberState extends State<IncomingSuperMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('super')
              .where('receiveId',
              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    String status =  snapshot.data!.docs[index]['status'];
                    print(status);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      textDirection: TextDirection.rtl,
                      children: [
                        InkWell(
                          onTap: () async {
                            print(snapshot.data!.docs[index]['Cv']);
                            await launch(
                                'https://'+snapshot.data!.docs[index]['Cv']);
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            width: sizeFromWidth(context, 1.5),
                            height: 120,
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
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'اسم الاطروحة: ' +
                                              snapshot.data!.docs[index]['name'],
                                          style: labelStyle3,
                                        ),
                                        Text(
                                          'تفاصيل الاطروحة:' +
                                              snapshot.data!.docs[index]
                                              ['description'],
                                          style: hintStyle3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        snapshot.data!.docs[index]
                        ['status']=='قيد المعالجة'? Row(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              margin:const EdgeInsets.symmetric(horizontal: 5),
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () async {
                                        showDialogWarning(context,
                                            text:
                                            'هل تقبل الاشراف علي هذه علي الاطروحة',
                                            ontap: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('super')
                                                  .doc(
                                                  snapshot.data!.docs[index].id)
                                                  .update({'status': 'مقبول'});
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.check,
                                        size: 18,
                                        color: white,
                                      ))),
                            ),
                            Container(
                              width: 40,
                              height: 40,
                              margin:const EdgeInsets.symmetric(horizontal: 5),

                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: Colors.red, shape: BoxShape.circle),
                              child: Center(
                                  child: IconButton(
                                      onPressed: () async {
                                        showDialogWarning(context,
                                            text:
                                            'هل ترفض الاشراف علي هذه علي الاطروحة',
                                            ontap: () async {
                                              await FirebaseFirestore.instance
                                                  .collection('super')
                                                  .doc(
                                                  snapshot.data!.docs[index].id)
                                                  .update({'status': 'مرفوض'});
                                              Navigator.pop(context);
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 18,
                                        color: white,
                                      ))),
                            )
                          ],
                        ):Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: status == 'مقبول'?Colors.green:Colors.red, ),
                          child: Center(
                              child: Text(snapshot.data!.docs[index]['status'],style: submitButtonStyle2,)),
                        )

                      ],
                    );
                  });
            }
            return const Text('');
          }),
    );
  }
}
