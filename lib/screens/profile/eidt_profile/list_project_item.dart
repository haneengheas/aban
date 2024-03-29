// ignore_for_file: must_be_immutable

import 'package:aban/constant/style.dart';
import 'package:aban/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListProjectItem extends StatefulWidget {
  List? fields;
  ListProjectItem({Key? key, required this.fields}) : super(key: key);

  @override
  State<ListProjectItem> createState() => _ListProjectItemState();
}

class _ListProjectItemState extends State<ListProjectItem> {
  var cards = <Card>[];
  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProfileProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.fields!.isEmpty
          ? []
          : [
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
            ],
    );
  }
}
