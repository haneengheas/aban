// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/seminar/edit_seminar.dart';
import 'package:aban/widgets/customAppBar.dart';
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
    return Scaffold(
      appBar: PreferredSize(
          child: customAppBar(context, title: 'ندوة'),
          preferredSize: const Size.fromHeight(50)),
      body: Column(
        children: [
          Container(
            height: 240,
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
                                Text(
                                  '${widget.seminarname}',
                                  style: labelStyle3,
                                ),
                                Row(
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
                              '${widget.username}',
                              style: hintStyle3,
                            ),
                            Text(
                              '${widget.location}',
                              style: hintStyle3,
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: gray,
                        endIndent: 10,
                        indent: 20,
                        width: 20,
                        thickness: 5,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.type == 1 ? 'عامة' : 'خاصة',
                              style: labelStyle3,
                            ),
                            Container(
                              height: 40,
                              width: 25,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: widget.isFav == true
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
                            )
                          ]),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  myDateTime.isBefore(DateTime.now())
                      ? SizedBox(
                          height: 40,
                          child: Column(
                            children: [
                              Text(
                                'وصف الندوة',
                                style: labelStyle3,
                              ),
                              Expanded(
                                child: Text(
                                  '${widget.description}',
                                  style: hintStyle3,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: InkWell(
                            onTap: () async {
                              await launch(widget.link!);
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
                          ),
                        ),
                  prov.counter == 2
                      ? const SizedBox()
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
                                children: [
                                  const Icon(
                                    Icons.edit,
                                    color: blue,
                                    size: 15,
                                  ),
                                  Text(
                                    'تعديل ندوة',
                                    style: hintStyle3,
                                  )
                                ],
                              ),
                            )
                          : const SizedBox()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
