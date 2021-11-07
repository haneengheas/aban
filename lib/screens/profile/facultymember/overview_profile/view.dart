import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/view.dart';
import 'package:aban/screens/profile/facultymember/profile/field_list.dart';
import 'package:aban/screens/profile/facultymember/profile/project_list.dart';
import 'package:aban/screens/resersh_list/field.dart';
import 'package:aban/screens/resersh_list/project_all_user.dart';
import 'package:aban/screens/resersh_list/project_uncomplered.dart';
import 'package:aban/screens/resersh_list/theses_completed.dart';
import 'package:aban/screens/resersh_list/theses_uncomplered.dart';
import 'package:aban/screens/supervision_request/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MemberProfile extends StatefulWidget {
  String name, image, faculty, email, phone, degree, id,userid;

  MemberProfile({Key? key,required this.userid, required this.name,required this.image,required this.faculty,required this.email,required this.degree,required this.id,required this.phone}) : super(key: key);

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
  
  getUserData()async{
    QuerySnapshot snapshot =await FirebaseFirestore.instance.collection('member').where('name',isEqualTo: widget.name).get();

    for(var doc in snapshot.docs)
      {
        userId = doc['userId'];
      }

    print('user type is '+ userId);


    setState(() {

    });
  }
  
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
                    textStyle: const TextStyle(
                        color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                  )),
              centerTitle: true,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon:const Icon(
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
                        margin:const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>const ChatScreen()));
                              },
                              icon:const Icon(
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
                            TextButton.icon(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const SupervisionScreen()));
                              },
                              icon:const Icon(
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
                              image: NetworkImage(
                                widget.image,
                              ),
                              height: sizeFromHeight(context, 10),
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
                                Row(
                                  children: [
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
                                  ],
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
                                  widget.id,
                                  style: hintStyle,
                                ),
                              ],
                            ),
                          ]),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Icon(
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 2,
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
                                      FieldListresersh(userId: userId,),
                                    CompeletedThesesresersh(
                                      text: 'اطروحة مكتملة تحت اشرافي',
                                      userId: userId,
                                    ),
                                    UnComletedThesesListresersh(
                                      text: 'اطروحة جارية تحت اشرافي',
                                      userId: userId,
                                    ),
                                     CompletedProjectResersh(
                                      text: 'اطروحة جارية تحت اشرافي',
                                       userId: userId,
                                    ),
                                     UnCompletedProjectresersh(
                                      text: 'اطروحة جارية تحت اشرافي',
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
