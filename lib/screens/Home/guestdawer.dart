import 'package:aban/constant/style.dart';
import 'package:aban/screens/help/view.dart';
import 'package:aban/screens/registration/login_screen/view.dart';
import 'package:aban/screens/registration/regist_screen/view.dart';
import 'package:flutter/material.dart';
import 'package:quds_ui_kit/screens/quds_popup_menu.dart';
  Widget  guestDrawer (BuildContext context) {
    return QudsPopupButton(
      // backgroundColor: Colors.red,
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
              trailing: const Icon(Icons.login,color: blue,),
              title: const Align(
                alignment: Alignment.centerRight,
                  child: Text('تسجيل جديد',)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>const LoginScreen()));
              }),
          QudsPopupMenuDivider(color: gray, thickness: .5),

          QudsPopupMenuItem(popOnTap: false,
              trailing: const Icon(Icons.logout,color: blue,),
              title: const Align(
                  alignment: Alignment.centerRight,
                  child: Text('تسجيل خروج',)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>const RegistScreen()));              }),
          QudsPopupMenuDivider(color: gray, thickness: .5),
          QudsPopupMenuItem(
              trailing: const Icon(Icons.help,color: blue,),
              title: const Align(
                  alignment: Alignment.centerRight,
                  child: Text('مساعدة',)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HelpScreen()));
              }),

        ],
        child: const Icon(Icons.menu,size: 33,));
  }

