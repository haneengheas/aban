import 'package:aban/constant/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldUser extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool scure;
  final Function(String) onChanged;
  final FormFieldValidator   validator;
  final TextEditingController?   controller;

  // ignore: use_key_in_widget_constructors
  const TextFieldUser(
      {required this.hintText,
      required this.labelText, this.controller,
      required this.scure,
      required this.onChanged, required this.validator});

  @override
  _TextFieldUserState createState() => _TextFieldUserState();
}

class _TextFieldUserState extends State<TextFieldUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          onChanged: widget.onChanged,
        validator:  widget.validator,
          controller: widget.controller,
          obscureText: widget.scure,
          decoration: InputDecoration(
            // prefixIcon: Icon(Icons.star,size: 5,color: Colors.red,),
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
