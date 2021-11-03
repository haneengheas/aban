import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnCompletedProject extends StatefulWidget {
  const UnCompletedProject({Key? key}) : super(key: key);

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<UnCompletedProject> {
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('project')
            .where('projectStatus', isEqualTo: 'غير مكتملة')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(snapshot.connectionState== ConnectionState.waiting){
            return const Text('');
          }
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: sizeFromWidth(context, 1),
                  height: 120,
                  decoration: BoxDecoration(
                    color: clearblue,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'اسم المشروع : '+ snapshot.data!.docs[index]['projectName'],
                                style: labelStyle3,
                              ),
                              Text(
                                'القائد:اسم القائد'+ snapshot.data!.docs[index]['leaderName'],
                                style: hintStyle3,
                              ),
                              Text(
                                'الاعضاء:اسماءالاعضاء'+snapshot.data!.docs[index]['memberProjectName'],
                                style: hintStyle3,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: sizeFromWidth(context, 8),
                        ),
                        const VerticalDivider(
                          color: gray,
                          endIndent: 10,
                          indent: 10,
                          width: 5,
                          thickness: 2,
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      checked = !checked;
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 25,
                                    margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                    child: checked
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Text('');

        });
  }
}
