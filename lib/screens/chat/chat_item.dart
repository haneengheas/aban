import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/chat_room.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatRoom()));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: clearblue),
          height: sizeFromHeight(context, 6),
          width: sizeFromWidth(context, 1),
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  'assets/user.png',
                ),
                height: 50,
                color: blue,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'اسم الباحث',
                    style: labelStyle2,
                  ),
                  Text(
                    'متى اخر رسالة',
                    style: hintStyle3,
                  ),
                  Text(
                    '9.57',
                    style: hintStyle3,
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              ),
              Icon(Icons.delete,color: Colors.red,size: 30,),
            ],

          ),
        ),
      ),
    );
  }
}
