// ignore_for_file: avoid_print

import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/tetfielduser.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

showDialogWarning(
  BuildContext context, {
  required String text,
  required Function ontap,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: clearblue, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: Container(
            width: sizeFromWidth(context, 1),
            height: 40,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text(
                text,
                style: labelStyle2,
              ),
            )),
        actions: <Widget>[
          ButtonUser(
            text: 'لا',
            color: blueGradient,
            onTap: () => Navigator.pop(context),
          ),
          ButtonUser(text: 'نعم', color: redGradient, onTap: () => ontap()),
        ],
      );
    },
  );
}

void showDialogTheses(
  BuildContext context, {
  required String text,
  required String department,
  required String college,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var prov = Provider.of<ProfileProvider>(context);
      var auth = Provider.of<AuthProvider>(context);
      return AlertDialog(
        title: Center(child: Text(text)),
        titleTextStyle: labelStyle,
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        elevation: 10,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: clearblue, width: 10),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.2,
            child: Form(
              key: prov.formkey,
              child: Column(
                children: [
                  TextFieldUser(
                    hintText: 'اسم الاطروحة',
                    labelText: "اسم الاطروحة",
                    scure: false,
                    onChanged: (val) {
                      prov.nameTheses = val;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'الرجاءادخال اسم الاطروحة ';
                      }
                    },
                  ),
                  TextFieldUser(
                      onChanged: (val) {
                        prov.linkTheses = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاءادخال رابط الاطروحة ';
                        }
                      },
                      hintText: 'رابط الاطروحة',
                      labelText: 'رابط الاطروحة',
                      scure: false),
                  TextFieldUser(
                      onChanged: (val) {
                        prov.nameSupervisors = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاءادخال اسماء المشرفين  ';
                        }
                      },
                      hintText: 'اسم المشرف',
                      labelText: "المشرف",
                      scure: false),
                  TextFieldUser(
                      onChanged: (val) {
                        prov.assistantSupervisors = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاءادخال اسماء المشرفين المساعدين ';
                        }
                      },
                      hintText: 'اسماء المشرفين المساعدين',
                      labelText: "المشرفون المساعدون",
                      scure: false),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'الدرجة العلمية',
                          style: labelStyle3,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            child: DropdownButton<String>(
                              hint: Text(
                                'اخترالدرجة العلمية',
                                style: hintStyle,
                              ),
                              value: prov.degreeTheses,
                              underline: Container(
                                width: 30,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                prov.degreeTheses = newValue!;
                              },
                              items: <String>[
                                'Master',
                                'Phd'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: sizeFromWidth(context, 2.3),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'حالة الاطروحة',
                          style: labelStyle3,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            child: DropdownButton<String>(
                              hint: Text(
                                'اختر حالة الاطروحة',
                                style: hintStyle,
                              ),
                              value: prov.thesesStatus,
                              underline: Container(
                                width: 30,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                prov.thesesStatus = newValue!;
                              },
                              items: <String>[
                                'غير مكتملة',
                                'مكتملة'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: sizeFromWidth(context, 2.3),
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
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          ButtonUser(
              text: 'إالغاء',
              color: redGradient,
              onTap: () {
                Navigator.pop(context);
              }),
          ButtonUser(
              text: 'أضافة',
              color: blueGradient,
              onTap: () async {
                print(auth.usertype);
                print(auth.usertype);
                if (prov.formkey.currentState!.validate()) {
                  prov.formkey.currentState!.save();
                  await prov.addThesesMember(
                      context: context,
                      nameTheses: prov.nameTheses,
                      linkTheses: prov.linkTheses,
                      assistantSupervisors: prov.assistantSupervisors,
                      nameSupervisors: prov.nameSupervisors,
                      degreeTheses: prov.degreeTheses,
                      college: college,
                      department: department,
                      thesesStatus: prov.thesesStatus);
                  Navigator.pop(context);
                  AwesomeDialog(
                          context: context,
                          title: "هام",
                          body: const Text("تمت عملية الاضافة بنجاح"),
                          dialogType: DialogType.SUCCES)
                      .show();
                }
              }),
        ],
      );
    },
  );
}

void showDialogProject(
  BuildContext context, {
  required String text,
  required String department,
  required String college,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      var prov = Provider.of<ProfileProvider>(context);

      return AlertDialog(
        title: Center(child: Text(text)),
        titleTextStyle: labelStyle,
        titlePadding: const EdgeInsets.symmetric(vertical: 20),
        elevation: 10,
        shape: const RoundedRectangleBorder(
            side: BorderSide(color: clearblue, width: 10),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        content: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: Form(
              key: prov.formkey,
              child: Column(
                children: [
                  TextFieldUser(
                      onChanged: (val) {
                        prov.projectName = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاءادخال اسم المشروع ';
                        }
                      },
                      hintText: 'اسم المشروع',
                      labelText: "اسم المشروع",
                      scure: false),
                  TextFieldUser(
                      onChanged: (val) {
                        prov.descriptionProject = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاءادخال وصف المشروع ';
                        }
                      },
                      hintText: 'وصف المشروع',
                      labelText: "وصف المشروع",
                      scure: false),
                  TextFieldUser(
                      onChanged: (val) {
                        prov.leaderName = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاءادخال اسم القائد ';
                        }
                      },
                      hintText: 'اسم القائد',
                      labelText: "القائد",
                      scure: false),
                  TextFieldUser(
                      onChanged: (val) {
                        prov.memberProjectName = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاءادخال اسماء الاعضاء ';
                        }
                      },
                      hintText: 'اسم الاعضاء',
                      labelText: "الاعضاء",
                      scure: false),
                  TextFieldUser(
                      onChanged: (val) {
                        prov.linkProject = val;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'الرجاءادخال رابط المشروع ';
                        }
                      },
                      hintText: 'ادخل رابط المشروع',
                      labelText: "رابط المشروع",
                      scure: false),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'حالة المشروع',
                          style: labelStyle3,
                        ),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: SizedBox(
                            child: DropdownButton<String>(
                              hint: Text(
                                'اختر حالة المشروع',
                                style: hintStyle,
                              ),
                              value: prov.projectStatus,
                              underline: Container(
                                width: 30,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height: 1,
                                decoration: const BoxDecoration(
                                    color: gray,
                                    boxShadow: [
                                      BoxShadow(
                                        color: blue,
                                      )
                                    ]),
                              ),
                              onChanged: (newValue) {
                                prov.projectStatus = newValue!;
                              },
                              items: <String>[
                                'غير مكتملة',
                                'مكتملة'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: sizeFromWidth(context, 2.3),
                                    // for example
                                    child:
                                        Text(value, textAlign: TextAlign.left),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          ButtonUser(
              text: 'إالغاء',
              color: redGradient,
              onTap: () {
                Navigator.pop(context);
              }),
          ButtonUser(
              text: 'أضافة',
              color: blueGradient,
              onTap: () async {
                if (prov.formkey.currentState!.validate()) {
                  prov.formkey.currentState!.save();
                  await prov.addProjectsMember(
                    context: context,
                    projectName: prov.projectName,
                    descriptionProject: prov.descriptionProject,
                    leaderName: prov.leaderName,
                    memberProjectName: prov.memberProjectName,
                    projectStatus: prov.projectStatus,
                    linkProject: prov.linkProject,
                    college: college,
                    department: department,
                    // projectDegree: prov.projectDegree
                  );
                  Navigator.pop(context);
                  AwesomeDialog(
                      context: context,
                      title: "هام",
                      body: const Text("تمت عملية الاضافة بنجاح"),
                      dialogType: DialogType.SUCCES)
                      .show();
                }
              }),
        ],
      );
    },
  );
}

// void showDialogSeminar(
//   BuildContext context, {
//   required String text,
// }) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       var prov = Provider.of<ProfileProvider>(context);
//       var auth = Provider.of<AuthProvider>(context);
//       return AlertDialog(
//         title: Center(child: Text(text)),
//         titleTextStyle: labelStyle,
//         titlePadding: const EdgeInsets.symmetric(vertical: 20),
//         elevation: 10,
//         shape: const RoundedRectangleBorder(
//             side: BorderSide(color: clearblue, width: 10),
//             borderRadius: BorderRadius.all(Radius.circular(15))),
//         content: SingleChildScrollView(
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height / 1.2,
//             child: Form(
//               key: prov.formkey,
//               child: Column(
//                 children: [
//                   TextFieldUser(
//                     hintText: 'اسم الاطروحة',
//                     labelText: "اسم الاطروحة",
//                     scure: false,
//                     onChanged: (val) {
//                       prov.nameTheses = val;
//                     },
//                     validator: (value) {
//                       if (value.isEmpty) {
//                         return 'برجاءادخال اسم الاطروحة ';
//                       }
//                     },
//                   ),
//                   TextFieldUser(
//                       onChanged: (val) {
//                         prov.linkTheses = val;
//                       },
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'برجاءادخال رابط الاطروحة ';
//                         }
//                       },
//                       hintText: 'رابط الاطروحة',
//                       labelText: 'رابط الاطروحة',
//                       scure: false),
//
//                   TextFieldUser(
//                       onChanged: (val) {
//                         prov.nameSupervisors = val;
//                       },
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'برجاءادخال اسماء المشرفين  ';
//                         }
//                       },
//                       hintText: 'اسم المشرف',
//                       labelText: "المشرف",
//                       scure: false),
//                   TextFieldUser(
//                       onChanged: (val) {
//                         prov.assistantSupervisors = val;
//                       },
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'برجاءادخال اسماء المشرفين المساعدين ';
//                         }
//                       },
//                       hintText: 'اسماء المشرفين المساعدين',
//                       labelText: "المشرفون المساعدون",
//                       scure: false),
//                   TextFieldUser(
//                       onChanged: (val) {
//                         prov.degreeTheses = val;
//                       },
//                       validator: (value) {
//                         if (value.isEmpty) {
//                           return 'برجاءادخال الدرجة العلمية ';
//                         }
//                       },
//                       hintText: 'اختر الدرجة العمليه',
//                       labelText: "الدرجة العلميه",
//                       scure: false),
//                   // TextFieldUser(
//                   //     onChanged: (val) {
//                   //       prov.thesesStatus = val;
//                   //     },
//                   //     validator: (value) {
//                   //       if (value.isEmpty) {
//                   //         return 'برجاءادخال حالة الاطروحة ';
//                   //       }
//                   //     },
//                   //     hintText: 'اختر حالة الاطروحة',
//                   //     labelText: "حالة الاطروحة",
//                   //     scure: false),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 7.5),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Text(
//                           'حالة الاطروحة',
//                           style: labelStyle3,
//                         ),
//                         Directionality(
//                           textDirection: TextDirection.rtl,
//                           child: SizedBox(
//                             child: DropdownButton<String>(
//                               hint: Text(
//                                 'اختر حالة الاطروحة',
//                                 style: hintStyle,
//                               ),
//                               value: prov.thesesStatus,
//                               underline: Container(
//                                 width: 30,
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 height: .5,
//                                 decoration: const BoxDecoration(
//                                     color: gray,
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: blue,
//                                       )
//                                     ]),
//                               ),
//                               onChanged: (newValue) {
//                                 prov.thesesStatus = newValue!;
//                               },
//                               items: <String>[
//                                 'غير مكتملة',
//                                 'مكتملة'
//                               ].map<DropdownMenuItem<String>>((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: SizedBox(
//                                     width: sizeFromWidth(context, 2.3),
//                                     // for example
//                                     child:
//                                         Text(value, textAlign: TextAlign.left),
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           ButtonUser(
//               text: 'إالغاء',
//               color: redGradient,
//               onTap: () {
//                 Navigator.pop(context);
//               }),
//           // ButtonUser(
//           //     text: 'أضافة',
//           //     color: blueGradient,
//           //     onTap: () async {
//           //       print(auth.usertype);
//           //       if (prov.formkey.currentState!.validate()) {
//           //         prov.formkey.currentState!.save();
//           //         await prov.addThesesMember(
//           //             context: context,
//           //             nameTheses: prov.nameTheses,
//           //             linkTheses: prov.linkTheses,
//           //             assistantSupervisors: prov.assistantSupervisors,
//           //             nameSupervisors: prov.nameSupervisors,
//           //             degreeTheses: prov.degreeTheses,
//           //             thesesStatus: prov.thesesStatus, college: collge);
//           //         Navigator.pop(context);
//           //       }
//           //
//           //     }),
//         ],
//       );
//     },
//   );
// }
