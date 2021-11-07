import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/profile/facultymember/overview_profile/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatefulWidget {
  final String title;
//1
  const SearchItem({ required this.title,});

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.title.toString());
    print('=====================================');
    // print(widget.title.toList());
    print('=====================================');
    print(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('member').where(
              'department', isEqualTo: widget.title.toString()).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('');
            }
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MemberProfile(
                                      userid: snapshot.data!.docs[index].id,
                                      name: snapshot.data!.docs[index]['name'],
                                      degree: snapshot.data!
                                          .docs[index]['degree'],
                                      email: snapshot.data!.docs[index]['name'],
                                      image: snapshot.data!
                                          .docs[index]['imageUrl'],
                                      phone: snapshot.data!
                                          .docs[index]['phone'],
                                      id: snapshot.data!.docs[index]['id'],
                                      faculty: snapshot.data!
                                          .docs[index]['faculty'],
                                      accept: snapshot.data!
                                          .docs[index]['accept'],
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(9.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: clearblue),
                          height: sizeFromHeight(context, 7),
                          width: sizeFromWidth(context, 1.1),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 190,width: 50,

                                  decoration:  BoxDecoration(
                                      shape: BoxShape.circle, image:DecorationImage(image: NetworkImage(
                                    snapshot.data!.docs[index]['imageUrl'],
                                  ), )),

                                  // child: Image(
                                  //   image:
                                  //   height: sizeFromHeight(context, 13),
                                  //   // color: blue,
                                  // ),
                                ),
                                // SizedBox(
                                //   width: sizeFromWidth(context, 30),
                                // ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 30),
                                        child: Text(
                                          snapshot.data!.docs[index]['name'],
                                          style: labelStyle2,
                                        ),
                                      ),
                                      const Divider(
                                        thickness: 1,
                                        endIndent: 20,
                                        indent: 19,
                                        color: lightGray,
                                        height: 1.5,
                                      ),
                                      Text(
                                        '        ${snapshot.data!
                                            .docs[index]['email']} ',
                                        style: hintStyle,
                                      ), Text(
                                        '        ${snapshot.data!
                                            .docs[index]['degree']}',
                                        style: hintStyle,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            }
            return const Text('');
          }),
    );
  }
}
