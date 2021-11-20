import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ThesesList extends StatefulWidget {
  String ?college ;
  String ?department;
   ThesesList({
    this.department,
    this.college,
    Key? key}) : super(key: key);

  @override
  _ThesesListState createState() => _ThesesListState();
}

class _ThesesListState extends State<ThesesList> {
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "اطروحات تحت اشرافك :",
            style: labelStyle3,
          ),
        ),
        Row(
          children: [
            SizedBox(
              height: 100,
              width: sizeFromWidth(context, 1),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('theses')
                      .where('userId',
                      isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('');
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  width: sizeFromWidth(context, 1.5),
                                  padding:  const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: clearblue,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                  'اسم الاطروحة : ${snapshot.data!.docs[index]['nameTheses']}',
                                                  style: hintStyle5
                                              ),
                                              Text(
                                                'المشرف: ${snapshot.data!.docs[index]['nameSupervisors']}',
                                                style: hintStyle5,
                                              ),
                                              Text(
                                                ' المشرفون المساعدون: ${snapshot.data!.docs[index]['assistantSupervisors']}',
                                                style: hintStyle5,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const VerticalDivider(
                                          color: gray,
                                          endIndent: 10,
                                          indent: 10,

                                          thickness: 2,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: Text(
                                            snapshot.data!.docs[index]
                                            ['degreeTheses'],
                                            style: hintStyle5,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                SizedBox(
                                  width: 30,
                                  child: IconButton(
                                    onPressed: () async {
                                      await showDialogWarning(context,
                                          text: 'هل انت متاكد من الحذف ',
                                          ontap: () async {
                                            await FirebaseFirestore.instance
                                                .collection('theses')
                                                .doc(snapshot.data!.docs[index].id)
                                                .delete();

                                            // setState(() {
                                            //
                                            // });

                                            Navigator.pop(context);
                                            AwesomeDialog(
                                                context: context,
                                                title: "هام",
                                                body: const Text(
                                                    "تمت عملية الحذف بنجاح"),
                                                dialogType: DialogType.SUCCES)
                                                .show();
                                          });
                                    },
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    iconSize: 20,
                                  ),
                                )
                              ],
                            );
                          });
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
          ],
        ),
        ButtonUser(
            text: "اضافة اطروحة",
            color: blueGradient,
            onTap: () {
              showDialogTheses(
                context,
                text: 'إضافة اطروحة',
                college: widget.college!,
                department: widget.department!,

              );
            }),
      ],
    );
  }
}
