import 'dart:io';

import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/mesage_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';


class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController _controller = TextEditingController();
  bool emojiShowing = false;

  _onEmojiSelected(Emoji emoji) {
    _controller
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }

  _onBackspacePressed() {
    _controller
      ..text = _controller.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: clearblue,
        appBar: AppBar(
          backgroundColor: white,
          title: Text('أسم الباحث',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                    color: blue, fontWeight: FontWeight.bold, fontSize: 28),
              )),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          }, icon: const Icon(
            Icons.arrow_back,
            color: blue,
          ),)
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height / 1.2,
                margin:const EdgeInsets.symmetric(horizontal: 10),
                padding:const  EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: lightgray,
                ),
                child: ListView(
                  children: const [
                    MessageItem(
                        text:
                            "ويجري حاليا نجم ليفربول محادثات بشأن\n تجديد عقده مع ناديه، حيث من\n المقرر أن ينتهي بنهاية يونيو 2023",
                        date: "adssad",
                        isMe: true),
                    MessageItem(
                        text:
                            "ويجري حاليا نجم ليفربول محادثات \nبشأن تجديد عقده مع ناديه، حيث من\n المقرر أن ينتهي بنهاية يونيو 2023",
                        date: "adssad",
                        isMe: false),
                    MessageItem(
                        text:
                            "ويجري حاليا نجم ليفربول محادثات بشأن\n تجديد عقده مع ناديه، حيث من\n المقرر أن ينتهي بنهاية يونيو 2023",
                        date: "adssad",
                        isMe: true),
                    MessageItem(
                        text:
                            "ويجري حاليا نجم ليفربول محادثات \nبشأن تجديد عقده مع ناديه، حيث من\n المقرر أن ينتهي بنهاية يونيو 2023",
                        date: "adssad",
                        isMe: false),
                    MessageItem(
                        text:
                        "ويجري حاليا نجم ليفربول محادثات بشأن\n تجديد عقده مع ناديه، حيث من\n المقرر أن ينتهي بنهاية يونيو 2023",
                        date: "adssad",
                        isMe: true),
                    MessageItem(
                        text:
                        "ويجري حاليا نجم ليفربول محادثات بشأن\n تجديد عقده مع ناديه، حيث من\n المقرر أن ينتهي بنهاية يونيو 2023",
                        date: "adssad",
                        isMe: false),
                    MessageItem(
                        text:
                        "ويجري حاليا نجم ليفربول محادثات بشأن\n تجديد عقده مع ناديه، حيث من\n المقرر أن ينتهي بنهاية يونيو 2023",
                        date: "adssad",
                        isMe: true),
                  ],
                ),
              ),
            ),
            Container(
              height: 70,
              margin:const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(15)),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: blue,
                      ),
                      onPressed: () {},
                    ),
                    prefixIcon:  Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            emojiShowing = !emojiShowing;
                          });
                        },
                        icon: const Icon(
                          Icons.emoji_emotions,
                          color:blue,
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

                ),

              ),
            ),
            Offstage(
              offstage: !emojiShowing,
              child: SizedBox(
                height: 250,
                child: EmojiPicker(
                    onEmojiSelected: (Category category, Emoji emoji) {
                      _onEmojiSelected(emoji);
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
