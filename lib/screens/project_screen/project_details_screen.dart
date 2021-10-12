import 'package:aban/constant/style.dart';
import 'package:aban/screens/project_screen/view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProJectDetailsScreen extends StatefulWidget {
  const ProJectDetailsScreen({Key? key}) : super(key: key);

  @override
  _ProJectDetailsScreenState createState() => _ProJectDetailsScreenState();
}

class _ProJectDetailsScreenState extends State<ProJectDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: Text('مشاريع',
            style: GoogleFonts.cairo(
              textStyle: TextStyle(
                  color: blue, fontWeight: FontWeight.bold, fontSize: 28),
            )),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => ProjectScreen()));
          },
          icon: Icon(Icons.arrow_back),
          color: blue,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: sizeFromWidth(context, 1),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: clearblue,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: clearblue),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'اسم المشروع | مكتمل',
                              style: labelStyle2,
                            ),
                            Text(
                              'القائد',
                              style: hintStyle3,
                            ),
                            Text(
                              'اسم القائد',
                              style: hintStyle3,
                            ),
                            Text(
                              'االاعضاء',
                              style: hintStyle3,
                            ),
                            Text(
                              'اسماء الاعضاء',
                              style: hintStyle3,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: sizeFromWidth(context, 8),
                      ),
                      VerticalDivider(
                        color: gray,
                        endIndent: 15,
                        indent: 10,
                        width: 5,
                        thickness:5,
                      ),

                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 25,
                                margin: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: ImageIcon(
                                  AssetImage(
                                    'assets/bookmark (1).png',
                                  ),
                                  color: blue,
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('وصف المشروع',style: labelStyle2,),
                        Text('مشروع يسعي لزيادة الوعي الكافي باهميه ترشيد المياة',style: hintStyle3,),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
