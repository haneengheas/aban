import 'package:aban/constant/style.dart';
import 'package:flutter/material.dart';
class ListProjectItem extends StatefulWidget {
  const ListProjectItem({Key? key}) : super(key: key);

  @override
  State<ListProjectItem> createState() => _ListProjectItemState();
}

class _ListProjectItemState extends State<ListProjectItem> {
  var fields = <TextEditingController>[];
  var cards = <Card>[];
  Card createCard() {
    var textController = TextEditingController();
    fields.add(textController);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
            hintText: "المجال ${cards.length + 1}",
            hintStyle: hintStyle3,
            floatingLabelBehavior: FloatingLabelBehavior.always),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //     width: sizeFromWidth(context, 1.5),
        //     child: TextFieldUser(
        //         hintText: "المجال الاول",
        //         labelText: "المجالات:",
        //         scure: true)),
        SizedBox(
          height: 50,
          width: 300,
          child: ListView.builder(
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              return cards[index];
            },
          ),
        ),
        TextButton.icon(
            onPressed: () => setState(() => cards.add(createCard())),
            icon:const Icon(Icons.add_circle_outline,color: black,size: 20,),
            label: Text('اضافة مجال',style: hintStyle4,)),
      ],
    );
  }
}
