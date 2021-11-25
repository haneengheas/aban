// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/project_screen/proj_model.dart';
import 'package:aban/screens/project_screen/project_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedProject extends StatefulWidget {
  const CompletedProject(this.projects, this.filter);

  final List<ProjectModel> projects;
  final String? filter;

  @override
  _CompletedProjectState createState() => _CompletedProjectState();
}

class _CompletedProjectState extends State<CompletedProject> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.projects.length,
      itemBuilder: (context, index) {
        return widget.filter == null || widget.filter == ""
            ? _buildProjBox(
                widget.projects[index],
              )
            : widget.projects[index].projectName!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase()) ||
                    widget.projects[index].leaderName!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase()) ||
                    widget.projects[index].memberProjectName!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase()) ||
                    widget.projects[index].college!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase()) ||
                    widget.projects[index].department!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase())
                ? _buildProjBox(
                    widget.projects[index],
                  )
                : Container();
      },
    );
  }

  Widget _buildProjBox(ProjectModel project) {
    var prov = Provider.of<ProfileProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProjectDetailsScreen(
                      description: project.descriptionProject!,
                      leader: project.leaderName!,
                      members: project.memberProjectName!,
                      projectLink: project.projectLink!,
                      nameProject: project.projectName!,
                      status: project.projectStatus!,
                      isFav: project.isFav!,
                      userid: project.userId!,
                      id: project.id!,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: sizeFromWidth(context, 1),
        height: 120,
        decoration: BoxDecoration(
          color: clearblue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'اسم المشروع:' + project.projectName!,
                      style: labelStyle3,
                    ),
                    Text(
                      'القائد:' + project.leaderName!,
                      style: hintStyle3,
                    ),
                    Text(
                      'الاعضاء:' + project.memberProjectName!,
                      style: hintStyle3,
                    ),
                  ],
                ),
              ),
              prov.counter == 2
                  ? const SizedBox()
                  : const VerticalDivider(
                      color: gray,
                      endIndent: 10,
                      indent: 10,
                      width: 10,
                      thickness: 2,
                    ),
              prov.counter == 2
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                          InkWell(
                            onTap: () async {
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
                                'isFav': project.isFav! ? false : true
                              });

                              project.isFav = !project.isFav!;
                              await FirebaseFirestore.instance
                                  .collection('project')
                                  .doc(project.id)
                                  .update({'isFav': project.isFav!});
                              if (project.isFav == false) {
                                FirebaseFirestore.instance
                                    .collection('projectBookmark')
                                    .doc(project.id)
                                    .delete();
                              }
                              setState(() {});
                              print(project.id);
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
                        ]),
            ],
          ),
        ),
      ),
    );
  }
}
