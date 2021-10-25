// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

class CreateGraduatedProfile extends StatefulWidget {
  final int value;

  const CreateGraduatedProfile({Key? key,
    required this.value,
  }) : super(key: key);

  @override
  _CreateGraduatedProfileState createState() => _CreateGraduatedProfileState();
}

class _CreateGraduatedProfileState extends State<CreateGraduatedProfile> {
  var fields = <TextEditingController>[];
  var cards = <Card>[];
  Card createCard() {
    var textController = TextEditingController();
    fields.add(textController);
    return Card(
      margin:const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "المجال ${cards.length + 1}",
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }
  var val;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: customAppBar(context, title: 'إنشىء ملفك الشخصي')),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Image(
                    image:  AssetImage(
                      'assets/user.png',
                    ),
                    color: blue,
                    height: 80,
                  ),
                  SizedBox(
                    width: sizeFromWidth(context, 1.5),
                    child: const TextFieldUser(
                      labelText: "اسم الباحث",
                      hintText: "أسمك",
                      scure: true,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child:const TextFieldUser(
                    hintText: "الكلية/التخصص",
                    labelText: "الكلية/التخصص",
                    scure: true,
                  ),
                ),
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child:const TextFieldUser(
                    hintText: "Reasearsh@ksuedu.sa",
                    labelText: "البريد الجامعى",
                    scure: true,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child:const TextFieldUser(
                    hintText: "اختر درجتك",
                    labelText: "الدرجة العلمية",
                    scure: true,
                  ),
                ),
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child:const TextFieldUser(
                    hintText: "+96655...",
                    labelText: "رقم الهاتف",
                    scure: true,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child:const TextFieldUser(
                    hintText: "المعرف الخاص بك",
                    labelText: "orcid iD",
                    scure: true,
                  ),
                ),
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child:const TextFieldUser(
                    hintText: "ادخل رابط GooGel School",
                    labelText: " ابحاثى",
                    scure: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 10,
              thickness: 1,
              color: lightGray,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text(
                'المجالات',
                style: labelStyle3,
              ),
            ),
            SizedBox(
              height: 50,
              width: 300,
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return cards[index];
                },
              ),
            ),
            TextButton.icon(
                onPressed: () => setState(() => cards.add(createCard())),
                icon:const Icon(Icons.add_circle_outline,color: black,size: 20,),
                label: Text('اضافة مجال',style: hintStyle4,)),
            const Divider(
              height: 10,
              thickness: 1,
              color: lightGray,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                "اطروحات تحت اشرافك :",
                style: labelStyle3,
              ),
            ),
            ButtonUser(
                text: "اضافة اطروحة",
                color: blueGradient,
                onTap: () {
                  showDialogTheses(context, text: 'إضافة اطروحة');
                }),
            const Divider(
              height: 30,
              thickness: 1,
              color: lightGray,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "المشاريع:",
                style: labelStyle3,
              ),
            ),
            ButtonUser(
                text: "اضافة مشروع",
                color: blueGradient,
                onTap: () {
                  showDialogProject(context, text: 'إضافة مشروع');
                }),
            Center(
              child: SubmitButton(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationFile(
                                d: studentDrawer(context),
                                title: 'مرحبا"اسم الباحث"',
                                counter: 1,
                              )));
                },
                text: "حفظ",
                gradient: blueGradient,
              ),
            )
          ],
        )),
      ),
    );
  }
}
