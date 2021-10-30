import 'dart:io';
import 'dart:math';

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({Key? key}) : super(key: key);

  @override
  _ProfileInformationState createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  await showBottomSheet(context);
                },
                child: prov.file!.path == ''
                    ? Image(
                        image: AssetImage(
                          'assets/user.png',
                        ),
                        color: blue,
                        height: 80,
                      )
                    : Image(
                        image: FileImage(
                          prov.file!,
                        ),
                        height: 80,
                      ),
              ),
              SizedBox(
                width: sizeFromWidth(context, 1.5),
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFieldUser(
                      onChanged: (value) {
                        prov.name = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'برجاء ادخال الاسم ';
                        }
                      },
                      labelText: 'اسم الباحث',
                      hintText: 'اسمك ',
                      scure: false,
                    )),
              ),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: sizeFromWidth(context, 2),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFieldUser(
                    onChanged: (value) {
                      prov.faculty = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال الكليه ';
                      }
                    },
                    labelText: 'ادخل كليتك',
                    hintText: 'كليتك ',
                    scure: false,
                  )),
            ),
            SizedBox(
              width: sizeFromWidth(context, 2),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFieldUser(
                    hintText: "Reasearsh@ksuedu.sa",
                    scure: false,
                    labelText: "البريد الجامعى",
                    onChanged: (value) {
                      prov.email = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال البريد الالكتروني ';
                      }
                    },
                  )),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: sizeFromWidth(context, 2),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFieldUser(
                    onChanged: (value) {
                      prov.degree = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال الدرجة العلمية ';
                      }
                    },
                    hintText: "اختر درجتك",
                    labelText: "الدرجة العلمية",
                    scure: false,
                  )),
            ),
            SizedBox(
              width: sizeFromWidth(context, 2),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFieldUser(
                    labelText: 'رقم الهاتف',
                    hintText: 'الهاتف ',
                    onChanged: (value) {
                      prov.phone = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال رقم الهاتف ';
                      }
                    },
                    scure: false,
                  )),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: sizeFromWidth(context, 2),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFieldUser(
                    hintText: "المعرف الخاص بك",
                    labelText: "orcid iD",
                    onChanged: (value) {
                      prov.id = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال المعرف الخاص بك ';
                      }
                    },
                    scure: false,
                  )),
            ),
            SizedBox(
              width: sizeFromWidth(context, 2),
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFieldUser(
                    onChanged: (value) {
                      prov.link = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'برجاءادخال رابط GooGel School ';
                      }
                    },
                    hintText: "ادخل رابط GooGel School",
                    labelText: " ابحاثى",
                    scure: false,
                  )),
            ),
          ],
        ),
      ],
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
                    var imageName = "$rang" + basename(picked.path);
                    prov.ref =
                        FirebaseStorage.instance.ref("images").child(imageName);
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
                    var imageName = "$rang" + basename(picked.path);
                    prov.ref =
                        FirebaseStorage.instance.ref("images").child(imageName);
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
