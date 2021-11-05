import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';

class CollegeDropDown extends StatefulWidget {

  const CollegeDropDown({Key? key, this.listData,this.strValue,this.onTap}) : super(key: key);

  final List<DropdownMenuItem<String>>? listData;
  final String? strValue;
  final Function? onTap;



  @override
  State<CollegeDropDown> createState() => _CollegeDropDownState();
}

class _CollegeDropDownState extends State<CollegeDropDown> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButton<String>(
          hint: Text(
            'اختر قسمك',
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