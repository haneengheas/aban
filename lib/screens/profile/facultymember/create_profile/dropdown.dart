import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';

class CollegeDropDown extends StatefulWidget {

  const CollegeDropDown({Key? key, this.listData,this.strValue,this.onTap, required this.text}) : super(key: key);

  final List<DropdownMenuItem<String>>? listData;
  final String? strValue;
  final Function? onTap;
  final String text;



  @override
  State<CollegeDropDown> createState() => _CollegeDropDownState();
}

class _CollegeDropDownState extends State<CollegeDropDown> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<String>(
          hint: Text(
           widget.text,
            style: hintStyle,
          ),
          value: widget.strValue == null?null:widget.strValue,
          onChanged: (newValue) {
            // prov.projectStatus = newValue!;
            widget.onTap!(newValue);
          },
        isExpanded: true,
          items: widget.listData,
      ),
    );

  }
}