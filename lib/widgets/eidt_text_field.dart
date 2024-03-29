import 'package:aban/constant/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EidtTextFieldUser extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool scure;
  final Function(String) ?onChanged;
  final FormFieldValidator   validator;
  final String ?initialValue;
  final TextEditingController ?controller;

  // ignore: use_key_in_widget_constructors
  const EidtTextFieldUser(

      {required this.hintText,
        required this.labelText,
        required this.scure,
         this.onChanged,
         this.initialValue,
        required this.validator,
        this.controller,
      });

  @override
  _EidtTextFieldUserState createState() => _EidtTextFieldUserState();
}

class _EidtTextFieldUserState extends State<EidtTextFieldUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 35,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          initialValue: widget.initialValue,
          onChanged: widget.onChanged,
          validator:  widget.validator,
          obscureText: widget.scure,
          controller: widget.controller,
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
