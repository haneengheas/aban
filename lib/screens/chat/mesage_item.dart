// ignore_for_file: use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class MessageItem extends StatelessWidget {
  const MessageItem(
      {required this.text,
      required this.time,
      required this.isMe,
      required this.image});

  final String text, image;

  // final String date;

  final bool isMe;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          isMe
              ?Text(intl.DateFormat('kk:mm a').format(time.toDate()),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: gray))
              : const Text(''),
          isMe
              ? const Text('')
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: NetworkImage(image),
                      )),
                  width: 50,
                  height: 50,
                ),
          const SizedBox(
            width: 20,
          ),
          const SizedBox(
            height: 7,
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? blue : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Expanded(

                  child: SizedBox(
                    width: 60,
                    child: Text(
                      text,
                      maxLines: 10,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: isMe ? Colors.white : Colors.black54,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 15,),
          isMe
              ? const Text('')
              :  Text(intl.DateFormat('kk:mm').format(time.toDate()),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                      color: gray)),
        ],
      ),
    );
  }
}
