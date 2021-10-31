import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AcceptSupervision extends StatefulWidget {
  const AcceptSupervision({Key? key}) : super(key: key);

  @override
  _AcceptSupervisionState createState() => _AcceptSupervisionState();
}

class _AcceptSupervisionState extends State<AcceptSupervision> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 20),
          child: Text(
            "هل تقبل الاشراف على الاطروحات؟",
            style: labelStyle3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 30,
            child: Row(
              children: [
                Radio(
                    value: 0,
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
                    value: 1,
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
