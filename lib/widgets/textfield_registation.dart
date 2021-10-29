
// ignore_for_file: file_names, use_key_in_widget_constructors

import 'package:aban/constant/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldRegistation extends StatefulWidget {
  final String hintText;
  final String labelText;
  final bool scure;
  final Function(String) onChanged;
  final FormFieldValidator validator;

  const TextFieldRegistation({
    required this.hintText,
    required this.labelText,
    required this.scure,
    required this.onChanged,
    required this.validator,
  });

  @override
  _TextFieldRegistationState createState() => _TextFieldRegistationState();
}

class _TextFieldRegistationState extends State<TextFieldRegistation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextFormField(
          onChanged:
            widget.onChanged,

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
            validator:  widget.validator,
        ),
      ),
    );
  }
}
