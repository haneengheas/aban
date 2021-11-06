// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';
import 'dart:math';

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/profile/facultymember/create_profile/accept_supervision.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
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

import 'dropdown.dart';

class CreateMemberProfile extends StatefulWidget {
  const CreateMemberProfile({
    Key? key,
  }) : super(key: key);

  @override
  _CreateMemberProfileState createState() => _CreateMemberProfileState();
}

class _CreateMemberProfileState extends State<CreateMemberProfile> {
  var cards = <Card>[];
  var text;
  var name;
  String college = '';
  String department = '';

  List<String> selectedDepartment = <String>[];
  List<String> selectedDegree = <String>['دكتوراة'];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  getData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    debugPrint('userName is ${documentSnapshot.get('username')}');
    // name = documentSnapshot.get('username');
    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var prov = Provider.of<ProfileProvider>(context, listen: false);
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
    var providers = Provider.of<MyModel>(context);
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
            child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // widget for user information example( name , phone)
              // const ProfileInformation(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                            await showBottomSheet(context);
                          },
                          child: prov.file!.path == ''
                              ? const Image(
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: sizeFromWidth(context, 2.3),
                        height: 70,
                        child: CollegeDropDown(
                          strValue: this.college == '' ? null : this.college,
                          onTap: (v) {
                            college = v;
                            department = '';
                            selectedDepartment =
                                providers.departments[college]!;
                            setState(() {});
                          },
                          listData: providers.departments.keys
                              .toList()
                              .map((e) => DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  ))
                              .toList(),
                          text: 'اختر كليتك',
                        ),
                      ),
                      SizedBox(
                        width: sizeFromWidth(context, 2.3),
                        height: 70,
                        child: CollegeDropDown(
                          strValue:
                              this.department == '' ? null : this.department,
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
                          text: 'اختر قسمك',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                            child: Text(
                              'حالة المشروع',
                              style: labelStyle3,
                            ),
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              width: 170,
                              height: 30,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButton<String>(
                                hint: Text(
                                  'ادخل الدرجة العلمية',
                                  style: hintStyle,
                                ),
                                value: prov.degree,
                                underline: Container(
                                  width: 20,

                                  height: .5,
                                  decoration: const BoxDecoration(
                                      color: gray,
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
                                  'ماجستير'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: SizedBox(
                                      width: sizeFromWidth(context, 6),
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
                              hintText: "Reasearsh@ksuedu.sa",
                              labelText: "بريدك الجامعي",
                              onChanged: (value) {
                                prov.id = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'برجاءادخال بريدك الجامعي ';
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
                  SizedBox(
                    width: sizeFromWidth(context, 2),
                    child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFieldUser(
                          hintText: "المعرف الخاص بك",
                          labelText: "orcid iD",
                          onChanged: (value) {
                            prov.email = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'برجاءادخال المعرف الخاص بك ';
                            }
                          },
                          scure: false,
                        )),
                  ),
                ],
              ),
              // widget for accept supervision
              const AcceptSupervision(),
              const Divider(
                height: 10,
                thickness: 1,
                color: lightGray,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  'المجالات',
                  style: labelStyle3,
                ),
              ),
              Column(
                children: prov.fields
                    .map((e) => Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: e,
                              decoration: InputDecoration(
                                  hintText: "المجال ${cards.length + 1}",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              TextButton.icon(
                  onPressed: () =>
                      setState(() => prov.fields.add(TextEditingController())),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "اطروحات تحت اشرافك :",
                  style: labelStyle3,
                ),
              ),
              ButtonUser(
                  text: "اضافة اطروحة",
                  color: blueGradient,
                  onTap: () {
                    showDialogTheses(
                      context,
                      text: 'اضافة اطروحة',
                    );
                  }),
              const Divider(
                height: 20,
                thickness: 1,
                color: lightGray,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  "المشاريع:",
                  style: labelStyle3,
                ),
              ),
              ButtonUser(
                  text: "اضافة مشروع",
                  color: blueGradient,
                  onTap: () {
                    showDialogProject(
                      context,
                      text: 'إضافة مشروع',
                    );
                  }),
              Center(
                child: SubmitButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      if (prov.file!.path == '') {
                        return AwesomeDialog(
                            context: context,
                            title: "هام",
                            body: const Text("please choose Image"),
                            dialogType: DialogType.ERROR)
                          ..show();
                      } else {
                        print(prov.file!.path);
                        List<String> fieldsStr = <String>[];

                        for (var element in prov.fields) {
                          fieldsStr.add(element.text);
                        }

                        print('Str list is => $fieldsStr');

                        await prov.createMemberProfile(

                          context: context,
                          faculty: college,
                          department: department,
                          degree: prov.degree!,
                          file: prov.file!,
                          id: prov.id,
                          fields: fieldsStr,
                          accept: prov.accept,
                          name: prov.name,
                          phone: prov.phone,
                          link: prov.link,
                          email: prov.email,
                        );
                        print(name);

                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => NavigationFile(
                        //               d: studentDrawer(context),
                        //               title: '${prov.name} مرحباً',
                        //               counter: 1,
                        //             )));
                      }
                    }
                  },
                  text: "حفظ",
                  gradient: blueGradient,
                ),
              )
            ],
          ),
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
