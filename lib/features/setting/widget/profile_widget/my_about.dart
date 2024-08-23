// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyAbout extends StatefulWidget {
  MyAbout({
    super.key,
    required this.nameCon,
    this.aboutEdit,
  });
  bool? aboutEdit;

  final TextEditingController nameCon;

  @override
  State<MyAbout> createState() => _MyAboutState();
}

class _MyAboutState extends State<MyAbout> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Iconsax.information),
      trailing: IconButton(
          onPressed: () {
            setState(() {
              widget.aboutEdit = true;
            });
          },
          icon: const Icon(Iconsax.edit)),
      title: TextField(
        controller: widget.nameCon,
        enabled: widget.aboutEdit,
        decoration: const InputDecoration(
          labelText: "About",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
