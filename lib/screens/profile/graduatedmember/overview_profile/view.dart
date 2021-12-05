// import 'package:aban/constant/style.dart';
// import 'package:aban/screens/chat/view.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class GraduatedProfile extends StatefulWidget {
//   const GraduatedProfile({Key? key}) : super(key: key);
//
//   @override
//   _GraduatedProfileState createState() => _GraduatedProfileState();
// }
//
// class _GraduatedProfileState extends State<GraduatedProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 5,
//       child: Scaffold(
//           backgroundColor: white,
//           appBar: AppBar(
//               backgroundColor: white,
//               title: Text('أسم الباحث',
//                   style: GoogleFonts.cairo(
//                     textStyle:const TextStyle(
//                         color: blue, fontWeight: FontWeight.bold, fontSize: 28),
//                   )),
//               centerTitle: true,
//               elevation: 0,
//               leading: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 icon:const Icon(
//                   Icons.arrow_back,
//                   color: blue,
//                 ),
//               )),
//           body: Directionality(
//             textDirection: TextDirection.rtl,
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Directionality(
//                   textDirection: TextDirection.ltr,
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Directionality(
//                         textDirection: TextDirection.rtl,
//                         child: TextButton.icon(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) =>const ChatScreen()));
//                           },
//                           icon:const Icon(
//                             Icons.chat_rounded,
//                             color: blue,
//                             size: 20,
//                           ),
//                           label: Text(
//                             "محادثة",
//                             style: hintStyle,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Image(
//                               image: AssetImage(
//                                 'assets/user.png',
//                               ),
//                               color: blue,
//                               height: 80,
//                             ),
//                             const  SizedBox(
//                               width: 20,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   "اسم الباحث",
//                                   style: labelStyle2,
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "الكلية/التخصص",
//                                       style: hintStyle,
//                                     ),
//                                     SizedBox(
//                                       width: sizeFromWidth(context, 8),
//                                     ),
//                                     Text(
//                                       "Reasearsh@ksuedu.sa",
//                                       style: hintStyle3,
//                                     ),
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "الدرجة العلمية",
//                                       style: hintStyle,
//                                     ),
//                                     SizedBox(
//                                       width: sizeFromWidth(context, 8),
//                                     ),
//                                     Text(
//                                       "9665000+",
//                                       style: hintStyle,
//                                     ),
//                                   ],
//                                 ),
//                                 Text(
//                                   "rocid ID",
//                                   style: hintStyle,
//                                 ),
//                               ],
//                             ),
//                           ]),
//                       const  SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.check,
//                             color: Colors.green,
//                           ),
//                           Text(
//                             "أقبل الاشراف على الاطروحات ",
//                             style: hintStyle,
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 15),
//                         child: Text("الذهاب الى ابحاثى", style: hintStyle),
//                       ),
//                       SizedBox(
//                         height: MediaQuery.of(context).size.height / 1.7,
//                         child: Column(
//                           children: [
//                             const Divider(
//                               color: gray,
//                               thickness: .5,
//                             ),
//                             SizedBox(
//                               height: 50,
//                               child: (TabBar(
//                                 labelColor: blue,
//                                 unselectedLabelColor: gray,
//                                 labelStyle: hintStyle,
//                                 isScrollable: true,
//                                 tabs: const <Widget>[
//                                   Tab(
//                                     text: 'المجالات',
//                                   ),
//                                   Tab(
//                                     text: 'الاطروحات\nالمكتملة',
//                                   ),
//                                   Tab(
//                                     text: 'الاطروحات \nالجارية',
//                                   ),
//                                   Tab(
//                                     text: 'المشاريع\n المكتملة',
//                                   ),
//                                   Tab(
//                                     text: 'المشاريع \nالجارية',
//                                   )
//                                 ],
//                               )),
//                             ),
//                             const Divider(
//                               color: gray,
//                               thickness: .5,
//                             ),
//                             // const Expanded(
//                             //   child: SizedBox(
//                             //     child: TabBarView(
//                             //       children: [
//                             //          FieldList(),
//                             //         CompeletedTheses(
//                             //           text: 'اطروحة مكتملة تحت اشرافي',
//                             //         ),
//                             //         CompeletedTheses(
//                             //           text: 'اطروحة جارية تحت اشرافي',
//                             //         ),
//                             //         CompletedProject(
//                             //           text: 'اطروحة جارية تحت اشرافي',
//                             //
//                             //         ),
//                             //         CompletedProject(
//                             //           text: 'اطروحة جارية تحت اشرافي',
//                             //
//                             //         ),
//                             //       ],
//                             //     ),
//                             //   ),
//                             // ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           )),
//     );
//   }
// }
