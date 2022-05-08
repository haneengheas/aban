import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/screens/bookmark/view.dart';
import 'package:aban/screens/chat/view.dart';
import 'package:aban/screens/help/view.dart';
import 'package:aban/screens/profile/eidt_profile/view.dart';
import 'package:aban/screens/profile/profile/view.dart';
import 'package:aban/screens/registration/regist_screen/view.dart';
import 'package:aban/screens/supervision/graduated/view.dart';
import 'package:aban/screens/supervision/member/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:quds_ui_kit/quds_ui_kit.dart";

Widget studentDrawer(BuildContext context) {
  var prov = Provider.of<AuthProvider>(context);
  return QudsPopupButton(
      tooltip: 'T',
      items: [
        QudsPopupMenuItem(
            title: null,
            onPressed: () {},
            trailing: const Icon(
              Icons.menu,
              color: blue,
            )),
        QudsPopupMenuDivider(color: gray, thickness: .5),
        QudsPopupMenuItem(
            trailing: const Icon(
              Icons.info_outline,
              color: blue,
            ),
            title: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الملف الشخصي',
                )),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            }),
        QudsPopupMenuDivider(color: gray, thickness: .5),
        QudsPopupMenuItem(
            trailing: const Icon(
              Icons.bookmark_border,
              color: blue,
            ),
            title: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'المحفوظات',
                )),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  const BookmarkScreen()));
            }),
        QudsPopupMenuDivider(color: gray, thickness: .5),
        QudsPopupMenuItem(
            trailing: const Icon(
              Icons.chat_bubble_outline_outlined,
              color: blue,
            ),
            title: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'المحادثات',
                )),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()));
            }),
        QudsPopupMenuDivider(color: gray, thickness: .5),
        QudsPopupMenuItem(
            trailing: const Icon(
              Icons.settings,
              color: blue,
            ),
            title: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'تعديل الملف الشخصي',
                )),
            onPressed: () async {
              // await prov.getData();
              // print('------------');
              // print(prov.email);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EditProfile()));
            }),
        QudsPopupMenuDivider(color: gray, thickness: .5),
        QudsPopupMenuItem(
            trailing: const Icon(
              Icons.help,
              color: blue,
            ),
            title: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'مساعدة',
                )),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()));
            }),
        QudsPopupMenuDivider(color: gray, thickness: .5),
         QudsPopupMenuItem(
                trailing: const Icon(
                  Icons.supervised_user_circle,
                  color: blue,
                ),
                title: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'طلبات الاشراف',
                    )),
                onPressed: () {
                  if(prov.usertype == 0){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>const SupervisionMember()));
                  }
                  else if (prov.usertype == 1){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>const SuperGraduated()));
                  }

                }),

        QudsPopupMenuDivider(color: gray, thickness: .5),
        QudsPopupMenuItem(
            popOnTap: false,
            trailing: const Icon(
              Icons.logout,
              color: blue,
            ),
            title: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'تسجيل خروج',
                )),
            onPressed: ()async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).popUntil((route) => route.isFirst);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistScreen()));
            }),
      ],
      child: const Icon(
        Icons.menu,
        size: 33,
        color: white,
      ));
}

