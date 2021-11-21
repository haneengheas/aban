// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:aban/screens/project_screen/proj_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CompletedProject extends StatefulWidget {
  final String text;

  const CompletedProject({required this.text});

  @override
  State<CompletedProject> createState() => _CompletedProjectState();
}

class _CompletedProjectState extends State<CompletedProject> {
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
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid,
        )
        .where('projectStatus', isEqualTo: 'مكتملة')
        .get();

    for (var doc in querySnapshot.docs) {
      completedProjects.add(
        ProjectModel(
            descriptionProject: doc['descriptionProject'],
            leaderName: doc['leaderName'],
            isFav: doc['isFav'],
            userId: doc['userId'],
            projectStatus: doc['projectStatus'],
            memberProjectName: doc['memberProjectName'],
            projectName: doc['projectName'],
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            widget.text,
            style: hintStyle,
          ),
        ),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
                itemCount: completedProjects.length,
                itemBuilder: (context, index) {
                  return _buildProjectBox(completedProjects[index]);
                }),
          ),
        )
      ],
    );
  }

  Widget _buildProjectBox(ProjectModel projectModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اسم المشروع:' + projectModel.projectName!,
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
                    'القائد :' + projectModel.leaderName!,
                    style: hintStyle3,
                  ),
                  Text(
                    'الاعضاء :' + projectModel.memberProjectName!,
                    style: hintStyle3,
                  ),
                ],
              ),
            ),
            // const SizedBox(
            //   width: 50,
            // ),
            const VerticalDivider(
              color: gray,
              endIndent: 10,
              indent: 10,
              width: 20,
              thickness: 2,
            ),
            // InkWell(
            //   onTap: () async {
            //     FirebaseFirestore.instance
            //         .collection('projectBookmark')
            //         .doc(projectModel.id)
            //         .set({
            //       'projectName': projectModel.projectName,
            //       'leaderName': projectModel.leaderName,
            //       'descriptionProject': projectModel.descriptionProject,
            //       'memberProjectName': projectModel.memberProjectName,
            //       'projectStatus': projectModel.projectStatus,
            //       'userId': FirebaseAuth.instance.currentUser!.uid,
            //       'isFav': projectModel.isFav! ? false : true
            //     });
            //
            //     projectModel.isFav = !projectModel.isFav!;
            //
            //     await FirebaseFirestore.instance
            //         .collection('project')
            //         .doc(projectModel.id)
            //         .update({'isFav': projectModel.isFav!});
            //     if (projectModel.isFav == false) {
            //       FirebaseFirestore.instance
            //           .collection('projectBookmark')
            //           .doc(projectModel.id)
            //           .delete();
            //     }
            //     setState(() {});
            //   },
            //   // child: Container(
            //   //   height: 40,
            //   //   width: 25,
            //   //   margin:
            //   //       const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            //   //   child: !projectModel.isFav!
            //   //       ? const ImageIcon(
            //   //           AssetImage(
            //   //             'assets/bookmark (1).png',
            //   //           ),
            //   //           color: blue,
            //   //           size: 50,
            //   //         )
            //   //       : const ImageIcon(
            //   //           AssetImage(
            //   //             'assets/bookmark (2).png',
            //   //           ),
            //   //           color: blue,
            //   //           size: 50,
            //   //         ),
            //   // ),
            // ),
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
