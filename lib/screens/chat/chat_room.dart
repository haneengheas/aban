import 'dart:io';

import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/mesage_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatRoom extends StatefulWidget {
  final String image, name;
  final String userId;

  ChatRoom({required this.image, required this.name, required this.userId});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  // _onEmojiSelected(Emoji emoji) {
  //   _controller
  //     ..text += emoji.emoji
  //     ..selection = TextSelection.fromPosition(
  //       TextPosition(offset: _controller.text.length),
  //     );
  // }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  String? id = FirebaseAuth.instance.currentUser!.uid;
  String? email = FirebaseAuth.instance.currentUser!.email;

  String? message;

  late MessageItem messageWidget;

  @override
  void initState() {
    print(id);
    print(widget.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: clearblue,
        appBar: AppBar(
            backgroundColor: white,
            title: Text(widget.name,
                style: GoogleFonts.cairo(
                  textStyle: const TextStyle(
                      color: blue, fontWeight: FontWeight.bold, fontSize: 28),
                )),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                print(id);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: blue,
              ),
            )),
        body: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('message')
                    .orderBy(
                      'timeDate'
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data!.docs.reversed;
                  List<MessageItem> messageWidgets = [];
                  for (var message in messages) {
                    String messageText = message["Text"];
                    String sent = message["sent"];
                    if ((message["sent"] == id ||
                            message["sent"] == widget.userId)&&
                        (message["userId"] == id ||
                            message["userId"] == widget.userId)) {
                      messageWidget = MessageItem(
                          text: messageText,
                          isMe: sent == id,
                          image: widget.image);
                      messageWidgets.add(messageWidget);
                    }else {print('object');}
                  }
                  return Expanded(
                      child: ListView(
                    reverse: true,
                    padding: const EdgeInsets.all(20),
                    children: messageWidgets,
                  ));
                  // return const Text('');
                }),
            Container(
              height: 70,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(15)),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  maxLines: 3,
                  controller: _controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: blue,
                      ),
                      onPressed: () {
                       print(DateTime.now().toLocal()) ;
                       print('//=/=/=/=/===/=/') ;
                        if (_controller.text.isNotEmpty) {
                          FirebaseFirestore.instance.collection('message').add(
                            {
                              "Text": message,
                              "image": widget.image,
                              'userId': widget.userId,
                              'sent': id,
                              'name': widget.name,
                              'timeDate': DateTime.now().toUtc()
                            },
                          );
                        } else {
                          print('object');
                        }
                        setState(() {
                          _controller.clear();
                        });

                        //   print(widget.userId);
                      },
                    ),
                    prefixIcon: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            emojiShowing = !emojiShowing;
                          });
                        },
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color: blue,
                        ),
                      ),
                    ),
                    fillColor: white,
                    filled: true,
                    hintText: 'اكتب الان',
                    hintStyle: hintStyle,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: lightGray)),
                  ),
                  onChanged: (value) {
                    message = value;
                  },
                ),
              ),
            ),
            Offstage(
              offstage: !emojiShowing,
              child: SizedBox(
                height: 250,
                child: EmojiPicker(
                    onEmojiSelected: (Category category, Emoji emoji) {
                      // _onEmojiSelected(emoji);
                    },
                    onBackspacePressed: _onBackspacePressed,
                    config: Config(
                        columns: 7,
                        // Issue: https://github.com/flutter/flutter/issues/28894
                        emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                        verticalSpacing: 0,
                        horizontalSpacing: 0,
                        initCategory: Category.RECENT,
                        bgColor: const Color(0xFFF2F2F2),
                        indicatorColor: Colors.blue,
                        iconColor: Colors.grey,
                        iconColorSelected: Colors.blue,
                        progressIndicatorColor: Colors.blue,
                        backspaceColor: Colors.blue,
                        showRecentsTab: true,
                        recentsLimit: 28,
                        noRecentsText: 'No Recents',
                        noRecentsStyle: const TextStyle(
                            fontSize: 20, color: Colors.black26),
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        categoryIcons: const CategoryIcons(),
                        buttonMode: ButtonMode.MATERIAL)),
              ),
            ),
          ],
        ));
  }
}
