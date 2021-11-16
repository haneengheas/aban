import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/chat_item.dart';
import 'package:aban/screens/chat/chatlist.dart';
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
  TextEditingController searchController = TextEditingController();
  List<Chatlist> chatlist = <Chatlist>[];
  List<Chatlist> chatlist2 = <Chatlist>[];
  String filter = '';

  @override
  void initState() {

    chat();
    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });
    // TODO: implement initState
    super.initState();
  }

  chat() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('message')
        // .where('sent', isEqualTo: id)
        .get();

    for (var doc in querySnapshot.docs) {

        chatlist.add(Chatlist(
            userId: doc["userId"],
            image: doc["image"],
            name: doc["name"],
            time: doc["timeDate"]));
      }


    setState(() {});
  }

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
      body: ListView(
        children: [
          SearchTextField(
            text: 'ابحث باسم باحث',
            controller: searchController,
          ),
          SizedBox(height: sizeFromHeight(context, 1.1),
            child: ListView.builder(
              itemCount: chatlist.length,
              itemBuilder: (context, index) {
                return filter == null || filter == ""
                    ? _buildProjBox(
                  chatlist[index],
                )
                    : chatlist[index]
                    .name!
                    .toLowerCase()
                    .contains(filter.toLowerCase()) ||
                    chatlist[index]
                        .name!
                        .toLowerCase()
                        .contains(filter.toLowerCase())
                    ? _buildProjBox(
                  chatlist[index],
                )
                    : Container();
              },
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildProjBox(Chatlist doc) {
    return ChatItem(
        name: doc.name!,
        image: doc.image!,
        ontap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatRoom(
                        image: doc.image!,
                        userId: doc.userId!,
                        name: doc.name!,
                      )));
        },
        ontapicon: () {},
        dateTime: doc.time!);
  }
}
