// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldItem extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool scure;
  final TextEditingController? controller;
// final Function onChanged;
  const TextFieldItem({
    required this.hintText,
    required this.labelText,
    required this.scure,
    this.controller,
   // required this.onChanged
  });

  @override
  _TextFieldItemState createState() => _TextFieldItemState();
}

class _TextFieldItemState extends State<TextFieldItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          controller: widget.controller,
          // onChanged: (value) {
          //   widget.onChanged();
          // } ,
          decoration: InputDecoration(
           // ToDo:
            // شيلت النجمة
            // prefixIcon: Icon(Icons.star),
            labelText: widget.labelText,
            labelStyle: labelStyle,
            hintText: widget.hintText,

            hintStyle: hintStyle,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ),
    );
  }
}
