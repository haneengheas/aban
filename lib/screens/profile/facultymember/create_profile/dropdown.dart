import 'package:aban/constant/style.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollegeDropDown extends StatefulWidget {

  CollegeDropDown({this.listData,this.strValue,this.onTap});

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