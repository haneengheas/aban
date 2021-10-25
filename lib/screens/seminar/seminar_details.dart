import 'package:aban/constant/style.dart';
import 'package:aban/screens/seminar/edit_seminar.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeminarDetails extends StatelessWidget {
  const SeminarDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: customAppBar(context, title: 'ندوة'),
          preferredSize: const Size.fromHeight(50)),
      body: Column(
        children: [
          Container(
            height: 240,
            width: sizeFromWidth(context, 1),
            margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            decoration: BoxDecoration(
              color: clearblue,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: clearblue),
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text(
                                'اسم الندوة',
                                style: labelStyle3,
                              ),
                              SizedBox(
                                width: sizeFromWidth(context, 5),
                              ),
                              Text(
                                '24 ابريل2021',
                                style: hintStyle3,
                              ),
                              const Icon(
                                Icons.date_range,
                                color: blue,
                                size: 20,
                              )
                            ],
                          ),
                          Text(
                            '8:00-8:30pm',
                            style: hintStyle3,
                          ),
                          Text(
                            'اسم الباحث',
                            style: hintStyle3,
                          ),
                          Text(
                            'منبي 6 الدور الاول قاعة 23',
                            style: hintStyle3,
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        color: gray,
                        endIndent: 10,
                        indent: 10,
                        width: 5,
                        thickness: 2,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'عامة',
                              style: labelStyle3,
                            ),
                            Container(
                              height: 30,
                              width: 20,
                              margin:const EdgeInsets.symmetric(vertical: 10),
                              child:const ImageIcon(
                                AssetImage(
                                  'assets/bookmark (2).png',
                                ),
                                color: blue,
                              ),
                            ),
                          ]),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'وصف الندوة',
                    style: labelStyle3,
                  ),
                  Text(
                    'ندوة تتحدث عن اهمبه ترشيد المياة و خطورة نقص المياة علي البشرية ',
                    style: hintStyle3,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EditSeminar()));
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.edit,
                          color: blue,
                          size: 15,
                        ),
                        Text(
                          'تعديل ندوة',
                          style: hintStyle3,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
