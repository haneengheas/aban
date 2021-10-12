import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  MessageItem({required this.text, required this.date, required this.isMe});

  final String text;

  final String date;

  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Directionality(
        textDirection: isMe ? TextDirection.ltr : TextDirection.rtl,
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage('assets/user.png'),
                  width: 40,
                  color: blue,
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: sizeFromWidth(context, 1.3),
                  height: 80,
                  child: Material(
                    elevation: 9,
                    borderRadius: BorderRadius.circular(100),
                    color: isMe ? blue : white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 13,
                            color: isMe ? white : black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: 7,
            // ),
            // Text(
            //   date,
            //   style: TextStyle(color: gray, fontSize: 20),
            // ),
          ],
        ),
      ),
    );
  }
}
