// ignore_for_file: avoid_print, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/project_screen/proj_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class UnCompletedProjectresersh extends StatefulWidget {
  final String? userId;

  const UnCompletedProjectresersh({ required this.userId});

  @override
  State<UnCompletedProjectresersh> createState() =>
      _UnCompletedProjectresershState();
}

class _UnCompletedProjectresershState extends State<UnCompletedProjectresersh> {
  List<ProjectModel> unCompletedProjects = <ProjectModel>[];

  @override
  void initState() {
    getUnCompletedProjects();

    super.initState();
  }

  getUnCompletedProjects() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('project')
        .where('projectStatus', isEqualTo: 'غير مكتملة').where('userId',isEqualTo: widget.userId)
        .get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> docIsFav = doc['isFav'];
      bool isFav = false;
      if(docIsFav.containsKey(FirebaseAuth.instance.currentUser!.uid.toString()))
      {
        isFav = docIsFav[FirebaseAuth.instance.currentUser!.uid.toString()];
      }else{
        isFav = false;
      }
      print(isFav);
      print("=============================");

      unCompletedProjects.add(ProjectModel(
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
          id: doc.id));
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
                itemCount: unCompletedProjects.length,
                itemBuilder: (context, index) {

                  return _buildProjectBox( unCompletedProjects[index]);
                }),
          ),
        )
      ],
    );
  }
  Widget _buildProjectBox (ProjectModel project){
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
          mainAxisAlignment:
          MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اسم المشروع:'+
                        project.projectName!,
                    style: labelStyle3,
                  ),
                  Text(
                    'القائد :' +
                        project.leaderName!,

                    style: hintStyle3,
                  ),
                  Text(
                    'الاعضاء :' +
                        project.memberProjectName!,

                    style: hintStyle3,
                  ),
                ],
              ),
            ),

            prov.counter == 2? const SizedBox():const VerticalDivider(
              color: gray,
              endIndent: 10,
              indent: 10,
              width: 20,
              thickness: 2,
            ),
            prov.counter == 2? const SizedBox(): InkWell(
              onTap: () async {
                DocumentSnapshot docRef = await FirebaseFirestore
                    .instance
                    .collection('project')
                    .doc(project.id)
                    .get();

                Map<String, dynamic> docIsFav =
                docRef.get("isFav");

                if (docIsFav.containsKey(
                    FirebaseAuth.instance.currentUser!.uid)) {
                  docIsFav.addAll({
                    FirebaseAuth.instance.currentUser!.uid
                        .toString(): project.isFav! ? false : true
                  });
                } else {
                  docIsFav.addAll({
                    FirebaseAuth.instance.currentUser!.uid:
                    project.isFav! ? false : true
                  });
                }

                FirebaseFirestore.instance
                    .collection('projectBookmark')
                    .doc(project.id)
                    .set({
                  'projectName': project.projectName,
                  'leaderName': project.leaderName,
                  'descriptionProject':
                  project.descriptionProject,
                  'memberProjectName': project.memberProjectName,
                  'projectStatus': project.projectStatus,
                  'userId':
                  FirebaseAuth.instance.currentUser!.uid,
                  'isFav': docIsFav
                });

                project.isFav = !project.isFav!;
                await FirebaseFirestore.instance
                    .collection('project')
                    .doc(project.id)
                    .update({'isFav': docIsFav});

                if (project.isFav == false) {
                  FirebaseFirestore.instance
                      .collection('projectBookmark')
                      .doc(project.id)
                      .delete();
                }
                setState(() {});
              },
              child: Container(
                height: 40,
                width: 25,
                margin: const EdgeInsets.symmetric(
                    vertical: 30, horizontal: 10),
                child: !project.isFav!
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

