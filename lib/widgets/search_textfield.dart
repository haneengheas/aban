// ignore_for_file: use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
   final String text;
   final TextEditingController? controller;
   const SearchTextField({
     required this.text,
     this.controller,
});

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 40,
        width: sizeFromWidth(context, 1),
        padding:const EdgeInsets.symmetric(horizontal:10),
        margin:const EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: TextFormField(
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: hintStyle2,
            suffixIcon: const Icon(
              Icons.search,
              color: lightBlue,
            ),
            fillColor: clearblue,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                color: lightGray
              )

            ),
          ),
        ),
      ),
    );
  }
}
