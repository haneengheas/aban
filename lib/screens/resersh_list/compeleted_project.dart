// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/project_screen/proj_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CompletedProjectResersh extends StatefulWidget {

  const CompletedProjectResersh({ this.userId});

  final String? userId;

  @override
  State<CompletedProjectResersh> createState() =>
      _CompletedProjectResershState();
}

class _CompletedProjectResershState extends State<CompletedProjectResersh> {
  bool checked = true;
  List<ProjectModel> unCompletedProjects = <ProjectModel>[];
  List<ProjectModel> completedProjects = <ProjectModel>[];
  TextEditingController searchController = TextEditingController();
  String filter = '';

  @override
  void initState() {
    getCompletedProjects();
    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });

    super.initState();
  }

  getCompletedProjects() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('project')
        .where('projectStatus', isEqualTo: 'مكتملة').where('userId',isEqualTo: widget.userId)
        .get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> docIsFav = doc['isFav'];
      bool isFav = false;
      if (docIsFav.containsKey(
          FirebaseAuth.instance.currentUser!.uid.toString())) {
        isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
      } else {
        isFav = false;
      }
      print(isFav);
      print("=============================");

      completedProjects.add(
        ProjectModel(
            descriptionProject: doc['descriptionProject'],
            leaderName: doc['leaderName'],
            isFav: isFav,
            userId: doc['userId'],
            projectStatus: doc['projectStatus'],
            memberProjectName: doc['memberProjectName'],
            projectName: doc['projectName'],
            department: doc['department'],
            college: doc['college'],
            projectLink: doc['projectLink'],
            id: doc.id),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Expanded(
          child: SizedBox(
            child: ListView.builder(
                itemCount: completedProjects.length,
                itemBuilder: (context, index) {

                  return _buildProjectBox( completedProjects[index]);
                }),
          ),
        )
      ],
    );
  }
  Widget _buildProjectBox(ProjectModel projectModel){
    var prov = Provider.of<ProfileProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(
          horizontal: 10, vertical: 10),
      width: sizeFromWidth(context, 1),
      height: 100,
      decoration: BoxDecoration(
        color: clearblue,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اسم المشروع:'+
                        projectModel.projectName!,
                    maxLines: 2,
                    style: GoogleFonts.cairo(

                      textStyle: const TextStyle(
                          overflow: TextOverflow.clip,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: black),
                    ),
                  ),
                  Text(
                    'القائد :' +
                        projectModel.leaderName!,

                    style: hintStyle3,
                  ),
                  Text(
                    'الاعضاء :' +
                        projectModel.memberProjectName!,

                    style: hintStyle3,
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   width: 50,
            // ),
            prov.counter == 2? const SizedBox():const VerticalDivider(
              color: gray,
              endIndent: 10,
              indent: 10,
              width: 20,
              thickness: 2,
            ),
            prov.counter == 2? const SizedBox(): InkWell(
              onTap: () async {

                //copy from heree
                DocumentSnapshot docRef = await FirebaseFirestore
                    .instance
                    .collection('project')
                    .doc(projectModel.id)
                    .get();

                Map<String, dynamic> docIsFav =
                docRef.get("isFav");

                if (docIsFav.containsKey(
                    FirebaseAuth.instance.currentUser!.uid)) {
                  docIsFav.addAll({
                    FirebaseAuth.instance.currentUser!.uid
                        .toString(): projectModel.isFav! ? false : true
                  });
                } else {
                  docIsFav.addAll({
                    FirebaseAuth.instance.currentUser!.uid:
                    projectModel.isFav! ? false : true
                  });
                }
                //to here :D



                FirebaseFirestore.instance
                    .collection('projectBookmark')
                    .doc(projectModel.id)
                    .set({
                  'projectName': projectModel.projectName,
                  'leaderName': projectModel.leaderName,
                  'descriptionProject':
                  projectModel.descriptionProject,
                  'memberProjectName': projectModel.memberProjectName,
                  'projectStatus': projectModel.projectStatus,
                  'userId':
                  FirebaseAuth.instance.currentUser!.uid,
                  'isFav':docIsFav
                });

                projectModel.isFav = !projectModel.isFav!;
                await FirebaseFirestore.instance
                    .collection('project')
                    .doc(projectModel.id)
                    .update({'isFav': docIsFav});
                if (projectModel.isFav == false) {
                  FirebaseFirestore.instance
                      .collection('projectBookmark')
                      .doc(projectModel.id)
                      .delete();
                }
                setState(() {});
                print(projectModel.id);
              },
              child: Container(
                height: 40,
                width: 25,
                margin: const EdgeInsets.symmetric(
                    vertical: 30, horizontal: 10),
                child: !projectModel.isFav!
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
            ),

          ],
        ),
      ),
    );
  }

}

List<List> completed = [
  ['دكتوراه', 'bookmark (1).png', true, 'bookmark (2).png'],
  ['ماجستير', 'bookmark (1).png', false, 'bookmark (2).png'],
  ['دكتوراه', 'bookmark (1).png', true, 'bookmark (2).png'],
  ['ماجستير', 'bookmark (1).png', true, 'bookmark (2).png'],
];
