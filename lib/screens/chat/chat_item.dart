import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class ChatItem extends StatefulWidget {
  final String image, name;
  final Timestamp dateTime;
  final Function ontap, ontapicon;

  const ChatItem(
      {required this.name,
      required this.image,
      required this.ontap,
      required this.ontapicon,
      required this.dateTime});

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () {
          widget.ontap();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: clearblue),
          height: sizeFromHeight(context, 6),
          width: sizeFromWidth(context, 1),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 190,
                width: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.image,
                      ),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: labelStyle2,
                  ),
                  Text(
                    'متى اخر رسالة',
                    style: hintStyle3,
                  ),
                  Text(
                    intl.DateFormat('kk:mm').format(widget.dateTime.toDate()),
                    style: hintStyle3,
                  ),
                ],
              ),
              const SizedBox(
                width: 50,
              ),
              InkWell(
                onTap: (){
                  widget.ontapicon();
                },
                  child: const Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
