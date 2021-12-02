// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, must_be_immutable, prefer_adjacent_string_concatenation

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/seminar/edit_seminar.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SeminarDetails extends StatefulWidget {
  String? seminarname,
      username,
      location,
      description,
      from,
      to,
      link,
      userid,
      dropdown,
      dropdown2,
      docid;
  var type;
  Timestamp? selectday;
  bool? isFav;

  SeminarDetails(
      {Key? key,
      this.type,
      this.selectday,
      this.userid,
      this.from,
      this.to,
      this.link,
      this.docid,
      this.dropdown,
      this.dropdown2,
      this.isFav,
      this.description,
      this.location,
      this.seminarname,
      this.username})
      : super(key: key);

  @override
  State<SeminarDetails> createState() => _SeminarDetailsState();
}

class _SeminarDetailsState extends State<SeminarDetails> {
  @override
  Widget build(BuildContext context) {
    DateTime myDateTime = DateTime.parse(widget.selectday!.toDate().toString());
    print(myDateTime);

    var prov = Provider.of<ProfileProvider>(context);
    var provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          child: customAppBar(context, title: 'ندوة'),
          preferredSize: const Size.fromHeight(50)),
      body: Column(
        children: [
          Container(
            height: sizeFromHeight(context, 2.2),
            width: sizeFromWidth(context, 1),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: clearblue,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: clearblue),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'اسم الندوة: ${widget.seminarname}',
                                    // overflow: TextOverflow.clip,
                                    maxLines: 2,
                                    style: labelStyle3,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    children: [
                                      Text(
                                        '${widget.selectday!.toDate().year}-${widget.selectday!.toDate().month}-${widget.selectday!.toDate().day}',
                                        style: hintStyle3,
                                      ),
                                      const Icon(
                                        Icons.date_range,
                                        color: blue,
                                        size: 20,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${widget.to}' + '${widget.dropdown2}',
                                  style: hintStyle3,
                                ),
                                Text(
                                  ':' + '${widget.from}' + '${widget.dropdown}',
                                  style: hintStyle3,
                                ),
                              ],
                            ),
                            Text(
                              'اسم الباحث:  ${widget.username}',
                              style: hintStyle3,
                            ),
                            Text(
                              '${widget.location}',
                              style: hintStyle3,
                            ),
                          ],
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.type == 1 ? 'عامة' : 'خاصة',
                              style: labelStyle3,
                            ),
                            prov.counter == 2
                                ? const SizedBox(
                                    height: 50,
                                  )
                                : InkWell(
                                    onTap: () async {
                                      DocumentSnapshot docRef =
                                          await FirebaseFirestore.instance
                                              .collection('seminar')
                                              .doc(widget.docid)
                                              .get();

                                      Map<String, dynamic> docIsFav =
                                          docRef.get("isFav");

                                      if (docIsFav.containsKey(FirebaseAuth
                                          .instance.currentUser!.uid)) {
                                        docIsFav.addAll({
                                          FirebaseAuth.instance.currentUser!.uid
                                                  .toString():
                                              widget.isFav! ? false : true
                                        });
                                      } else {
                                        docIsFav.addAll({
                                          FirebaseAuth.instance.currentUser!
                                              .uid: widget.isFav! ? false : true
                                        });
                                      }

                                      widget.isFav = !widget.isFav!;
                                      await FirebaseFirestore.instance
                                          .collection('seminar')
                                          .doc(widget.docid)
                                          .update({'isFav': docIsFav});
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 25,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: !widget.isFav!
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
                                  )
                          ]),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'وصف الندوة: ',
                    style: labelStyle3,
                  ),
                  Expanded(
                    child: Text(
                      '${widget.description}',
                      style: hintStyle3,
                    ),
                  ),
                  myDateTime.isAfter(DateTime.now())
                      ? InkWell(
                          onTap: () async {
                            debugPrint(widget.link);
                            await launch('https://' + widget.link!);
                          },
                          child: Text(
                            "الدخول إلى الندوة",
                            style: GoogleFonts.cairo(
                              textStyle: const TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 2,
                                  decorationColor: blue,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: blue),
                            ),
                          ),
                        )
                      : const SizedBox(height: 1,),
                  prov.counter == 2
                      ? const SizedBox(height: 1,)
                      : widget.userid == FirebaseAuth.instance.currentUser!.uid
                          ? TextButton(
                              onPressed: () {
                                print(widget.docid);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditSeminar(
                                              docId: widget.docid,
                                              username: widget.username,
                                              isFav: widget.isFav,
                                              userid: widget.userid,
                                              description: widget.description,
                                              from: widget.from,
                                              link: widget.link,
                                              location: widget.location,
                                              selectday: widget.selectday,
                                              seminarname: widget.seminarname,
                                              to: widget.to,
                                              type: widget.type,
                                            )));
                              },
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.edit,
                                    color: blue,
                                    size: 15,
                                  ),
                                  Text('تعديل ندوة',
                                      style: TextStyle(
                                          // decoration: TextDecoration.underline,
                                          // decorationThickness: 2,
                                          decorationColor: blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: blue))
                                ],
                              ),
                            )
                          : const SizedBox(height: 1,),
                  widget.userid == FirebaseAuth.instance.currentUser!.uid &&
                          prov.counter != 2
                      ? InkWell(
                          onTap: () async {
                            print(FirebaseAuth.instance.currentUser!.uid);
                            await showDialogWarning(context,
                                text: 'هل انت متأكد من حذف الندوة',
                                ontap: () async {
                              await FirebaseFirestore.instance
                                  .collection('seminar')
                                  .doc(widget.docid)
                                  .delete()
                                  .then((value) async {
                                await AwesomeDialog(
                                        context: context,
                                        title: "هام",
                                        body:
                                            const Text("تمت عملية الحذف بنجاح"),
                                        dialogType: DialogType.SUCCES)
                                    .show();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NavigationFile(
                                            d: studentDrawer(context),
                                            title:
                                                ' مرحبا ${provider.userName} ',
                                            counter: prov.counter!)));
                              });
                            });
                          },
                          child: Row(
                            children: const [
                              Icon(
                                Icons.delete,
                                color: red,
                                size: 15,
                              ),
                              Text('حذف الندوة',
                                  style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                      // decorationThickness: 2,
                                      decorationColor: red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: red))
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
