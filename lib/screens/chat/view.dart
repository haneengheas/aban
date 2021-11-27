// // ignore_for_file: avoid_print
//
// import 'package:aban/constant/style.dart';
// import 'package:aban/screens/chat/chat_item.dart';
// import 'package:aban/screens/chat/chatlist.dart';
// import 'package:aban/widgets/search_textfield.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// import 'chat_room.dart';
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   String? id = FirebaseAuth.instance.currentUser!.uid;
//   TextEditingController searchController = TextEditingController();
//   List<Chatlist> chatlist = <Chatlist>[];
//   // List<Chatlist> chatlist2 = <Chatlist>[];
//   String filter = '';
//
//   @override
//   void initState() {
//     chat();
//     searchController.addListener(() {
//       filter = searchController.text;
//       setState(() {});
//     });
//     // TODO: implement initState
//     super.initState();
//   }
//
//   chat() async {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('message')
//         .orderBy('timeDate')
//         .get();
//
//     for (var doc in querySnapshot.docs) {
//       if (
//       !chatlist.contains(doc["name"])
//           &&
//           (doc["userId"] == id || doc['sent'] == id)) {
//         chatlist.add(Chatlist(
//             massage: doc["Text"],
//             userId: doc["userId"],
//             sentId: doc['sent'],
//             image: doc["image"],
//             name: doc["name"],
//             time: doc["timeDate"]));
//       }
//     }
//
//     setState(() {});
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: white,
//       appBar: AppBar(
//           backgroundColor: white,
//           title: Text('المحادثة',
//               style: GoogleFonts.cairo(
//                 textStyle: const TextStyle(
//                     color: blue, fontWeight: FontWeight.bold, fontSize: 28),
//               )),
//           centerTitle: true,
//           elevation: 0,
//           leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               color: blue,
//             ),
//           )),
//       body: ListView(
//         children: [
//           SearchTextField(
//             text: 'ابحث باسم باحث',
//             controller: searchController,
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           SizedBox(
//             height: sizeFromHeight(context, 1.1),
//             child: ListView.builder(
//               itemCount: chatlist.length,
//               itemBuilder: (context, index) {
//                 return filter == null || filter == ""
//                     ? _buildProjBox(
//                         chatlist[index],
//                       )
//                     : chatlist[index]
//                                 .name!
//                                 .toLowerCase()
//                                 .contains(filter.toLowerCase()) ||
//                             chatlist[index]
//                                 .name!
//                                 .toLowerCase()
//                                 .contains(filter.toLowerCase())
//                         ? _buildProjBox(
//                             chatlist[index],
//                           )
//                         : Container();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildProjBox(Chatlist doc) {
//     print(doc.massage!);
//     print('000000');
//     return ChatItem(
//       name: doc.name!,
//       image: doc.image!,
//       ontap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ChatRoom(
//                       image: doc.image!,
//                       userId: doc.userId!,
//                       name: doc.name!,
//                     )));
//       },
//       ontapicon: () {},
//       dateTime: doc.time!,
//       lastmassage: doc.massage!,
//     );
//   }
// }
// ignore_for_file: avoid_print

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/screens/chat/chat_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'chat_room.dart';

class ChatScreen extends StatefulWidget{
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
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('member').doc(id)
                    .collection('message')
           .orderBy('timeDate')
                    // .limit(1)
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
                    String lastmassage = message["Text"];

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
                        ontapicon: () async {
                          await showDialogWarning(
                            context,
                            text: 'هل انت متاكد من حذف المحادثة؟',
                            ontap: () async {
                              await FirebaseFirestore.instance
                                  .collection('member').doc(id)
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
                        lastmassage: lastmassage,
                      );

                      messageWidgets.add(messageWidget);

                      messageList.add(message["name"]);
                    }
                  }
                  return Expanded(
                      child:  ListView(
                    padding: const EdgeInsets.all(20),
                    children: messageWidgets,
                  ));
                }),
          ],
        ));
  }
}
