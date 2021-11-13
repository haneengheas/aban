import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/chat_room.dart';
import 'package:flutter/material.dart';

class ChatItem extends StatelessWidget {
  final String image,name;
  const ChatItem({required this.name,required this.image,});


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> const ChatRoom(image:'x', userId: '',  )));
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: clearblue),
          height: sizeFromHeight(context, 6),
          width: sizeFromWidth(context, 1),
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 190, width: 50,

                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(
                     image,
                    ),)),


              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
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
              const SizedBox(
                width: 50,
              ),
              const Icon(Icons.delete,color: Colors.red,size: 30,),
            ],

          ),
        ),
      ),
    );
  }
}
