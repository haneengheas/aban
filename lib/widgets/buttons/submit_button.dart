import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';
class SubmitButton extends StatefulWidget {
  final Gradient gradient;
  final String text;
  final Function onTap;
  SubmitButton({
    required this.gradient,
    required this.text,
    required this.onTap,
  });

  @override
  _SubmitButtonState createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.onTap(),
      child: Container(

        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 25,),
        width: sizeFromWidth(context, 1.5),
        height: 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: widget.gradient,

        ),
        child: Align(
          alignment: Alignment.center,
            child: Text( widget.text, style: submitButtonStyle)),
      ),
    );
  }
}
