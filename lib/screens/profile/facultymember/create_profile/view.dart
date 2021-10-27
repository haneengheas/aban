// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print
import 'dart:io';
import 'dart:math';
import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class CreateMemberProfile extends StatefulWidget {

  const CreateMemberProfile({
    Key? key,
  }) : super(key: key);

  @override
  _CreateMemberProfileState createState() => _CreateMemberProfileState();
}

class _CreateMemberProfileState extends State<CreateMemberProfile> {
  
  getusers()async{
    var x= await FirebaseFirestore.instance.collection('member').doc().get();
   print(x);
  }
  @override
  void initState(){
    print('----------------------------------------------------');
    getusers();
    print('----------------------------------------------------');

    super.initState();
  }
  var fields =[];
  var cards = <Card>[];
  var text;
  var textController = TextEditingController();
  Card createCard() {
    fields.add(textController);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          decoration: InputDecoration(
              hintText: "المجال ${cards.length + 1}",
              floatingLabelBehavior: FloatingLabelBehavior.always),
        ),
      ),
    );
  }


  // late String name;
  // late String fuclty;
  // late String phone;

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: white,
          title: Text('إنشىء ملفك الشخصي',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                    color: blue, fontWeight: FontWeight.bold, fontSize: 28),
              )),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: blue,
            ),
          )),
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
                  InkWell(
                    onTap: () async {
                      await showBottomSheet(context);
                    },
                    child: const Image(
                      image: AssetImage(
                        'assets/user.png',
                      ),
                      color: blue,
                      height: 80,
                    ),
                  ),
                  SizedBox(
                    width: sizeFromWidth(context, 1.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 35,
                      ),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          onChanged: (value) {
                            prov.name = value;
                          },
                          decoration: InputDecoration(
                            labelText: 'اسم الباحث',
                            labelStyle: labelStyle,
                            hintText: 'اسمك ',
                            hintStyle: hintStyle,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                      ),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onChanged: (value) {
                          prov.faculty = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'ادخل كليتك',
                          labelStyle: labelStyle,
                          hintText: 'كليتك ',
                          hintStyle: hintStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onChanged: (value) {
                          prov.email = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Reasearsh@ksuedu.sa",
                          labelText: "البريد الجامعى",
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onChanged: (value) {
                          prov.degree = value;
                        },
                        decoration: InputDecoration(
                          hintText: "اختر درجتك",
                          labelText: "الدرجة العلمية",
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onChanged: (value) {
                          prov.phone = value;
                        },
                        decoration: InputDecoration(
                          labelText: 'رقم الهاتف',
                          hintText: 'الهاتف ',
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onChanged: (value) {
                          prov.id = value;
                        },
                        decoration: InputDecoration(
                          hintText: "المعرف الخاص بك",
                          labelText: "orcid iD",
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: sizeFromWidth(context, 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 35,
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onChanged: (value) {
                          prov.link = value;
                        },
                        decoration: InputDecoration(
                          hintText: "ادخل رابط GooGel School",
                          labelText: " ابحاثى",
                          labelStyle: labelStyle,
                          hintStyle: hintStyle,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
            const Divider(
              height: 10,
              thickness: 1,
              color: lightGray,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'المجالات',
                style: labelStyle3,
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (BuildContext context, int index) {
                  return cards[index];
                },
              ),
            ),
            TextButton.icon(
                onPressed: () => setState(() => cards.add(createCard())),
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: black,
                  size: 20,
                ),
                label: Text(
                  'اضافة مجال',
                  style: hintStyle4,
                )),
            const Divider(
              height: 10,
              thickness: 1,
              color: lightGray,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                "اطروحات تحت اشرافك :",
                style: labelStyle3,
              ),
            ),
            ButtonUser(
                text: "اضافة اطروحة",
                color: blueGradient,
                onTap: () {
                  showDialogTheses(context, text: 'اضافة اطروحة');
                }),
            const Divider(
              height: 20,
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
                  // showDialogProject(context, text: 'إضافة مشروع');
                }),
            Center(
              child: SubmitButton(
                onTap: () async {
                  fields.forEach((element) {
                    print(element.toString());
                  });
                  // print (prov.accept);
                  print('=====/==========================/==');
                  // showLoading(context);
                  await prov.addData(
                      faculty: prov.faculty,
                      degree: prov.degree,
                      // file: prov.file,
                      id: prov.id,
                      accept: prov.accept,
                      // fields: fields,
                      // imageUrl: prov.imageurl,
                      name: prov.name,
                      phone: prov.phone,
                      link: prov.link,);
                      // ref: prov.ref);

                  print('==========================');
                  Navigator.pushReplacement(
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

showBottomSheet(context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        var prov = Provider.of<ProfileProvider>(context);
        return Container(
          padding: const EdgeInsets.all(20),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Please Choose Image",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  var picked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    prov.file = File(picked.path);
                    var rang = Random().nextInt(100000);
                    var imagename = "$rang" + basename(picked.path);
                    prov.ref =
                        FirebaseStorage.instance.ref("images").child(imagename);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.photo_outlined,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "From Gallery",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )),
              ),
              InkWell(
                onTap: () async {
                  var picked =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (picked != null) {
                    prov.file = File(picked.path);
                    var rang = Random().nextInt(100000);
                    var imagename = "$rang" + basename(picked.path);
                    prov.ref =
                        FirebaseStorage.instance.ref("images").child(imagename);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera,
                          size: 30,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "From Camera",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )),
              ),
            ],
          ),
        );
      });
}
