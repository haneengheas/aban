import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/chat_item.dart';
import 'package:aban/widgets/search_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_room.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? id = FirebaseAuth.instance.currentUser!.uid;
  late ChatItem messageWidget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
            backgroundColor: white,
            title: Text('المحادثة',
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                      color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                )),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: blue,
              ),
            )),
        body: Column(
          children: [
            // const SearchTextField(
            //   text: 'ابحث باسم باحث',
            // ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('message')
                    .where('sent', isEqualTo: id)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final data = snapshot.data!.docs;
                  List<ChatItem> messageWidgets = [];
                  List<String> messageList = <String>[];

                  for (var message in data) {
                    String image = message["image"];
                    String name = message["name"];
                    String userId = message["userId"];

                    if (!messageList.contains(name) &&
                        (message['sent'] == id || message['userId'] == id)) {
                      messageWidget = ChatItem(
                        image: image,
                        name: name,
                        dateTime: message["timeDate"],
                        ontap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                    image: image,
                                    userId: userId,
                                    name: name,
                                  )));
                        },
                        ontapicon: () {

                        },
                      );

                      messageWidgets.add(messageWidget);

                      messageList.add(message["name"]);
                    }
                  }
                  return Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(20),
                        children: messageWidgets,
                      ));
                }),
          ],
        ));
  }
}