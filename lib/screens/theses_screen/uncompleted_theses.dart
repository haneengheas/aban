import 'package:aban/constant/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class UnCompletedTheses extends StatefulWidget {
  const UnCompletedTheses({Key? key}) : super(key: key);

  @override
  _UnCompletedThesesState createState() => _UnCompletedThesesState();
}

class _UnCompletedThesesState extends State<UnCompletedTheses> {
  bool checked=true;
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
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('اسم الاطروحة',style: hintStyle4,),
                      Text('المشرف:اسم المشرف',style: hintStyle5,),
                      Text('المشرفون المساعدون:اسماء المشرفين',style: hintStyle5,),

                    ],
                  ),
                ),
                const SizedBox(width: 50,),
                const  VerticalDivider(
                  color: gray,
                  endIndent: 10,
                  indent: 10,
                  width: 5,
                  thickness: 2,
                ),
                const SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('دكتوراه',style: hintStyle4,),
                      InkWell(
                        onTap: (){
                          setState(() {
                            checked=!checked;
                          });
                        },
                        child: Container(
                          height: 40,
                          width: 25,
                          margin:const EdgeInsets.symmetric(vertical: 10),
                          child: checked?const ImageIcon(
                             AssetImage('assets/bookmark (1).png',),color: blue,size: 50,):
                          const ImageIcon(
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
