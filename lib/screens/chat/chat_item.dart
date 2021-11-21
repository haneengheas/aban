// ignore_for_file: use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

class ChatItem extends StatefulWidget {
  final String image, name, lastmassage;
  final Timestamp dateTime;
  final Function ontap, ontapicon;

  const ChatItem(
      {required this.name,
      required this.image,
      required this.lastmassage,
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
          padding: const EdgeInsets.symmetric(horizontal: 10),
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: labelStyle2,
                      ),
                      Text(
                      widget.lastmassage,
                        maxLines: 2,
                        style: GoogleFonts.cairo(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: gray,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ),
                      Text(
                        intl.DateFormat('kk:mm a').format(widget.dateTime.toDate()),
                        style: hintStyle3,
                      ),
                    ],
                  ),
                ),
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
