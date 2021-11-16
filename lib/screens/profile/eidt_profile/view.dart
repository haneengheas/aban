// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print
import 'dart:io';
import 'dart:math';

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/profile/eidt_profile/list_project_item.dart';
import 'package:aban/screens/profile/eidt_profile/project_item.dart';
import 'package:aban/screens/profile/eidt_profile/theses_montor_item.dart';
import 'package:aban/screens/profile/facultymember/create_profile/dropdown.dart';
import 'package:aban/screens/profile/profile/view.dart';
import 'package:aban/screens/registration/regist_screen/view.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key? key}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController emailuser = TextEditingController();
  String? degree;
  TextEditingController phone = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController link = TextEditingController();
  String? image;
  List? field = [];
  int? accepted;
  File? file = File('');
  Reference? ref;
  String? college;
  String? department;

  List<String> selectedDepartment = <String>[];

  getData() async {
    DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
        .collection("member")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    debugPrint('userType is ${documentSnapshot2.get('userId')}');
    name.text = documentSnapshot2.get('name');
    college = documentSnapshot2.get('faculty');
    emailuser.text = FirebaseAuth.instance.currentUser!.email!;
    link.text = documentSnapshot2.get('link');
    phone.text = documentSnapshot2.get('phone');
    degree = documentSnapshot2.get('degree');
    id.text = documentSnapshot2.get('id');
    image = documentSnapshot2.get('imageUrl');
    field = documentSnapshot2.get('fields');
    accepted = documentSnapshot2.get('accept');
    department = documentSnapshot2.get('department');
    print(accepted);

    setState(() {});
  }

  @override
  void initState() {
    var prov;
    Future.delayed(Duration.zero, () async {
      prov = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      prov.fields.clear();
      prov.file = File('');

      await getData();
      for (var f in field!) {
        prov.fields.add(TextEditingController(text: f));
      }
      print(prov.fields);
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    var providers = Provider.of<MyModel>(context);
    var provAuth = Provider.of<AuthProvider>(context);
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
                      // widget for image
                      InkWell(
                          onTap: () async {
                            await showBottomSheet(context);
                          },
                          child: image == null
                              ? const SizedBox()
                              : CircleAvatar(
                                  radius: 35,
                                  backgroundImage: NetworkImage(image!),
                                )),
                      // widget for name user
                      SizedBox(
                        width: sizeFromWidth(context, 1.5),
                        child: TextFieldUser(
                          labelText: "اسم الباحث",
                          hintText: "أسمك",
                          scure: false,
                          onChanged: (val) {},
                          controller: name,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'يجب ادخال اسم الباحث';
                            } else if (value.length < 2) {
                              return 'يجب ان يحتوي الاسم علي ثلاث حروف علي الاقل';
                            }
                            return null;
                          }, // initialValue: name,
                        ),
                      ),
                    ],
                  ),
                ),
                // college and department widget
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: sizeFromWidth(context, 2.3),
                      height: 70,
                      child: CollegeDropDown(
                        strValue: college == '' ? null : college,
                        onTap: (v) {
                          college = v;
                          department = '';
                          selectedDepartment = providers.departments[college]!;
                          setState(() {});
                        },
                        listData: providers.departments.keys
                            .toList()
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        text: college ?? "",
                      ),
                    ),
                    SizedBox(
                      width: sizeFromWidth(context, 2.3),
                      height: 70,
                      child: CollegeDropDown(
                        strValue: department == '' ? null : department,
                        onTap: (v) {
                          department = v;
                          setState(() {});
                        },
                        listData: selectedDepartment
                            .toList()
                            .map((e) => DropdownMenuItem(
                                  child: Text(e),
                                  value: e,
                                ))
                            .toList(),
                        text: department ?? "",
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // widget of degree
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 15),
                          child: Text(
                            'الدرجة العلمية ',
                            style: labelStyle3,
                          ),
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            width: sizeFromWidth(context, 2.4),
                            height: 50,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              hint: Text(
                                degree ?? "",
                                style: hintStyle,
                              ),
                              value: prov.degree,
                              underline: Container(
                                width: 20,
                                height: 1,
                                decoration: const BoxDecoration(
                                    color: lightGray,
                                    boxShadow: [
                                      BoxShadow(
                                        color: blue,
                                      )
                                    ]),
                              ),
                              onChanged: (newValue) {
                                prov.degree = newValue!;
                              },
                              items: <String>[
                                'دكتوراه',
                                'ماجستير',
                                'طالب'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: sizeFromWidth(context, 8),
                                    height: 50,
                                    // for example
                                    child:
                                        Text(value, textAlign: TextAlign.right),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // widget of number
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
                // widget of email and link
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
                            return 'برجاءادخال البريد الجامعي بشكل صحيح ';
                          }
                        },
                        controller: emailuser,
                        hintText: "Reasearsh@ksuedu.sa",
                        labelText: "البريد الجامعى",
                        scure: false,
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
                // widget of oricd id
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
                  ],
                ),
              ]),
              // accept theses montor
              provAuth.usertype== 0?Column(
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
                              groupValue: accepted,
                              onChanged: (value) {
                                setState(() {
                                  accepted = value as int?;
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
                              groupValue:accepted,
                              onChanged: (value) {
                                setState(() {
                                  accepted = value as int?;
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
              ):SizedBox(),
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
              const ThesesGraduatedMontorItem(),
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
                          print('hhhhhhhh');
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            List<String> fieldsStr = <String>[];

                            for (var element in prov.fields) {
                              fieldsStr.add(element.text);
                            }

                            print('Str list is => $fieldsStr');

                           if(provAuth.usertype== 0){
                             await FirebaseFirestore.instance
                                 .collection('member')
                                 .doc(FirebaseAuth.instance.currentUser!.uid)
                                 .update({
                               'name': name.text,
                               'accept':accepted,
                               'degree': degree,
                               'faculty': college,
                               'department': department,
                               'id': id.text,
                               'link': link.text,
                               'phone': phone.text,
                               'email':emailuser.text,
                               // 'imageUrl': imageUrl,
                               'fields': fieldsStr
                             }).then((value) async {
                               Navigator.pop(context);
                               await AwesomeDialog(
                                   context: context,
                                   title: "هام",
                                   body:
                                   const Text("تمت عملية التعديل بنجاح"),
                                   dialogType: DialogType.SUCCES)
                                   .show();
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));

                             });
                           }
                           else{
                             await FirebaseFirestore.instance
                                 .collection('member')
                                 .doc(FirebaseAuth.instance.currentUser!.uid)
                                 .update({
                               'name': name.text,
                               'accept':2,
                               'degree': degree,
                               'faculty': college,
                               'department': department,
                               'id': id.text,
                               'link': link.text,
                               'phone': phone.text,
                               'email':emailuser.text,
                               // 'imageUrl': imageUrl,
                               'fields': fieldsStr
                             }).then((value) async{
                               Navigator.pop(context);
                               await AwesomeDialog(
                                   context: context,
                                   title: "هام",
                                   body:
                                   const Text("تمت عملية التعديل بنجاح"),
                                   dialogType: DialogType.SUCCES)
                                   .show();
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));

                             });
                           }
                          }

                          print(name);
                        }, text: 'هل انت متاكد من حفظ التغييرات ؟');
                      }),
                  ButtonUser(
                      text: 'الغاء',
                      color: redGradient,
                      onTap: () {
                        print(provAuth.usertype);
                        Navigator.pop(context);
                      }),
                ],
              ),
              Center(
                  child: ButtonUser(
                      text: 'حذف الحساب',
                      color: grayGradient,
                      onTap: () {
                        showDialogWarning(context,
                            text: 'هل انت متاكد من حذف الحساب ؟',
                            ontap: () async {
                          await FirebaseFirestore.instance
                              .collection('member')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .delete();
                          await FirebaseFirestore.instance
                              .collection('user')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .delete();
                          await FirebaseAuth.instance.currentUser!.delete();

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegistScreen()));
                        });
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
