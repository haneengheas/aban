// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, must_be_immutable

import 'dart:io';
import 'dart:math';

import 'package:aban/constant/style.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/profile/facultymember/create_profile/accept_supervision.dart';
import 'package:aban/screens/profile/facultymember/create_profile/project_list.dart';
import 'package:aban/screens/profile/facultymember/create_profile/theses_list.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import 'dropdown.dart';

class CreateMemberProfile extends StatefulWidget {
  String? email, nameuser;

  CreateMemberProfile({
    this.nameuser,
    this.email,
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
  final GlobalKey<FormState> formKy = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'NG');

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

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
    TextEditingController nameuser =
        TextEditingController(text: widget.nameuser);
    TextEditingController email = TextEditingController(text: widget.email);

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
            mainAxisAlignment: MainAxisAlignment.start,
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
                            child: CircleAvatar(
                              backgroundColor: white,
                              radius: 30,
                              child: prov.file!.path == ''
                                  ? const Image(
                                      image: AssetImage(
                                        'assets/user.png',
                                      ),
                                      height: 80,
                                      color: blue,
                                    )
                                  : Image(
                                      image: FileImage(
                                        prov.file!,
                                      ),
                                      height: 80,
                                    ),
                            )),
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
                                    return 'الرجاء ادخال الاسم ';
                                  }
                                },
                                controller: nameuser,
                                labelText: 'اسم الباحث',
                                hintText: 'اسمك ',
                                scure: false,
                                // initialValue: widget.nameuser,
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
                          strValue: college == '' ? null : college,
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
                          text: 'اختر قسمك',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: sizeFromWidth(context, 2.1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, right: 15),
                              child: Text(
                                'الدرجة العلمية ',
                                style: labelStyle3,
                              ),
                            ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                width: sizeFromWidth(context, 2.1),
                                height: 50,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: DropdownButton<String>(
                                  hint: Text(
                                    'ادخل الدرجة العلمية',
                                    style: hintStyle,
                                  ),
                                  value: prov.degreeMember,
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
                                    prov.degreeMember = newValue!;
                                  },
                                  items: <String>[
                                    'دكتوراه',
                                    'ماجستير',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: SizedBox(
                                        width: sizeFromWidth(context, 6),
                                        height: 50,

                                        // for example
                                        child: Text(value,
                                            textAlign: TextAlign.right),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
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
                                    return 'الرجاءادخال المعرف الخاص بك ';
                                  }
                                },
                                scure: false,
                              )),
                        ),
                      ),
                      // SizedBox(
                      //   width: sizeFromWidth(context, 2),
                      //   child: Directionality(
                      //       textDirection: TextDirection.rtl,
                      //       child: TextFieldUser(
                      //         labelText: 'رقم الهاتف',
                      //         hintText: 'الهاتف ',
                      //         onChanged: (value) {
                      //           prov.phone = value;
                      //         },
                      //         validator: (value) {
                      //           if (value.isEmpty) {
                      //             return 'الرجاءادخال رقم الهاتف ';
                      //           }
                      //         },
                      //         scure: false,
                      //       )),
                      // ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: sizeFromWidth(context, 2),
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextFieldUser(
                              hintText: "Reasearsh@ksuedu.sa",
                              labelText: "بريدك الجامعي",
                              onChanged: (value) {
                                prov.email = value;
                              },

                              controller: email,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'الرجاءادخال بريدك الجامعي ';
                                }
                              },
                              // initialValue: widget.email,
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
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Form(
                      key: formKy,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          InternationalPhoneNumberInput(
                            hintText: 'رقم الهاتف',
                            textStyle: labelStyle2,
                            onInputChanged: (PhoneNumber number) {
                              print(number.phoneNumber);
                            },
                            onInputValidated: (bool value) {
                              print(value);
                            },
                            selectorConfig: const SelectorConfig(
                              selectorType:
                                  PhoneInputSelectorType.BOTTOM_SHEET,
                            ),
                            ignoreBlank: false,
                            inputDecoration: const InputDecoration(
                                enabled: false, hintText: 'رقم الهاتف'),
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: const TextStyle(color: Colors.black),
                            initialValue: number,
                            textFieldController: controller,
                            formatInput: false,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'الرجاء ادخال رقم الهاتف';
                              }
                            },
                            keyboardType:
                                const TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                            inputBorder: const OutlineInputBorder(),
                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                            },
                          ),
                        ],
                      ),
                    ),
                  )
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
                          shadowColor: gray,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: sizeFromWidth(context, 1.4),
                                  child: TextFormField(
                                    controller: e,
                                    decoration: InputDecoration(
                                        hintText: "المجال ${cards.length + 1}",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      setState(() {
                                        prov.fields.remove(e);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle_outline_sharp,
                                      color: red,
                                      size: 18,
                                    )),
                              ],
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
              ThesesList(
                department: department,
                college: college,
              ),
              const Divider(
                height: 20,
                thickness: 1,
                color: lightGray,
              ),
              ProjectList(
                department: department,
                college: college,
              ),
              Center(
                child: SubmitButton(
                  onTap: () async {
                    prov.college = college;
                    prov.department = department;
                    print(prov.department);
                    print(prov.college);
                    print(prov.file!.path);
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      print('=================');
                      List<String> fieldsStr = <String>[];
                      for (var element in prov.fields) {
                        fieldsStr.add(element.text);
                      }
                      print('Str list is => $fieldsStr');
                      if (fieldsStr.isEmpty) {
                        return AwesomeDialog(
                            context: context,
                            title: "هام",
                            body: const Text("يجب إدخال مجال"),
                            dialogType: DialogType.ERROR)
                          ..show();
                      } else {
                        await prov.createMemberProfile(
                          context: context,
                          faculty: college,
                          department: department,
                          degree: prov.degreeMember!,
                          file: prov.file!,
                          id: prov.id,
                          fields: fieldsStr,
                          accept: prov.accept,
                          name: nameuser.text,
                          phone: controller.text,
                          link: prov.link,
                          email: email.text,
                        );
                        print(name);
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

                  // if(prov.file == null){
                  //   prov.ref =
                  //       FirebaseStorage.instance.ref("images").child('user.png');
                  //   Navigator.of(context).pop();
                  // }
                  //  else

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
