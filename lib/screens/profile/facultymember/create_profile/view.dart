// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:aban/constant/alert_methods.dart';
import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/profile/facultymember/create_profile/accept_supervision.dart';
import 'package:aban/screens/profile/facultymember/create_profile/profile_information.dart';
import 'package:aban/widgets/buttons/buttonsuser.dart';
import 'package:aban/widgets/buttons/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateMemberProfile extends StatefulWidget {
  const CreateMemberProfile({
    Key? key,
  }) : super(key: key);

  @override
  _CreateMemberProfileState createState() => _CreateMemberProfileState();
}

class _CreateMemberProfileState extends State<CreateMemberProfile> {
  var fields = [];
  var cards = <Card>[];
  var text;
  var textController = TextEditingController();

  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
            child: Form(
          key: prov.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // widget for user information example( name , phone)
              const ProfileInformation(),
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
                    showDialogTheses(context, text: 'اضافة اطروحة');
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
                    showDialogProject(context, text: 'إضافة مشروع');
                  }),
              Center(
                child: SubmitButton(
                  onTap: () async {
                    await prov.createMemberProfile(
                      context: context,
                      faculty: prov.faculty,
                      degree: prov.degree,
                      file: prov.file,
                      id: prov.id,
                      accept: prov.accept,
                      name: prov.name,
                      phone: prov.phone,
                      link: prov.link,
                    );
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
          ),
        )),
      ),
    );
  }
}
