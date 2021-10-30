// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ThesesMontorAccpetItem extends StatefulWidget {
  var accept;
   ThesesMontorAccpetItem({Key? key, required this.accept}) : super(key: key);

  @override
  _ThesesMontorAccpetItemState createState() => _ThesesMontorAccpetItemState();
}

class _ThesesMontorAccpetItemState extends State<ThesesMontorAccpetItem> {
var val;

  @override
  Widget build(BuildContext context) {
   var prov = Provider.of<ProfileProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20,top: 20),
          child: Text(
            "هل تقبل الاشراف على الاطروحات؟",
            style: labelStyle3,
          ),),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 30,
            child: Row(
              children: [
                Radio(
                    value: 1,
                    groupValue: prov.accept,
                    onChanged: (value) {
                      setState(() {
                        prov.accept = value;
                      });
                    }),
                Text('نعم', style: hintStyle3),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 25,
            child: Row(
              children: [
                Radio(
                    value: 2,
                    groupValue: prov.accept,
                    onChanged: (value) {
                      setState(() {
                        prov.accept = value;
                      });
                    }),
                Text(
                  'لا',
                  style: hintStyle3,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
