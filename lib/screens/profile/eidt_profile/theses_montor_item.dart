import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ThesesGraduatedMontorItem extends StatefulWidget {
  const ThesesGraduatedMontorItem({Key? key}) : super(key: key);

  @override
  _ThesesGraduatedMontorItemState createState() =>
      _ThesesGraduatedMontorItemState();
}

class _ThesesGraduatedMontorItemState extends State<ThesesGraduatedMontorItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "اطروحات تحت اشرافك :",
            style: labelStyle3,
          ),
        ),
        Row(
        children: [
          Container(
           padding:const EdgeInsets.symmetric(horizontal: 5),
           margin:const EdgeInsets.symmetric(horizontal: 10),
            width:sizeFromWidth(context, 1.3),
            height: 100,
            decoration: BoxDecoration(
              color: clearblue,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'اسم الاطروحة',
                        style: hintStyle5,
                      ),
                      Text(
                        'المشرف:اسم المشرف',
                        style: hintStyle5,
                      ),
                      Text(
                        'المشرفون المساعدون:اسماءالمشرفين',
                        style: hintStyle5,
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: gray,
                    endIndent: 10,
                    indent: 10,
                    // width: 1,
                    thickness: 2,
                  ),
                  Text(
                    '  دكتوراه  ',
                    style: hintStyle5,
                  ),
                ],
              ),
            ),
          ),

            Row(
              children: [
                SizedBox(
                  width: 30,
                  child: IconButton(
                    onPressed: () {
                      showDialogTheses(context, text: 'تعديل اطروحة');
                    },
                    icon: const Icon(Icons.edit),
                    color: blue,
                    iconSize: 20,
                  ),
                ),
                  SizedBox(
                  width: 30,
                  child: IconButton(
                    onPressed: () {},
                    icon:const Icon(Icons.delete),
                    color: Colors.red,
                    iconSize: 20,
                  ),
                )
              ],
            )
          ],
        ),
        ButtonUser(
            text: "اضافة اطروحة",
            color: blueGradient,
            onTap: () {
              showDialogTheses(context, text: 'إضافة اطروحة');
            }),
      ],
    );
  }
}

