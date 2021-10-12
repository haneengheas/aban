import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';
class ThesesMontorAccpetItem extends StatefulWidget {
  @override
  _ThesesMontorAccpetItemState createState() => _ThesesMontorAccpetItemState();
}

class _ThesesMontorAccpetItemState extends State<ThesesMontorAccpetItem> {
var val;

  @override
  Widget build(BuildContext context) {
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
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
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
                    groupValue: val,
                    onChanged: (value) {
                      setState(() {
                        val = value;
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
