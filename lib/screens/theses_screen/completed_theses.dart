import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:aban/screens/theses_screen/theses_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompletedTheses extends StatefulWidget {
   CompletedTheses(this.theses, this.filter, {Key? key}) : super(key: key);
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
                    .contains(widget.filter!.toLowerCase())
                ? _buildProjBox(
                    widget.theses[index],
                  )
                : Container();
      },
    );
  }

  Widget _buildProjBox(ModelTheses theses,) {
    var prov = Provider.of<ProfileProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: sizeFromWidth(context, 1),
      height: 120,
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
                    style: labelStyle3,
                  ),
                  Text(
                    'القائد:' + theses.nameTheses!,
                    style: hintStyle3,
                  ),
                  Text(
                    'الاعضاء:' + theses.nameTheses!,
                    style: hintStyle3,
                  ),
                ],
              ),
            ),

            prov.counter == 2? const SizedBox():const VerticalDivider(
              color: gray,
              endIndent: 10,
              indent: 10,
              width: 10,
              thickness: 2,
            ),
            prov.counter == 2? const SizedBox():Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    theses.degreeTheses!,
                    style: hintStyle4,
                  ),
                  InkWell(
                    onTap: () async {
                      FirebaseFirestore.instance
                          .collection('thesesBookmark')
                          .doc(theses.id)
                          .set({
                        'nameTheses': theses.nameTheses,
                        'nameSupervisors': theses.nameSupervisors,
                        'assistantSupervisors': theses.assistantSupervisors,
                        'degreeTheses': theses.degreeTheses,
                        'linkTheses': theses.linkTheses,
                        'thesesStatus': theses.thesesStatus,
                        'userId': FirebaseAuth.instance.currentUser!.uid,
                        'isFav':theses.isFav! ? false : true
                      });

                      theses.isFav= !theses.isFav!;
                      await FirebaseFirestore.instance
                          .collection('theses')
                          .doc(theses.id)
                          .update(
                          {'isFav': theses.isFav! });

                      if (theses.isFav == false) {
                        await FirebaseFirestore.instance
                            .collection('thesesBookmark')
                            .doc(theses.id)
                            .delete();
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: 25,
                      margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: !theses.isFav!? const ImageIcon(
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
    );
  }
}
