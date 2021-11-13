import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/chat_item.dart';
import 'package:aban/widgets/search_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


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

      body:Column(children: [

        const SearchTextField(
          text: 'ابحث باسم باحث',
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('message').where(
              'sent', isEqualTo: id).snapshots(),
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!.docs;
            List<ChatItem> messageWidgets = [];
            for (var message in data) {
              String image = message["image"];
              String name = message["name"];
              print(image);
              print('0000000000000');
              print(name);
              messageWidget = ChatItem(

                  image: image, name: name,);

              messageWidgets.add(messageWidget);
            }
            return Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(20),
                  children: messageWidgets,
                ));

            // return ListView.builder(
            //     itemCount: snapshot.data!.docs.length,
            //
            //     itemBuilder: (context, index) {
            //       print(snapshot.data!.docs[index]['image']);
            //       print('22222222222222222222222222');
            //       print(snapshot.data!.docs[index]['name']);
            //
            //       return  ChatItem(name: snapshot.data!.docs[index]['name'], image: snapshot
            //           .data!.docs[index]['image'],);
            //
            //
            //
            //     }
            // );
          }
      ),],)
    );
  }
}
