import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/view.dart';
import 'package:aban/screens/profile/facultymember/profile/field_list.dart';
import 'package:aban/screens/profile/facultymember/profile/project_list.dart';
import 'package:aban/screens/profile/facultymember/profile/theses_list.dart';
import 'package:aban/screens/supervision_request/view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberProfile extends StatelessWidget {
  const MemberProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: white,
          appBar: AppBar(
              backgroundColor: white,
              title: Text('أسم الباحث',
                  style: GoogleFonts.cairo(
                    textStyle: TextStyle(
                        color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                  )),
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
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
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatScreen()));
                              },
                              icon: Icon(
                                Icons.chat_rounded,
                                color: blue,
                                size: 20,
                              ),
                              label: Text(
                                "محادثة",
                                style: hintStyle,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SupervisionScreen()));
                              },
                              icon: Icon(
                                Icons.cast_for_education,
                                color: blue,
                                size: 20,
                              ),
                              label: Text(
                                "طلب اشراف",
                                style: hintStyle,
                              ),
                            )
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
                            Image(
                              image: AssetImage(
                                'assets/user.png',
                              ),
                              color: blue,
                              height: 80,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "اسم الباحث",
                                  style: labelStyle2,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "الكلية/التخصص",
                                      style: hintStyle,
                                    ),
                                    SizedBox(
                                      width: sizeFromWidth(context, 8),
                                    ),
                                    Text(
                                      "Reasearsh@ksuedu.sa",
                                      style: hintStyle3,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "الدرجة العلمية",
                                      style: hintStyle,
                                    ),
                                    SizedBox(
                                      width: sizeFromWidth(context, 8),
                                    ),
                                    Text(
                                      "9665000+",
                                      style: hintStyle,
                                    ),
                                  ],
                                ),
                                Text(
                                  "rocid ID",
                                  style: hintStyle,
                                ),
                              ],
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          Text(
                            "أقبل الاشراف على الاطروحات ",
                            style: hintStyle,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("الذهاب الى ابحاثى", style: hintStyle),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 1.7,
                        child: Column(
                          children: [
                            Divider(
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
                                tabs: <Widget>[
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
                            Divider(
                              color: gray,
                              thickness: .5,
                            ),
                            Expanded(
                              child: SizedBox(
                                child: TabBarView(
                                  children: [
                                    FieldList(),
                                    ThesesList(
                                      text: 'اطروحة مكتملة تحت اشرافي',
                                    ),
                                    ThesesList(
                                      text: 'اطروحة جارية تحت اشرافي',
                                    ),
                                    ProjectList(),
                                    ProjectList(),
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
