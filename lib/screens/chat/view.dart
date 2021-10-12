import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/chat_item.dart';
import 'package:aban/widgets/search_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: white,
          title: Text('المحادثة',
              style: GoogleFonts.cairo(
                textStyle: TextStyle(
                    color: blue, fontWeight: FontWeight.bold, fontSize: 28),
              )),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: blue,
            ),
          )),
      body: ListView(
        children: [
          SearchTextField(
            text: 'ابحث باسم باحث',
          ),
          ChatItem(),
          ChatItem(),
          ChatItem(),
        ],
      ),
    );
  }
}
