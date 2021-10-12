import 'package:aban/constant/style.dart';
import 'package:aban/screens/project_screen/project_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CompletedProject extends StatefulWidget {
  @override
  _CompletedProjectState createState() => _CompletedProjectState();
}

class _CompletedProjectState extends State<CompletedProject> {
   bool checked = true;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProJectDetailsScreen()));
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: sizeFromWidth(context, 1),
            height: 120,
            decoration: BoxDecoration(
              color: clearblue,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'اسم المشروع',
                          style: labelStyle2,
                        ),
                        Text(
                          'القائد:اسم القائد',
                          style: hintStyle3,
                        ),
                        Text(
                          'الاعضاء:اسماءالاعضاء',
                          style: hintStyle3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: sizeFromWidth(context, 3)),
                  VerticalDivider(
                    color: gray,
                    endIndent: 10,
                    indent: 10,
                    width: 5,
                    thickness: 2,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 20),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                checked=!checked;
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 25,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: checked? ImageIcon(
                                AssetImage('assets/bookmark (1).png',),color: blue,size: 50,):
                              ImageIcon(
                                AssetImage('assets/bookmark (2).png',),color: blue,size: 50,)

                              ,
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
