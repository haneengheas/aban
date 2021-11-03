import 'package:aban/constant/style.dart';
import 'package:aban/screens/profile/eidt_profile/view.dart';
import 'package:aban/screens/profile/facultymember/profile/field_list.dart';
import 'package:aban/screens/profile/facultymember/profile/project_list.dart';
import 'package:aban/screens/profile/facultymember/profile/theses_list.dart';
import 'package:aban/screens/profile/facultymember/profile/uncompletedprojects.dart';
import 'package:aban/screens/profile/facultymember/profile/uncompletedtheseslist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
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
                  child: FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('member')
                          .where('userId',
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                          .get(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return  const Text('');
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          if (snapshot.hasData) {
                            List user = [];

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image(
                                        image: NetworkImage(
                                            snapshot.data!.docs[0]['imageUrl']),
                                        color: blue,
                                        height: 60,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${snapshot.data!.docs[0]['name']}",
                                            style: hintStyle4,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "${snapshot.data!.docs[0]['faculty'] + '   ' + snapshot.data!.docs[0]['degree']}",
                                                style: hintStyle4,
                                              ),
                                              SizedBox(
                                                width:
                                                    sizeFromWidth(context, 8),
                                              ),
                                              Text(
                                                "${snapshot.data!.docs[0]['link']}",
                                                style: hintStyle4,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${snapshot.data!.docs[0]['accept']}",
                                                style: hintStyle4,
                                              ),
                                              SizedBox(
                                                width:
                                                    sizeFromWidth(context, 8),
                                              ),
                                              Text(
                                                "${snapshot.data!.docs[0]['phone']}",
                                                style: hintStyle4,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "${snapshot.data!.docs[0]['id']}",
                                            style: hintStyle4,
                                          ),
                                        ],
                                      ),
                                    ]),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    snapshot.data!.docs[0]['accept'] == 0? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ):const Icon(
                                      Icons.check,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      "أقبل الاشراف على الاطروحات ",
                                      style: hintStyle,
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Text("الذهاب الى ابحاثى",
                                      style: hintStyle),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height /1.65,
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
                                                text:
                                                    'اطروحة مكتملة تحت اشرافي',
                                              ),
                                              UnComletedThesesList(
                                                text: 'اطروحة جارية تحت اشرافي',
                                              ),
                                              CompletedProject(
                                                text: 'مشاريع مكتملة تحت اشرافي',

                                              ),
                                              UnCompletedProject(
                                                text: 'مشاريع جارية تحت اشرافي',

                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                        }
                        return const CircularProgressIndicator();
                      }),
                ),
              ],
            ),
          )),
    );
  }
}
