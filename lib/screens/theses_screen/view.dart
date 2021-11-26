import 'package:aban/constant/style.dart';
import 'package:aban/provider/auth_provider.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/Home/guestdawer.dart';
import 'package:aban/screens/Home/navigation.dart';
import 'package:aban/screens/Home/studentdrawer.dart';
import 'package:aban/screens/theses_screen/completed_theses.dart';
import 'package:aban/screens/theses_screen/theses_model.dart';
import 'package:aban/screens/theses_screen/uncompleted_theses.dart';
import 'package:aban/widgets/search_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ThesesScreen extends StatefulWidget {
  const ThesesScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ThesesScreenState createState() => _ThesesScreenState();
}

class _ThesesScreenState extends State<ThesesScreen> {
  List<ModelTheses> unCompletedTheses = <ModelTheses>[];
  List<ModelTheses> completedTheses = <ModelTheses>[];
  TextEditingController searchController = TextEditingController();
  String filter = '';

  @override
  void initState() {
    getCompletedTheses();
    getUnCompletedTheses();
    searchController.addListener(() {
      filter = searchController.text;
      setState(() {});
    });

    super.initState();
  }

  getCompletedTheses() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('theses')
        .where('thesesStatus', isEqualTo: 'مكتملة')
        .get();

    for (var doc in querySnapshot.docs) {
      completedTheses.add(ModelTheses(
          nameTheses: doc['nameTheses'],
          assistantSupervisors: doc['assistantSupervisors'],
          degreeTheses: doc['degreeTheses'],
          nameSupervisors: doc['nameSupervisors'],
          linkTheses: doc['linkTheses'],
          thesesStatus: doc['thesesStatus'],
          isFav: doc['isFav'],
          department: doc['department'],
          college: doc['college'],
          userId: doc['userId'],
          id: doc.id));
    }

    setState(() {});
  }

  getUnCompletedTheses() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('theses')
        .where('thesesStatus', isEqualTo: 'غير مكتملة')
        .get();

    for (var doc in querySnapshot.docs) {
      unCompletedTheses.add(ModelTheses(
          nameTheses: doc['nameTheses'],
          assistantSupervisors: doc['assistantSupervisors'],
          degreeTheses: doc['degreeTheses'],
          nameSupervisors: doc['nameSupervisors'],
          linkTheses: doc['linkTheses'],
          thesesStatus: doc['thesesStatus'],
          isFav: doc['isFav'],
          department: doc['department'],
          college: doc['college'],
          userId: doc['userId'],
          id: doc.id));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    var provider = Provider.of<AuthProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          title: Text('أطروحات',
              style: GoogleFonts.cairo(
                textStyle: const TextStyle(
                    color: blue, fontWeight: FontWeight.bold, fontSize: 28),
              )),
          centerTitle: true,
          elevation: 0,
          // const SizedBox(),
          // IconButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     icon: const Icon(Icons.arrow_back,color: blue,)),
          leading: IconButton(
            onPressed: () {
              if (prov.counter == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationFile(
                            d: studentDrawer(context),
                            title: ' مرحبا${provider.userName} ',
                            counter: prov.counter!)));
              } else if (prov.counter == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavigationFile(
                            d: guestDrawer(context),
                            title: 'مرحبا',
                            counter: prov.counter!)));
              }
            },
            icon: const Icon(Icons.arrow_back),
            color: blue,
          ),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(
              parent: NeverScrollableScrollPhysics()),
          child: Column(
            children: [
              SearchTextField(
                text: 'البحث عن اطروحة',
                controller: searchController,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.415,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  border: Border.fromBorderSide(
                      BorderSide(color: lightBlue, width: 1.5)),
                ),
                child: Column(children: [
                  SizedBox(
                    height: 65,
                    child: (TabBar(
                      labelColor: blue,
                      unselectedLabelColor: gray,
                      labelStyle: GoogleFonts.cairo(
                        textStyle: const TextStyle(
                            fontSize: 22,
                            height: 1.5,
                            fontWeight: FontWeight.w800),
                      ),
                      isScrollable: true,
                      tabs: const <Widget>[
                        Tab(
                          text: 'غير مكتملة',
                        ),
                        Tab(
                          text: ' مكتملة',
                        ),
                      ],
                    )),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: TabBarView(
                        children: [
                          UnCompletedTheses(
                              unCompletedTheses, filter),
                          CompletedTheses(completedTheses, filter)
                        ],
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
