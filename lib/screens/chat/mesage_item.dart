// ignore_for_file: use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
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
    return Row(
      children: [
        isMe ?const Text(''): Container(
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
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 7,
            ),
            Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(30),
              color: isMe ? blue : white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(text,
                    style:
                        TextStyle(fontSize: 20, color: isMe ? white : black)),
              ),
            ),
          ],
        ),
      ],
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
