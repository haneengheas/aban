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
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
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
  //late String phoneview;
  late String key;

  final GlobalKey<FormState> formKy = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
   String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: 'SA',);

  void getPhoneNumber(String phoneNumber) async {

    PhoneNumber number =

        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      this.number = number;
    });

  }

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

  deleteData() async {
    await FirebaseFirestore.instance
        .collection('member')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .delete();
    // await FirebaseAuth.instance.currentUser!.delete();
    await FirebaseFirestore.instance
        .collection('theses')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await FirebaseFirestore.instance
        .collection('project')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await FirebaseFirestore.instance
        .collection('projectBookmark')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await FirebaseFirestore.instance
        .collection('thesesBookmark')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await FirebaseFirestore.instance
        .collection('seminar')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    await FirebaseFirestore.instance
        .collection('seminarBookmark')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
    AwesomeDialog(
            context: context,
            title: "هام",
            body: const Text("تمت عملية الحذف بنجاح"),
            dialogType: DialogType.SUCCES)
        .show();
  }

  @override

  void initState() {


    var prov;
    Future.delayed(Duration.zero, () async {
      prov = Provider.of<ProfileProvider>(
        context,
        listen: false,
      );
      ///fiebase to go get key
      prov.fields.clear();
      prov.file = File('');
     // getPhoneNumber(key);

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
                                provAuth.usertype == 0
                                    ? prov.degreeMember = newValue!
                                    : prov.degreeGraduated = newValue!;
                              },
                              items: provAuth.usertype == 0
                                  ? <String>[
                                      'دكتوراه',
                                      'ماجستير',
                                    ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SizedBox(
                                          width: sizeFromWidth(context, 8),
                                          height: 50,
                                          // for example
                                          child: Text(value,
                                              textAlign: TextAlign.right),
                                        ),
                                      );
                                    }).toList()
                                  : <String>[
                                      'طالب دكتوراه',
                                      'طالب ماجستير',
                                    ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: SizedBox(
                                          width: sizeFromWidth(context, 8),
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
                    // widget of number

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

                    // SizedBox(
                    //   width: sizeFromWidth(context, 2),
                    //   child: TextFieldUser(
                    //     onChanged: (val) {
                    //       prov.phone = val;
                    //     },
                    //     validator: (value) {
                    //       if (value.isEmpty) {
                    //         return 'برجاءادخال رقم الهاتف ';
                    //       }
                    //     },
                    //     controller: phone,
                    //     hintText: "+96655...",
                    //     labelText: "رقم الهاتف",
                    //     scure: false,
                    //     // initialValue: phone,
                    //   ),
                    // ),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Form(
                    key: formKy,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InternationalPhoneNumberInput(

                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'الرجاء ادخال رقم الهاتف';
                            }
                          },

                          hintText: 'رقم الهاتف',
                          textStyle: labelStyle2,
                          onInputChanged: (PhoneNumber number) {
                          //  phoneview = number.phoneNumber.toString();
                            // phone.text = number.phoneNumber as String  ;

                            print(number.phoneNumber);
                            print(number.dialCode);
                             //TODO : save country key as string not original key
                            // dial code is print country key >>>but i want print the key as string as this ('SA')- ('EG')>>>not +966 , +20
                            print(number.isoCode);
                          },
                          onInputValidated: (bool value) {
                            if (value == false){
                               const Text('الرقم غير صالح');
                            }
                            print(value);
                            print('الرقم غير صالح');
                          },
                          selectorConfig: const SelectorConfig(

                             selectorType: PhoneInputSelectorType.BOTTOM_SHEET,

                          ),
                          ignoreBlank: false,
                          inputDecoration: const InputDecoration(
                              enabled: false,

                             // hintText: phone.text,
                          ),
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle:
                              const TextStyle(color: Colors.black),
                          initialValue: number,
                          textFieldController: phone,
                          formatInput: false,
                          keyboardType: const TextInputType.numberWithOptions(
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
              ]),
              // accept theses montor
              provAuth.usertype == 0
                  ? Column(
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
                                    groupValue: accepted,
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
                    )
                  : const SizedBox(),
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
              ThesesGraduatedMontorItem(
                department: department,
                college: college,
              ),
              const Divider(
                height: 20,
                thickness: 1,
                color: lightGray,
              ),
              ProjectItem(
                department: department,
                college: college,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // add button
                  ButtonUser(
                      text: 'حفظ التغيرات',
                      color: blueGradient,
                      onTap: () async {
                        showDialogWarning(context, ontap: () async {

                          print('hhhhhhhh');
                         // print( phoneview);
                          print( "0000000000000000000000000000000000000000000101010101010");
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            List<String> fieldsStr = <String>[];

                            for (var element in prov.fields) {
                              fieldsStr.add(element.text);
                            }

                            print('Str list is => $fieldsStr');

                            if (provAuth.usertype == 0) {
                              await FirebaseFirestore.instance
                                  .collection('member')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'name': name.text,
                                'accept': accepted,
                                'degree': degree,
                                'faculty': college,
                                'department': department,
                                'id': id.text,
                                'link': link.text,
                                'phone': phone.text,
                               // 'phoneview': phoneview,
                                'email': emailuser.text,
                                // 'imageUrl': imageUrl,
                                'fields': fieldsStr
                              }).then((value) async {
                                Navigator.pop(context);
                                await AwesomeDialog(
                                        context: context,
                                        title: "هام",
                                        body: const Text(
                                            "تمت عملية التعديل بنجاح"),
                                        dialogType: DialogType.SUCCES)
                                    .show();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileScreen()));
                              });
                            } else {
                              await FirebaseFirestore.instance
                                  .collection('member')
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                'name': name.text,
                                'accept': 2,
                                'degree': degree,
                                'faculty': college,
                                'department': department,
                                'id': id.text,
                                'link': link.text,
                                'phone': phone.text,
                                //'phoneview': phoneview,
                                'email': emailuser.text,
                                // 'imageUrl': imageUrl,
                                'fields': fieldsStr
                              }).then((value) async {
                                Navigator.pop(context);
                                await AwesomeDialog(
                                        context: context,
                                        title: "هام",
                                        body: const Text(
                                            "تمت عملية التعديل بنجاح"),
                                        dialogType: DialogType.SUCCES)
                                    .show();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileScreen()));
                              });
                            }
                          }

                          print(name);
                        }, text: 'هل انت متاكد من حفظ التغييرات ؟');
                      }),
                  // cancel button
                  ButtonUser(
                      text: 'الغاء',
                      color: redGradient,
                      onTap: () {
                        print(provAuth.usertype);
                        Navigator.pop(context);
                      }),
                ],
              ),
              // delete button
              Center(
                  child: ButtonUser(
                      text: 'حذف الحساب',
                      color: grayGradient,
                      onTap: () {
                        showDialogWarning(context,
                            text: 'هل انت متاكد من حذف الحساب ؟',
                            ontap: () async {
                          await deleteData();
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
