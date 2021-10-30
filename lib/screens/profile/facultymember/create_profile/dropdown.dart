import 'package:aban/constant/style.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CollegeDropDown extends StatelessWidget {
  const CollegeDropDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    var providers = Provider.of<MyModel>(context);
    return DropdownButton<String>(
        hint: Text(
          'اختر حالة المشروع',
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
        items: providers.departments.keys.toList().map((e) => DropdownMenuItem<String>(child: Text(e),value: e,)).toList());
  }
}