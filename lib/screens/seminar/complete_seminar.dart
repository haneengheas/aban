import 'package:aban/constant/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_seminar.dart';

class CompleteSeminar extends StatefulWidget {
  const CompleteSeminar({Key? key}) : super(key: key);

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<CompleteSeminar> {
  bool checked= true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddSeminar()));
        }, child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('أضف ندوة  ',style: hintStyle2,),

            Icon(Icons.add_circle_outline,color: blue,size: 20,),
          ],
        ),),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                width: sizeFromWidth(context, 1),
                height: 120,
                decoration: BoxDecoration(
                  color: clearblue,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,

                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Text('اسم الندوة',style: labelStyle2,),
                                SizedBox(
                                  width: sizeFromWidth(context, 5),
                                ),
                                Text('24 ابريل2021',style:hintStyle3,),
                                Icon(Icons.date_range,color: blue,size: 20,)


                              ],
                            ),
                            Text('8:00-8:30pm',style: hintStyle3,),
                            Text('اسم الباحث',style: hintStyle3,),
                            Text('منبي 6 الدور الاول قاعة 23',style: hintStyle3,),
                          ],
                        ),
                      ),
                      VerticalDivider(
                        color: gray,
                        endIndent: 10,
                        indent: 10,
                        width: 5,
                        thickness: 2,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('عامة',style: labelStyle3,),
                            InkWell(
                              onTap: (){
                                setState(() {
                                  checked=!checked;
                                });
                              },
                              child: Container(

                                 margin: EdgeInsets.symmetric(vertical: 5),
                                child: checked? ImageIcon(
                                  AssetImage('assets/bookmark (1).png',),color: blue,):
                                ImageIcon(
                                  AssetImage('assets/bookmark (2).png',),color: blue,)

                                ,
                              ),
                            ),
                          ]
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
