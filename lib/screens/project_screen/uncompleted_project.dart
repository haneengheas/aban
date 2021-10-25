import 'package:aban/constant/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class UnCompletedProject extends StatefulWidget {
  const UnCompletedProject({Key? key}) : super(key: key);

  @override
  _UnCompletedProjectState createState() => _UnCompletedProjectState();
}

class _UnCompletedProjectState extends State<UnCompletedProject> {
  bool checked= true;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context,index){
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
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
                  padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('اسم المشروع',style: labelStyle2,),
                      Text('المشرف:اسم المشرف',style: hintStyle3,),
                      Text('المشرفون المساعدون:اسماء المشرفين',style: hintStyle3,),

                    ],
                  ),
                ),
                SizedBox(width: sizeFromWidth(context, 8),),
                const VerticalDivider(
                  color: gray,
                  endIndent: 10,
                  indent: 10,
                  width: 5,
                  thickness: 2,
                ),
                const  SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
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
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: checked? const ImageIcon(
                              AssetImage('assets/bookmark (1).png',),color: blue,size: 50,):
                           const  ImageIcon(
                              AssetImage('assets/bookmark (2).png',),color: blue,size: 50,)

                            ,
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}