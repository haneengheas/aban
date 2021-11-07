import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProJectDetailsScreen extends StatefulWidget {
  String nameProject;
  String leader;
  String members;
  String description;
  String status;
  bool isFav;

  ProJectDetailsScreen({
    Key? key,
    required this.description,
    required this.leader,
    required this.members,
    required this.nameProject,
    required this.status,
    required this.isFav,
  }) : super(key: key);

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
              textStyle: const TextStyle(
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
          icon: const Icon(Icons.arrow_back),
          color: blue,
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            width: sizeFromWidth(context, 1),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('اسم المشروع: ',style: labelStyle3,),
                            Text(
                              widget.nameProject,
                              style: labelStyle3,
                            ),
                            Text(
                            'القائد',
                              style: hintStyle3,
                            ),
                            Text(
                            widget.leader,
                              style: hintStyle3,
                            ),
                            Text(
                              'االاعضاء',
                              style: hintStyle3,
                            ),
                            Text(
                             widget.members,
                              style: hintStyle3,
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('حالة المشروع',style: labelStyle3,),
                              Text(widget.status),
                              Container(
                                height: 40,
                                width: 25,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: widget.isFav== true? const ImageIcon(
                                  AssetImage(
                                    'assets/bookmark (2).png',

                                  ),
                                  color: blue,
                                  size: 50,
                                )
                                    : const ImageIcon(
                                  AssetImage(
                                    'assets/bookmark (1).png',
                                  ),
                                  color: blue,
                                  size: 50,
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'وصف المشروع',
                        style: labelStyle3,
                      ),
                      Text(
                       widget.description,
                        style: hintStyle3,
                      ),
                    ],
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
