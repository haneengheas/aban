import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatefulWidget {
   final String text;
   SearchTextField({
     required this.text,
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
        padding: EdgeInsets.symmetric(horizontal:10),
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: widget.text,
            hintStyle: hintStyle2,
            suffixIcon: Icon(
              Icons.search,
              color: lightBlue,
            ),
            fillColor: clearblue,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: lightGray
              )

            ),
          ),
        ),
      ),
    );
  }
}
