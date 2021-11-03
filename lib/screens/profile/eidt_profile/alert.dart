// FutureBuilder<QuerySnapshot>(
// future: FirebaseFirestore.instance
//     .collection("theses")
// .where('userId',
// isEqualTo: FirebaseAuth.instance.currentUser!.uid)
// .where('thesesStatus', isEqualTo: 'مكتملة')
// .get(),
// builder: (context, snapshot) {
// if (snapshot.connectionState ==ConnectionState.waiting) {
// return  const Text('');
// }
// if (snapshot.connectionState == ConnectionState.done) {
// if (snapshot.hasError) {
// return Text("${snapshot.error}");
// }
//
// if (snapshot.hasData) {
// return Expanded(
// child: SizedBox(
// child: ListView.builder(
// itemCount: snapshot.data!.docs.length,
// itemBuilder: (context, index) {
// return Container(
// margin: const EdgeInsets.symmetric(
// horizontal: 10, vertical: 10),
// width: sizeFromWidth(context, 1),
// height: 100,
// decoration: BoxDecoration(
// color: clearblue,
// borderRadius: BorderRadius.circular(25),
// ),
// child: Directionality(
// textDirection: TextDirection.rtl,
// child: Row(
// mainAxisAlignment: MainAxisAlignment
//     .spaceEvenly,
// children: [
// Column(
// crossAxisAlignment: CrossAxisAlignment
//     .start,
// mainAxisAlignment: MainAxisAlignment
//     .center,
// children: [
// Text(
// '${snapshot.data!
//     .docs[index]['nameTheses']}',
// style: labelStyle3,
// ),
// Text(
// 'المشرف:' +
// snapshot.data!.docs[index]
// ["nameSupervisors"],
// style: hintStyle3,
// ),
// Text(
// 'المشرفون المساعدون:' +
// snapshot.data!.docs[index]
// ["assistantSupervisors"],
// style: hintStyle3,
// ),
// ],
// ),
// const VerticalDivider(
// color: gray,
// endIndent: 10,
// indent: 10,
// width: 10,
// thickness: 2,
// ),
// Column(
// crossAxisAlignment:
// CrossAxisAlignment.center,
// mainAxisAlignment: MainAxisAlignment
//     .center,
// children: [
// Text(
// snapshot.data!.docs[index]
// ['degreeTheses'],
// style: labelStyle3,
// ),
// InkWell(
// onTap: () {
// setState(() {
// print('1');
// completed[index][3] =
// !completed[index][3];
// });
// },
// child: Container(
// height: 40,
// width: 25,
// margin: const EdgeInsets
//     .symmetric(
// vertical: 10),
// child: completed[index][3]
// ? ImageIcon(
// AssetImage(
// 'assets/${completed[index][1]}',
// ),
// color: blue,
// )
//     : ImageIcon(
// AssetImage(
// 'assets/${completed[index][2]}',
// ),
// color: blue,
// )),
// ),
// ]),
// ],
// ),
// ),
// );
// }),
// ),
// );
// }
// }
// return const Text('');
// }),