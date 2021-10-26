// import 'package:aban/constant/style.dart';
// import 'package:aban/widgets/buttons/tetfielduser.dart';
// import 'package:flutter/material.dart';
// class InformationItem extends StatefulWidget {
//   const InformationItem({Key? key}) : super(key: key);
//
//   @override
//   State<InformationItem> createState() => _InformationItemState();
// }
//
// class _InformationItemState extends State<InformationItem> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children:[
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Row(
//             children: [
//               const Image(
//                 image: AssetImage(
//                   'assets/user.png',
//                 ),
//                 color: blue,
//                 height: 80,
//               ),
//               SizedBox(
//                 width: sizeFromWidth(context, 1.5),
//                 child:  TextFieldUser(
//                   onChanged: (){},
//                   labelText: "اسم الباحث",
//                   hintText: "أسمك",
//                   scure: true,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Row(
//           // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             SizedBox(
//               width: sizeFromWidth(context, 2),
//               child:  TextFieldUser(
//                 onChanged: (){},
//
//                 hintText: "الكلية/التخصص",
//                 labelText: "الكلية/التخصص",
//                 scure: true,
//               ),
//             ),
//             SizedBox(
//               width: sizeFromWidth(context, 2),
//               child: TextFieldUser(
//                 onChanged: (){},
//
//                 hintText: "Reasearsh@ksuedu.sa",
//                 labelText: "البريد الجامعى",
//                 scure: true,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             SizedBox(
//               width: sizeFromWidth(context, 2),
//               child: TextFieldUser(
//                 onChanged: (){},
//
//                 hintText: "اختر درجتك",
//                 labelText: "الدرجة العلمية",
//                 scure: true,
//               ),
//             ),
//             SizedBox(
//               width: sizeFromWidth(context, 2),
//               child: TextFieldUser(
//                 onChanged: (){},
//                 hintText: "+96655...",
//                 labelText: "رقم الهاتف",
//                 scure: true,
//               ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             SizedBox(
//               width: sizeFromWidth(context, 2),
//               child:  TextFieldUser(
//                 onChanged: (){},
//
//                 hintText: "المعرف الخاص بك",
//                 labelText: "orcid iD",
//                 scure: true,
//               ),
//             ),
//             SizedBox(
//               width: sizeFromWidth(context, 2),
//               child: TextFieldUser(
//                 onChanged: (){},
//
//                 hintText: "ادخل رابط GooGel School",
//                 labelText: " ابحاثى",
//                 scure: true,
//               ),
//             ),
//           ],
//         ),
//
//
//       ]
//
//     );
//   }
// }
