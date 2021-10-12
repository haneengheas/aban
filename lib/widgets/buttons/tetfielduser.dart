import 'package:aban/constant/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldUser extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool scure;

  TextFieldUser({
    required this.hintText,
    required this.labelText,
    required this.scure,
  });

  @override
  _TextFieldUserState createState() => _TextFieldUserState();
}

class _TextFieldUserState extends State<TextFieldUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35,),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
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
