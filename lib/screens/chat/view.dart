// ignore_for_file: avoid_print

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/screens/chat/chat_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
    var prov = Provider.of<AuthProvider>(context);
    print(prov.userName);

    print(
        '000000000000000000000000000000000000000000000000000000000000000000000');
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('member')
                    .doc(id)
                    .collection('message')
                    .orderBy('timeDate')
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
                    String name = message["otherName"];
                    String userId = FirebaseAuth.instance.currentUser!.uid ==
                            message["userId"]
                        ? message["sent"]
                        : message["userId"];
                    String lastMessage = message["Text"];
                    print(lastMessage);

                    messageList.removeWhere(
                        (element) => element == message["otherName"]);
                    messageWidgets.removeWhere(
                        (element) => element.name == message["otherName"]);

                    if (!messageList.contains(name) &&
                        (message['sent'] == id || message['userId'] == id)) {
                      messageWidget = ChatItem(
                        image: image,
                        name: name,
                        dateTime: message["timeDate"],

                        ontap: () {

                          print(FirebaseAuth.instance.currentUser!.uid ==
                                  message["userId"]
                              ? message["sent"]
                              : message["userId"]);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatRoom(
                                        image: image,
                                        userId: userId,
                                        name: name,
                                      )));
                        },
                        ontapicon: () async {
                          await showDialogWarning(
                            context,
                            text: 'هل انت متاكد من حذف المحادثة؟',
                            ontap: () async {
                              await FirebaseFirestore.instance
                                  .collection('member')
                                  .doc(id)
                                  .collection('message')
                                  .get()
                                  .then((snapshot) {
                                for (DocumentSnapshot ds in snapshot.docs) {
                                  if ((ds["sent"] == id ||
                                          ds["sent"] == userId) &&
                                      (ds["userId"] == id ||
                                          ds["userId"] == userId)) {
                                    ds.reference.delete();
                                  } else {
                                    print('errrrrrrrrrrrrrrrrrrrrrrrrrrrrrro');
                                  }
                                }
                              });
                              Navigator.pop(context);
                            },
                          );
                        },
                        lastmassage: lastMessage,
                      );

                      messageWidgets.add(messageWidget);
                      messageList.removeWhere(
                          (element) => element == message["otherName"]);

                      messageList.add(message["otherName"]);
                      print(messageList);
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
