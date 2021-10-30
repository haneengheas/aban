// ignore_for_file: avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/screens/resersh_list/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CollegeView extends StatelessWidget {
  const CollegeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<MyModel>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              'الكليات',
              style: bluebold,
            ),
          ),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //childAspectRatio: 1,
                  ),
                  itemCount: prov.departments.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        // prov.departments.map((key, value) => departments(key,value)).toList();
                        // prov.departments.forEach((key, value) {
                        //   print(key.length);
                        //   print(value[index]);
                        // });

                        List<List<String>> department =
                            prov.departments.values.toList();
                        print(department[index]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResershList(
                                    title: colleges[index],
                                    departments: department[index])));
                      },
                      child: Card(
                        color: lightgray,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21)),
                        margin: const EdgeInsets.all(5),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                IconButton(
                                    onPressed: null,
                                    icon: Image(
                                      image: AssetImage(
                                        'assets/${images[index]}.png',
                                      ),
                                      color: blue,
                                      height: 50,
                                    )),
                                Text(
                                  prov.departments.keys.toList()[index],
                                  maxLines: 3,
                                  overflow: TextOverflow.fade,
                                  textAlign: TextAlign.center,
                                  //overflow: TextOverflow.fade,
                                  // textWidthBasis: TextWidthBasis.parent,
                                  style: hintStyle4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

List colleges = [
  'كلية علوم الحاسب والمعلومات',
  'كلية العلوم',
  'كلية علوم الرياضة والنشاط البدني',
  'كلية الهندسة',
  'كلية علوم الأغذية والزراعة',
  'كلية العمارةوالتخطيط',
  'كلية إدارة الأعمال',
  'كليةالتمريض ',
  'كلية الطب',
  'كلية طب الاسنان',
  'كلية الصيدلة',
  'كلية العلوم الطبية التطبيقية',
  'كلية الحقوق',
  'كلية الاداب',
  'كلية التربية',
  'كلية اللغات والترجمة',
  'كلية السياحة والاثار',
  'كلية الدراسات التطبيقة وخدمة المجتمع',
];

List images = [
  'حاسبات',
  'علوم',
  'علوم رياضة',
  'هندسة',
  'علوم اغذية',
  'عمارة',
  'ادارة اعمال',
  'تمريض',
  'طب',
  'طب اسنان',
  'صيدلة',
  'علوم طبية',
  'حقوق',
  'اداب',
  'تربية',
  'لغات',
  'سياحة',
  'دراسات',
];
