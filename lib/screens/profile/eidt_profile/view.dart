// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print
import 'dart:io';
import 'dart:math';
import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/profile/eidt_profile/list_project_item.dart';
import 'package:aban/screens/profile/eidt_profile/project_item.dart';
import 'package:aban/screens/profile/eidt_profile/theses_montor_item.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController emailuser = TextEditingController();
  TextEditingController degree = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController faculty = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController link = TextEditingController();
  String? image;
  List? field;
   int? accepted;

  void getData() async {
    DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
        .collection("member")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    debugPrint('userType is ${documentSnapshot2.get('userId')}');
    name.text = documentSnapshot2.get('name');
    faculty.text = documentSnapshot2.get('faculty');
    emailuser.text = FirebaseAuth.instance.currentUser!.email!;
    link.text = documentSnapshot2.get('link');
    phone.text = documentSnapshot2.get('phone');
    degree.text = documentSnapshot2.get('degree');
    id.text = documentSnapshot2.get('id');
    image = documentSnapshot2.get('imageUrl');
    field = documentSnapshot2.get('fields');
    accepted = documentSnapshot2.get('accept');
    print(accepted);

    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var prov = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      prov.fields.clear();
      prov.file = File('');
      setState(() {});
    });
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        title: Text('تعديل ملفك الشخصي',
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
          icon: const Icon(Icons.arrow_back),
          color: blue,
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // widgets for  profile information
              Column(children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          await showBottomSheet(context);
                        },
                        child: Image(
                          image: NetworkImage(image!),
                          height: 80,
                        ),
                      ),
                      SizedBox(
                        width: sizeFromWidth(context, 1.5),
                        child: TextFieldUser(
                          onChanged: (val) {},
                          controller: name,
                          labelText: "اسم الباحث",
                          hintText: "أسمك",
                          scure: false,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'برجاءادخال الاسم بشكل صحيح ';
                            }
                          }, // initialValue: name,
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
                      child: TextFieldUser(
                        onChanged: (val) {},
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'برجاءادخال الكلية ';
                          }
                        },
                        controller: faculty,
                        hintText: "الكلية/التخصص",
                        labelText: "الكلية/التخصص",
                        scure: false,
                        // initialValue: faculty,
                      ),
                    ),
                    SizedBox(
                      width: sizeFromWidth(context, 2),
                      child: TextFieldUser(
                        onChanged: (val) {
                          prov.email = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'برجاءادخال البريد الجامعي بشكل صحيح ';
                          }
                        },
                        controller: emailuser,
                        hintText: "Reasearsh@ksuedu.sa",
                        labelText: "البريد الجامعى",
                        scure: false,
                        // initialValue: emailuser,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: sizeFromWidth(context, 2),
                      child: TextFieldUser(
                        onChanged: (val) {
                          prov.email = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'برجاءادخال الدرجة العملية بشكل صحيح ';
                          }
                        },
                        controller: degree,
                        hintText: "اختر درجتك",
                        labelText: "الدرجة العلمية",
                        scure: false,
                        // initialValue: degree,
                      ),
                    ),
                    SizedBox(
                      width: sizeFromWidth(context, 2),
                      child: TextFieldUser(
                        onChanged: (val) {
                          prov.phone = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'برجاءادخال رقم الهاتف ';
                          }
                        },
                        controller: phone,
                        hintText: "+96655...",
                        labelText: "رقم الهاتف",
                        scure: false,
                        // initialValue: phone,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: sizeFromWidth(context, 2),
                      child: TextFieldUser(
                        onChanged: (val) {
                          prov.id = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'برجاءادخال المعرف الخاص بك ';
                          }
                        },
                        controller: id,
                        hintText: "المعرف الخاص بك",
                        labelText: "orcid iD",
                        scure: false,
                        // initialValue: id,
                      ),
                    ),
                    SizedBox(
                      width: sizeFromWidth(context, 2),
                      child: TextFieldUser(
                        onChanged: (val) {
                          prov.link = val;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'برجاءادخال ادخل رابط GooGel School ';
                          }
                        },
                        controller: link,
                        hintText: "ادخل رابط GooGel School",
                        labelText: " ابحاثى",
                        scure: false,
                        // initialValue: link,
                      ),
                    ),
                  ],
                ),
              ]),
              // accept theses montor
              Column(
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
                          Radio<int>(
                              value:0,
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
                              value:1,
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
              ),
              const Divider(
                height: 10,
                thickness: 1,
                color: lightGray,
              ),
              ListProjectItem(
                fields: field,
              ),
              const Divider(
                height: 10,
                thickness: 1,
                color: lightGray,
              ),
              ThesesGraduatedMontorItem(),
              const Divider(
                height: 20,
                thickness: 1,
                color: lightGray,
              ),
              ProjectItem(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonUser(
                      text: 'حفظ التغيرات',
                      color: blueGradient,
                      onTap: () async {
                        showDialogWarning(context, ontap: () async {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            List<String> fieldsStr = <String>[];

                            for (var element in prov.fields) {
                              fieldsStr.add(element.text);
                            }

                            print('Str list is => $fieldsStr');

                            // await prov.ref.putFile(prov.file!);
                            // prov.imageurl = await prov.ref.getDownloadURL();
                            await FirebaseFirestore.instance
                                .collection('member')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .update({
                              'name': name.text,
                              'accept': prov.accept,
                              'degree': degree.text,
                              'faculty': faculty.text,
                              'id': id.text,
                              'link': link.text,
                              'phone': phone.text,
                              // 'imageUrl': prov.imageurl,
                              'fields': fieldsStr
                            }).then((value) {
                              Navigator.pop(context);
                            });
                          }


                          print(name);
                        }, text: 'هل انت متاكد من حفظ التغييرات ؟');
                      }),
                  ButtonUser(text: 'الغاء', color: redGradient, onTap: () {}),
                ],
              ),
              Center(
                  child: ButtonUser(
                      text: 'حذف الحساب',
                      color: grayGradient,
                      onTap: () {
                        showDialogWarning(context,
                            text: 'هل انت متاكد من حذف الحساب ؟', ontap: () {});
                      }))
            ],
          ),
        )),
      ),
    );
  }
}

showBottomSheet(ctx) {
  return showModalBottomSheet(
      context: ctx,
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
                    var imageName = "$rang" + path.basename(picked.path);
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
                    var imageName = "$rang" + path.basename(picked.path);
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
