import 'package:flutter/material.dart';
class TimeDropDown extends StatefulWidget {
   TimeDropDown({Key? key,  required this.val}) : super(key: key) ;
  String? val;

  @override
  State<TimeDropDown> createState() => _TimeDropDownState();
}

class _TimeDropDownState extends State<TimeDropDown> {
  @override
  Widget build(BuildContext context) {
    return  DropdownButton<String>(
        value: widget.val,
        onChanged: ( newValue) {

            widget.val = newValue!;
            setState(() { });
        },

        items: <String>[ 'pm', 'am'].map<DropdownMenuItem<String>>
          ((String? value ){
          return DropdownMenuItem<String>(
              value: value,
              child: Text(value!));
        }).toList());
  }
}
