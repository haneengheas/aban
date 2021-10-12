import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ThesesList extends StatefulWidget {
 final String text;
 ThesesList({required this.text});

  @override
  State<ThesesList> createState() => _ThesesListState();
}

class _ThesesListState extends State<ThesesList> {
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'اسم الاطروحة',
                                style: labelStyle3,
                              ),
                              Text(
                                'المشرف:اسم المشرف',
                                style: hintStyle3,
                              ),
                              Text(
                                'المشرفون المساعدون:اسماء المشرفين',
                                style: hintStyle3,
                              ),
                            ],
                          ),
                          VerticalDivider(
                            color: gray,
                            endIndent: 10,
                            indent: 10,
                            width: 10,
                            thickness: 2,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  completed[index][0],
                                  style: labelStyle3,
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      print('1');
                                      completed[index][3]=!completed[index][3];
                                    });
                                  },
                                  child: Container(
                                      height: 40,
                                      width: 25,
                                      margin: EdgeInsets.symmetric(vertical: 10),
                                      child: completed[index][3]?ImageIcon(
                                        AssetImage(
                                          'assets/${completed[index][1]}',
                                        ),
                                        color: blue,
                                      ):
                                      ImageIcon(
                                        AssetImage(
                                          'assets/${completed[index][2]}',
                                        ),
                                        color: blue,
                                      )

                                  ),
                                ),
                              ]),
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
  ['دكتوراه', 'bookmark (1).png','bookmark (2).png',true],
  ['ماجستير', 'bookmark (1).png','bookmark (2).png',true],
  ['دكتوراه', 'bookmark (1).png','bookmark (2).png',true],
  ['ماجستير', 'bookmark (1).png','bookmark (2).png',true],
];
