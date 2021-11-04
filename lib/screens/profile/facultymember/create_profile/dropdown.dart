import 'package:aban/constant/style.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollegeDropDown extends StatefulWidget {
  final int item;

  const CollegeDropDown({required this.item});


  @override
  State<CollegeDropDown> createState() => _CollegeDropDownState();
}

class _CollegeDropDownState extends State<CollegeDropDown> {

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    var providers = Provider.of<MyModel>(context);
    List<List<String>> _department =
    providers.departments.values.toList();
    return DropdownButton<String>(
        hint: Text(
          'اختر قسمك',
          style: hintStyle,
        ),
        value: prov.projectStatus,
        underline: Container(
          width: 30,
          padding:
          const EdgeInsets.symmetric(horizontal: 10),
          height: 1,
          decoration: const BoxDecoration(
              color: gray,
              boxShadow: [
                BoxShadow(
                  color: blue,
                )
              ]),

        ),
        onChanged: (newValue) {
          prov.projectStatus = newValue!;
        },
        items: widget.item==0?
      providers.departments.keys.toList().map((e) =>
          DropdownMenuItem<String>(
            child: Text(e), value: e,)).toList():
        providers.departments.keys.toList().map((String item) =>
            DropdownMenuItem<String>(child: Text(item), value: item))
            .toList(),

    );


  }
}