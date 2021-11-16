// ignore_for_file: use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem(
      {required this.text,
      // required this.date,
      required this.isMe,
      required this.image});

  final String text, image;

  // final String date;

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
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

                  child: SizedBox(
                    width: 60
                    ,
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

        ],
      ),
    );
    //
    //
    // Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    //   child: Directionality(
    //     textDirection: isMe ? TextDirection.ltr : TextDirection.rtl,
    //     child: Column(
    //       children: [
    //         Row(
    //           children: [
    //             const Image(
    //               image: AssetImage('assets/user.png'),
    //               width: 40,
    //               color: blue,
    //             ),
    //             const SizedBox(
    //               width: 5,
    //             ),
    //             SizedBox(
    //               width: sizeFromWidth(context, 1.4),
    //               height: 90,
    //               child: Material(
    //                 elevation: 9,
    //                 borderRadius: BorderRadius.circular(100),
    //                 color: isMe ? blue : white,
    //                 child: Expanded(
    //                   child: Padding(
    //                     padding: const EdgeInsets.symmetric(
    //                         vertical: 5, horizontal:60),
    //                     child: Directionality(
    //                       textDirection: TextDirection.rtl,
    //                       child: Text(
    //                         text,
    //                         style: TextStyle(
    //                           fontSize: 13,
    //                           color: isMe ? white : black,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //         // SizedBox(
    //         //   height: 7,
    //         // ),
    //         // Text(
    //         //   date,
    //         //   style: TextStyle(color: gray, fontSize: 20),
    //         // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
