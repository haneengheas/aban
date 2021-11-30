// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, must_be_immutable

import 'dart:io';
import 'dart:math';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/model.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/profile/facultymember/create_profile/dropdown.dart';
import 'package:aban/screens/profile/facultymember/create_profile/project_list.dart';
import 'package:aban/screens/profile/facultymember/create_profile/theses_list.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:aban/widgets/customAppBar.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class CreateGraduatedProfile extends StatefulWidget {
  String ? email, nameuser;

  CreateGraduatedProfile({
    this.email,
    this.nameuser,
    Key? key,
  }) : super(key: key);

  @override
  _CreateGraduatedProfileState createState() => _CreateGraduatedProfileState();
}

class _CreateGraduatedProfileState extends State<CreateGraduatedProfile> {
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
  late String key;
  PhoneNumber number = PhoneNumber(isoCode: 'NG');
  //late String phoneview;
  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var prov = Provider.of<ProfileProvider>(context, listen: false);
      prov.fields.clear();
      prov.file = File('');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    var providers = Provider.of<MyModel>(context);
    TextEditingController nameuser = TextEditingController(
        text: widget.nameuser);
    TextEditingController email = TextEditingController(text: widget.email);
    return Scaffold(
      backgroundColor: white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: customAppBar(context, title: 'إنشىء ملفك الشخصي')),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
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
                                )
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
                                    controller: nameuser,

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
                                  .map((e) =>
                                  DropdownMenuItem(
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
                              department == '' ? null : department,
                              onTap: (v) {
                                department = v;
                                setState(() {});
                              },
                              listData: selectedDepartment
                                  .toList()
                                  .map((e) =>
                                  DropdownMenuItem(
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
                              // SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 15),
                                child: Text(
                                  'الدرجة العلمية ',
                                  style: labelStyle3,
                                ),
                              ),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  width: sizeFromWidth(context, 2.3),
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: DropdownButton<String>(
                                    hint: Text(
                                      'ادخل الدرجة العلمية',
                                      style: hintStyle,
                                    ),
                                    value: prov.degreeGraduated,
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
                                      prov.degreeGraduated = newValue!;
                                    },
                                    items: <String>[
                                      'طالب دكتوراه',
                                      'طالب ماجستير',
                                    ].map<DropdownMenuItem<String>>((
                                        String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SizedBox(
                                          width: sizeFromWidth(context, 5),
                                          height: 50,
                                          // for example
                                          child:
                                          Text(value,
                                              textAlign: TextAlign.right),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ],
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
                                     // phoneview = number.phoneNumber.toString();
                                      print(number.phoneNumber);
                                      key =number.isoCode!;
                                    },
                                    // onInputValidated: (bool value) {
                                    //   print(value);
                                    // },
                                    selectorConfig: const SelectorConfig(
                                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                    ),
                                    ignoreBlank: false,
                                    inputDecoration: const InputDecoration(
                                        enabled: false,
                                        hintText: 'رقم الهاتف'
                                    ),
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle:
                                    const TextStyle(color: Colors.black),
                                    initialValue: number,
                                    textFieldController: controller,
                                    formatInput: true,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'الرجاء ادخال رقم الهاتف';
                                      }
                                    },
                                    keyboardType: const TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: true,
                                    ),

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
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'برجاءادخال بريدك الجامعي ';
                                    }
                                  },
                                  controller: email,
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
                                    return 'برجاءادخال المعرف الخاص بك ';
                                  }
                                },
                                scure: false,
                              )),
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'المجالات',
                      style: labelStyle3,
                    ),
                  ),
                  Column(
                    children: prov.fields
                        .map((e) =>
                        Card(
                          shadowColor: gray,
                          margin:  const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: sizeFromWidth(context, 1.4),
                                  child: TextFormField(
                                    controller: e,
                                    decoration: InputDecoration(
                                        hintText: "المجال ${cards.length +1}",
                                        floatingLabelBehavior:
                                        FloatingLabelBehavior.always),
                                  ),
                                ),
                                IconButton(onPressed: () {
                                  setState(() {
                                    prov.fields.remove(e);
                                  });
                                },
                                    icon: const Icon(Icons.remove_circle_outline_sharp,color: red,size: 18,)),

                              ],
                            ),
                          ),
                        ))
                        .toList(),
                  ),
                  TextButton.icon(
                      onPressed: () =>
                          setState(() =>
                              prov.fields.add(TextEditingController())),
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
                  ThesesList(department: department,college: college,),
                  const Divider(
                    height: 30,
                    thickness: 1,
                    color: lightGray,
                  ),
                   ProjectList(department: department,college: college,),
                  Center(
                    child: SubmitButton(
                      onTap: () async {
                        prov.college = college;
                        prov.department = department;
                        print(prov.department);
                        print(prov.college);
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          print(prov.file!.path);
                          List<String> fieldsStr = <String>[];

                          for (var element in prov.fields) {
                            fieldsStr.add(element.text);
                          }
                          if (fieldsStr.isEmpty) {
                            return AwesomeDialog(
                                context: context,
                                title: "هام",
                                body: const Text("يجب ادخال مجال"),
                                dialogType: DialogType.ERROR)
                              ..show();
                          }
                          else if (prov.file!.path == '') {
                            return AwesomeDialog(
                                context: context,
                                title: "هام",
                                body: const Text("يجب إدخال الصورة"),
                                dialogType: DialogType.ERROR)
                              ..show();
                          }
                          else {
                            print('Str list is => $fieldsStr');

                            await prov.createMemberProfile(
                              //key: key,
                             // phoneview: phoneview,
                                context: context,
                                name: nameuser.text,
                                faculty: college,
                                phone: prov.phone,
                                id: prov.id,
                                department: department,
                                degree: prov.degreeGraduated!,
                                fields: fieldsStr,
                                link: prov.link,
                                accept: 2,
                                file: prov.file!,
                                email: email.text);
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
