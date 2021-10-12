import 'package:aban/constant/style.dart';
import 'package:aban/screens/bookmark/view.dart';
import 'package:aban/screens/chat/view.dart';
import 'package:aban/screens/help/view.dart';
import 'package:aban/screens/profile/eidt_profile/view.dart';
import 'package:aban/screens/profile/facultymember/profile/view.dart';
import 'package:aban/screens/registration/login_screen/view.dart';
import 'package:flutter/material.dart';
import "package:quds_ui_kit/quds_ui_kit.dart";

  Widget studentDrawer (BuildContext context) {
    return QudsPopupButton(
        // backgroundColor: Colors.red,
        tooltip: 'T',
        items: [
          QudsPopupMenuItem(
              title: null,
              onPressed: () {},
              trailing: Icon(
                Icons.menu,
                color: blue,
              )),
          QudsPopupMenuDivider(color: gray, thickness: .5),

          QudsPopupMenuItem(
              trailing: Icon(
                Icons.info_outline,
                color: blue,
              ),
              title: Align(
                alignment: Alignment.centerRight,
                  child: Text(
                'الملف الشخصي',
              )),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              }),
          QudsPopupMenuDivider(color: gray, thickness: .5),
          QudsPopupMenuItem(
              trailing: Icon(
                Icons.bookmark_border,
                color: blue,
              ),
              title: Align(
                  alignment: Alignment.centerRight,

                  child: Text(
                'المحفوظات',
              )),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => BookmarkScreen()));
              }),
          QudsPopupMenuDivider(color: gray, thickness: .5),

          QudsPopupMenuItem(
              trailing: Icon(
                Icons.chat_bubble_outline_outlined,
                color: blue,
              ),
              title: Align(
                  alignment: Alignment.centerRight,

                  child: Text(
                'المحادثات',
              )),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen()));
              }),
          QudsPopupMenuDivider(color: gray, thickness: .5),

          QudsPopupMenuItem(
              trailing: Icon(
                Icons.settings,
                color: blue,
              ),
              title: Align(
                  alignment: Alignment.centerRight,

                  child: Text(
                'تعديل الملف الشخصي',
              )),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              }),
          QudsPopupMenuDivider(color: gray, thickness: .5),

          QudsPopupMenuItem(
              trailing: Icon(
                Icons.help,
                color: blue,
              ),
              title: Align(
                  alignment: Alignment.centerRight,

                  child: Text(
                'مساعدة',
              )),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpScreen()));
              }),
          QudsPopupMenuDivider(color: gray, thickness: .5),
          QudsPopupMenuItem(
              popOnTap: false,
              trailing: Icon(
                Icons.logout,
                color: blue,
              ),
              title: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                'تسجيل خروج',
              )),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              }),
        ],
        child: Icon(
          Icons.menu,
          size: 33,
          color: white,
        ));
  }


// List<QudsPopupMenuBase> getMenuItems(BuildContext context) {
//   return [
//     QudsPopupMenuItem(
//         leading: Icon(Icons.info_outline),
//         title: Text('Give Feedback'),
//         subTitle: Text('Help us improve our new app'),
//         onPressed: () {
//           Navigator.push(
//               context, MaterialPageRoute(builder: (context) => LoginScreen()));
//         }),
//     QudsPopupMenuDivider(color: black, thickness: 2),
//     QudsPopupMenuSection(
//         leading: Icon(Icons.place),
//         titleText: 'Settings & Privacy',
//         subItems: [
//           QudsPopupMenuItem(
//               leading: Icon(Icons.settings),
//               title: Text('Settings'),
//               onPressed: () {}),
//           QudsPopupMenuItem(
//               leading: Icon(Icons.lock),
//               title: Text('Privacy Checkup'),
//               onPressed: () {}),
//           QudsPopupMenuItem(
//               leading: Icon(Icons.lock_clock),
//               title: Text('Privacy Shortcuts'),
//               onPressed: () {}),
//           QudsPopupMenuItem(
//               leading: Icon(Icons.list),
//               title: Text('Activity Log'),
//               onPressed: () {}),
//           QudsPopupMenuItem(
//               leading: Icon(Icons.card_membership),
//               title: Text('News Feed Preferences'),
//               onPressed: () {}),
//           QudsPopupMenuItem(
//               leading: Icon(Icons.language),
//               title: Text('Language'),
//               onPressed: () {}),
//         ]),
//     QudsPopupMenuDivider(),
//     QudsPopupMenuWidget(
//         builder: (c) => Container(
//             padding: EdgeInsets.all(10),
//             child: IntrinsicHeight(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.favorite,
//                         color: Colors.red,
//                       )),
//                   VerticalDivider(),
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.music_note,
//                         color: Colors.blue,
//                       )),
//                   VerticalDivider(),
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.umbrella,
//                         color: Colors.green,
//                       ))
//                 ],
//               ),
//             )))
//   ];
// }
