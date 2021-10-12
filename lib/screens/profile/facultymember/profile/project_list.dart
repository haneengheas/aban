import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProjectList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اسم المشروع',
                                style: labelStyle3,
                              ),
                              Text(
                                'القائد:اسم القائد',
                                style: hintStyle3,
                              ),
                              Text(
                                'الاعضاء:اسماء الاعضاء',
                                style: hintStyle3,
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 50,
                          ),
                          VerticalDivider(
                            color: gray,
                            endIndent: 10,
                            indent: 10,
                            width: 10,
                            thickness: 2,
                          ),
                          Container(
                            height: 40,
                            width: 25,
                            child: ImageIcon(
                              AssetImage(
                                'assets/${completed[index][1]}',
                              ),
                              color: blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}

List<List> completed = [
  ['دكتوراه', 'bookmark (1).png'],
  ['ماجستير', 'bookmark (2).png'],
  ['دكتوراه', 'bookmark (1).png'],
  ['ماجستير', 'bookmark (2).png'],
];
