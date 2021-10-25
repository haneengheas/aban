// ignore_for_file: file_names

import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';
Widget customAppBar(BuildContext context, {required String title}){
  return AppBar(
        backgroundColor: white,
        title: Text(title,
            style: appBarStyle),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:const Icon(
          Icons.arrow_back,
          color: blue,
        ),)
  );
}