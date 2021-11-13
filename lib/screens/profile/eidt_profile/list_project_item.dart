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
      children: widget.fields!.isEmpty
          ? []
          : [
              Column(
                children: prov.fields
                    .map((e) => Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: e,
                              decoration: InputDecoration(
                                  hintText: " ${widget.fields![0]}",
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always),
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
