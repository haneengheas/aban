import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/profile/facultymember/overview_profile/view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchItem extends StatefulWidget {
  const SearchItem({Key? key}) : super(key: key);

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);

    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('member').snapshots(),
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
                                builder: (context) => MemberProfile(
                                      name: snapshot.data!.docs[index]['name'],
                                      degree: snapshot.data!.docs[index]['degree'],
                                      email: snapshot.data!.docs[index]['name'],
                                      image: snapshot.data!.docs[index]['imageUrl'],
                                      phone: snapshot.data!.docs[index]['phone'],
                                      id: snapshot.data!.docs[index]['id'],
                                      faculty: snapshot.data!.docs[index]['faculty'],
                                    )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: clearblue),
                        height: sizeFromHeight(context, 6),
                        width: sizeFromWidth(context, 1.1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image(
                                image: NetworkImage(
                                  snapshot.data!.docs[index]['imageUrl'],
                                ),
                                height: sizeFromHeight(context, 13),
                                // color: blue,
                              ),
                              SizedBox(
                                width: sizeFromWidth(context, 30),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!.docs[index]['name'],
                                    style: hintStyle4,
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: gray,
                                    height: 1.5,
                                  ),
                                  Text(
                                    '        ${snapshot.data!.docs[index]['name']} \n ${snapshot.data!.docs[index]['degree']}',
                                    style: hintStyle2,
                                  ),
                                ],
                              )
                            ],
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
