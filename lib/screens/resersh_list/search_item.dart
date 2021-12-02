// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/screens/profile/facultymember/overview_profile/view.dart';
import 'package:aban/screens/resersh_list/reasher_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatefulWidget {
  final String title;
 // final List<ResearchModel> projects;
  final String? filter;

  const SearchItem({
    required this.title,
   // required this.projects,
    required this.filter,
  });

  @override
  _SearchItemState createState() => _SearchItemState();
}

class _SearchItemState extends State<SearchItem> {
  List<ResearchModel> projects = <ResearchModel>[];

  itemss() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('member')
        .where('department', isEqualTo: widget.title)
        .get();

    for (var doc in querySnapshot.docs) {
      projects.add(ResearchModel(
        name: doc['name'],
        degree: doc['degree'],
        email: doc['email'],
        imageUrl: doc['imageUrl'],
        phone:  doc['phoneview'],
       // phoneview: doc['phoneview'],
        id: doc['id'],
        faculty: doc['faculty'],
        accept: doc['accept'],
        token: doc['token'],
        link: doc['link'],
        userId: doc['userId'],
        fields: doc['fields'],
      ));
      print(doc['name']);
      print('444444444444444444444444444444444444444444444444');
    }

    setState(() {});
  }
  @override
  void initState() {
    itemss();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, index) {
        return widget.filter == null || widget.filter == ""
            ? _buildProjBox(
          projects[index],
        )
            : projects[index].name!
            .toLowerCase()
            .contains(widget.filter!.toLowerCase()) ||
           projects[index].name!
                .toLowerCase()
                .contains(widget.filter!.toLowerCase()) ||
            projects[index].email!
                .toLowerCase()
                .contains(widget.filter!.toLowerCase()) ||
            projects[index].id!
                .toLowerCase()
                .contains(widget.filter!.toLowerCase())||
            projects[index].fields.toString().toLowerCase()

                .contains(widget.filter!.toLowerCase())
            ? _buildProjBox(
        projects[index],
        )
            : Container();
      },
    );
  }

  Widget _buildProjBox(ResearchModel project) {
    return GestureDetector(
      onTap: () {

        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>

                MemberProfile(
                    userid: project.userId!,
                    accept: project.accept,
                    name: project.name!,
                    link: project.link!,
                    image: project.imageUrl!,
                    faculty: project.faculty!,
                    email: project.email!,
                    degree: project.degree!,
                    id: project.id!,
                    token: project.token!,
                    phone: project.phone!)
            ));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: 10, vertical: 10),
        padding:const  EdgeInsets.symmetric(vertical: 15,horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: clearblue),
        height: sizeFromHeight(context, 7),
        width: sizeFromWidth(context, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 190,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                      project.imageUrl!,
                    ),
                  )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20),
                    child: Text(
                      project.name!,
                      style: labelStyle3,
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
                    '        ${project.email!} ',
                    style: hintStyle3,
                  ),
                  Text(
                    '        ${project.degree!}',
                    style: hintStyle3,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}





