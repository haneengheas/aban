// ignore_for_file: avoid_print, must_be_immutable

import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/chat_room.dart';
import 'package:aban/screens/resersh_list/field.dart';
import 'package:aban/screens/resersh_list/project_all_user.dart';
import 'package:aban/screens/resersh_list/project_uncomplered.dart';
import 'package:aban/screens/resersh_list/theses_completed.dart';
import 'package:aban/screens/resersh_list/theses_uncomplered.dart';
import 'package:aban/screens/supervision_request/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberProfile extends StatefulWidget {
  String name, image, faculty, email, phone, degree, id, userid, token,link;
  int accept;

  MemberProfile(
      {Key? key,
      required this.userid,
      required this.accept,
      required this.name,
      required this.image,
      required this.faculty,
      required this.email,
      required this.degree,
      required this.id,
      required this.link,
      required this.token,
      required this.phone})
      : super(key: key);

  @override
  _MemberProfileState createState() => _MemberProfileState();
}

class _MemberProfileState extends State<MemberProfile> {
  String userId = '';

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('member')
        .where('name', isEqualTo: widget.name)
        .get();

    for (var doc in snapshot.docs) {
      userId = doc['userId'];
    }

    print('user type is ' + userId);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
              backgroundColor: white,
              title: Text(widget.name,
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                        color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                  )),
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: blue,
                ),
              )),
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatRoom(
                                              image: widget.image,
                                              name: widget.name,
                                              userId: widget.userid,
                                            )));
                              },
                              icon: const Icon(
                                Icons.chat_rounded,
                                color: blue,
                                size: 20,
                              ),
                              label: Text(
                                "محادثة",
                                style: hintStyle,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            widget.accept == 0
                                ? TextButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SupervisionScreen(
                                                    userid: userId,
                                                    token: widget.token,
                                                  )));
                                    },
                                    icon: const Icon(
                                      Icons.cast_for_education,
                                      color: blue,
                                      size: 20,
                                    ),
                                    label: Text(
                                      "طلب اشراف",
                                      style: hintStyle,
                                    ),
                                  )
                                : const Text(''),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(widget.image),
                                  )),
                              height: 60,
                              width: 60,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: labelStyle2,
                                ),
                                Text(
                                  widget.faculty,
                                  style: hintStyle,
                                ),
                                SizedBox(
                                  width: sizeFromWidth(context, 8),
                                ),
                                Text(
                                  widget.email,
                                  style: hintStyle3,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      widget.degree,
                                      style: hintStyle,
                                    ),
                                    SizedBox(
                                      width: sizeFromWidth(context, 8),
                                    ),
                                    Text(
                                      widget.phone,
                                      style: hintStyle,
                                    ),
                                  ],
                                ),
                                Text(
                                  "Orcid id:${widget.id}",
                                  style: GoogleFonts.cairo(
                                    textStyle: const TextStyle(
                                        fontSize: 15,
                                        fontWeight:
                                        FontWeight.w400,
                                        height: 1.5,
                                        decoration: TextDecoration.underline,
                                        decorationThickness: 2,
                                        color: gray),
                                  ),)
                              ],
                            ),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      widget.accept != 2
                          ? Row(
                              children: [
                                widget.accept == 0
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        Icons.close,
                                        color: Colors.red,
                                      ),
                                Text(
                                  "أقبل الاشراف على الاطروحات ",
                                  style: hintStyle,
                                ),
                              ],
                            )
                          : const Text(''),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 15),
                        child: InkWell(
                          onTap: () async {
                            print(widget.link);
                            await launch(
                                'https://'+widget.link);
                          },
                          child: Text(
                            "الذهاب الى ابحاثى",
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

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2.3,
                        child: Column(
                          children: [
                            const Divider(
                              color: gray,
                              thickness: .5,
                            ),
                            SizedBox(
                              height: 50,
                              child: (TabBar(
                                labelColor: blue,
                                unselectedLabelColor: gray,
                                labelStyle: hintStyle,
                                isScrollable: true,
                                tabs: const <Widget>[
                                  Tab(
                                    text: 'المجالات',
                                  ),
                                  Tab(
                                    text: 'الاطروحات\nالمكتملة',
                                  ),
                                  Tab(
                                    text: 'الاطروحات \nالجارية',
                                  ),
                                  Tab(
                                    text: 'المشاريع\n المكتملة',
                                  ),
                                  Tab(
                                    text: 'المشاريع \nالجارية',
                                  )
                                ],
                              )),
                            ),
                            const Divider(
                              color: gray,
                              thickness: .5,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: TabBarView(
                                  children: [
                                    FieldListresersh(
                                      userId: userId,
                                    ),
                                    CompeletedThesesresersh(
                                      text: '',
                                      userId: userId,
                                    ),
                                    UnComletedThesesListresersh(
                                      text: '',
                                      userId: userId,
                                    ),
                                    CompletedProjectResersh(
                                      text: '',
                                      userId: userId,
                                    ),
                                    UnCompletedProjectresersh(
                                      text: '',
                                      userId: userId,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
