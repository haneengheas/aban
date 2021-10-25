import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:flutter/material.dart';

class ProjectItem extends StatelessWidget {
  const ProjectItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            "المشاريع:",
            style: labelStyle3,
          ),
        ),
        Row(
          children: [
            Container(
              margin:const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              width: 280,
              height: 100,
              decoration: BoxDecoration(
                color: clearblue,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  children: [
                    Padding(
                      padding:
                         const  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'اسم المشروع',
                            style: hintStyle4,
                          ),
                          Text(
                            'القائد:اسم القائد',
                            style: hintStyle5,
                          ),
                          Text(
                            'الاعضاء:اسماء الاعضاء',
                            style: hintStyle5,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 30,
              child: IconButton(
                onPressed: () {
                  showDialogProject(context,text: 'تعديل مشروع');
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
                icon: const Icon(Icons.delete),
                color: Colors.red,
                iconSize: 20,
              ),
            ),
          ],
        ),
        ButtonUser(text:"اضافة مشروع",color: blueGradient,onTap: (){
          showDialogProject(context,text: 'إضافة مشروع');

        }),
      ],
    );
  }
}
