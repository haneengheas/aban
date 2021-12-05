import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/theses_screen/theses_details.dart';
import 'package:aban/screens/theses_screen/theses_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CompletedTheses extends StatefulWidget {
  const CompletedTheses(this.theses, this.filter, {Key? key}) : super(key: key);
  final List<ModelTheses> theses;
  final String? filter;

  @override
  _CompletedThesesState createState() => _CompletedThesesState();
}

class _CompletedThesesState extends State<CompletedTheses> {
  bool checked = true;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.theses.length,
      itemBuilder: (context, index) {
        return widget.filter == null || widget.filter == ""
            ? _buildProjBox(
                widget.theses[index],
              )
            : widget.theses[index].nameTheses!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase()) ||
                    widget.theses[index].nameSupervisors!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase()) ||
                    widget.theses[index].assistantSupervisors!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase()) ||
                    widget.theses[index].college!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase())||
                    widget.theses[index].department!
                        .toLowerCase()
                        .contains(widget.filter!.toLowerCase())
                ? _buildProjBox(
                    widget.theses[index],
                  )
                : Container();
      },
    );
  }

  Widget _buildProjBox(
    ModelTheses theses,
  ) {
    var prov = Provider.of<ProfileProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ThesesDetails(degreeTheses: theses.degreeTheses,
                        isFav: theses.isFav,
                        assistantSupervisors: theses.assistantSupervisors,
                        linkTheses: theses.linkTheses,
                        nameSupervisors: theses.nameSupervisors,
                        nameTheses: theses.nameTheses,
                        thesesStatus: theses.thesesStatus,
                        docid: theses.id,
                        userId: theses.userId)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: sizeFromWidth(context, 1),
        height: 130,
        decoration: BoxDecoration(
          color: clearblue,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'اسم الاطروحة : ' + theses.nameTheses!,
                      maxLines: 1,
                      style:  GoogleFonts.cairo(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: black,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ),
                    Text(
                      'المشرف:' + theses.nameSupervisors!,
                      style: hintStyle3,
                    ),
                    Text(
                      'المشرفون المساعدون:' + theses.assistantSupervisors!,
                      style: hintStyle3,
                    ),
                  ],
                ),
              ),
              prov.counter == 2
                  ? const SizedBox()
                  : const VerticalDivider(
                      color: gray,
                      endIndent: 10,
                      indent: 10,
                      width: 10,
                      thickness: 2,
                    ),
              prov.counter == 2
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Text(
                            theses.degreeTheses!,
                            style: hintStyle4,
                          ),
                          InkWell(
                            onTap: () async {
                              DocumentSnapshot docRef = await FirebaseFirestore
                                  .instance
                                  .collection('theses')
                                  .doc(theses.id)
                                  .get();

                              Map<String, dynamic> docIsFav =
                              docRef.get("isFav");

                              if (docIsFav.containsKey(
                                  FirebaseAuth.instance.currentUser!.uid)) {
                                docIsFav.addAll({
                                  FirebaseAuth.instance.currentUser!.uid
                                      .toString(): theses.isFav! ? false : true
                                });
                              } else {
                                docIsFav.addAll({
                                  FirebaseAuth.instance.currentUser!.uid:
                                  theses.isFav! ? false : true
                                });
                              }


                              theses.isFav = !theses.isFav!;
                              setState(() {

                              });
                              await FirebaseFirestore.instance
                                  .collection('theses')
                                  .doc(theses.id)
                                  .update({'isFav': docIsFav});


                              setState(() {});
                            },
                            child: Container(
                              height: 40,
                              width: 25,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: !theses.isFav!
                                  ? const ImageIcon(
                                      AssetImage(
                                        'assets/bookmark (1).png',
                                      ),
                                      color: blue,
                                      size: 50,
                                    )
                                  : const ImageIcon(
                                      AssetImage(
                                        'assets/bookmark (2).png',
                                      ),
                                      color: blue,
                                      size: 50,
                                    ),
                            ),
                          ),
                        ]),
            ],
          ),
        ),
      ),
    );
  }
}
