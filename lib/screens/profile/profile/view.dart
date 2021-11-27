// ignore_for_file: avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/profile/eidt_profile/view.dart';
import 'package:aban/screens/profile/profile/field_list.dart';
import 'package:aban/screens/profile/profile/project_list.dart';
import 'package:aban/screens/profile/profile/theses_list.dart';
import 'package:aban/screens/profile/profile/uncompletedprojects.dart';
import 'package:aban/screens/profile/profile/uncompletedtheseslist.dart';
import 'package:aban/screens/theses_screen/theses_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ModelTheses> unCompletedTheses = <ModelTheses>[];
  List<ModelTheses> completedTheses = <ModelTheses>[];
  TextEditingController searchController = TextEditingController();
  String filter = '';

  @override
  void initState() {
    getCompletedTheses();
    getUnCompletedTheses();

    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });

    super.initState();
  }

  getCompletedTheses() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('theses')
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .where('thesesStatus', isEqualTo: 'مكتملة')
        .get();

    for (var doc in querySnapshot.docs) {
      completedTheses.add(ModelTheses(
          nameTheses: doc['nameTheses'],
          assistantSupervisors: doc['assistantSupervisors'],
          degreeTheses: doc['degreeTheses'],
          nameSupervisors: doc['nameSupervisors'],
          linkTheses: doc['linkTheses'],
          thesesStatus: doc['thesesStatus'],
          isFav: doc['isFav'],
          id: doc.id));
    }

    setState(() {});
  }

  getUnCompletedTheses() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('theses')
        .where('thesesStatus', isEqualTo: 'غير مكتملة')
        .get();

    for (var doc in querySnapshot.docs) {
      unCompletedTheses.add(ModelTheses(
          nameTheses: doc['nameTheses'],
          assistantSupervisors: doc['assistantSupervisors'],
          degreeTheses: doc['degreeTheses'],
          nameSupervisors: doc['nameSupervisors'],
          linkTheses: doc['linkTheses'],
          thesesStatus: doc['thesesStatus'],
          isFav: doc['isFav'],
          id: doc.id));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<AuthProvider>(context);
    var provider = Provider.of<ProfileProvider>(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
              backgroundColor: white,
              title: Text('الملف الشخصي',
                  style: GoogleFonts.cairo(
                    textStyle: const TextStyle(
                        color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                  )),
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationFile(
                                title: ' مرحبا${prov.userName} ',
                                d: studentDrawer(context),
                                counter: provider.counter!,
                              )));
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditProfile()));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Text(
                                "تعديل",
                                style: hintStyle,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Icons.edit,
                                color: blue,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('member')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data!.docs[0]['imageUrl']),
                                          )),
                                      height: 50,
                                      width: 50,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data!.docs[0]['name']}",
                                            style: labelStyle2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${snapshot.data!.docs[0]['faculty'] + '-' + snapshot.data!.docs[0]['department']}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: hintStyle,
                                                ),
                                              )
                                              // Text(
                                              //   "${snapshot.data!.docs[0]['link']}",
                                              //   style: hintStyle,
                                              // ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "${snapshot.data!.docs[0]['degree']}",
                                                  style: hintStyle,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${snapshot.data!.docs[0]['email']}",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: hintStyle,
                                                ),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  "Orcid id:${snapshot.data!.docs[0]['id']}",
                                                  style: GoogleFonts.cairo(
                                                    textStyle: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.5,
                                                        decoration: TextDecoration.underline,
                                                        decorationThickness: 2,
                                                        color: gray),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "${snapshot.data!.docs[0]['phone']}",
                                                  style: hintStyle,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                              const SizedBox(
                                height: 10,
                              ),
                              prov.usertype == 0
                                  ? Row(
                                      children: [
                                        snapshot.data!.docs[0]['accept'] == 0
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
                                  : const SizedBox(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: InkWell(
                                  onTap: () async {
                                    print(snapshot.data!.docs[0]['link']);
                                    await launch(
                                        'https://'+snapshot.data!.docs[0]['link']);
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
                                height:
                                    MediaQuery.of(context).size.height / 2.2,
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
                                    const Expanded(
                                      child: SizedBox(
                                        child: TabBarView(
                                          children: [
                                            FieldList(),
                                            CompeletedTheses(
                                            ),
                                            UnComletedThesesList(
                                            ),
                                            CompletedProject(
                                            ),
                                            UnCompletedProject(
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }

                        return const Text('');

                      }),
                ),
              ],
            ),
          )),
    );
  }
}
