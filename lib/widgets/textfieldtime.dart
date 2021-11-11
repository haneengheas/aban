// ignore_for_file: use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';

class TimeTextField extends StatefulWidget {
  final String text;
  final Function(String) onChanged;
  final FormFieldValidator   validator;
  final TextEditingController?   controller;
  const TimeTextField({
    required this.text,
    required this.onChanged,
    this.controller,
    required this.validator
  });

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<TimeTextField> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 35,
        width: 100,
        //padding: EdgeInsets.symmetric(horizontal:10),
        margin:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: TextFormField(

          onChanged: widget.onChanged,
          validator:  widget.validator,
          controller: widget.controller,
          decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: hintStyle,




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
