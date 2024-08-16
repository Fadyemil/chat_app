import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyAbout extends StatelessWidget {
  const MyAbout({
    super.key,
    required this.nameCon,
  });

  final TextEditingController nameCon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Iconsax.information),
      trailing: IconButton(
          onPressed: () {}, icon: const Icon(Iconsax.edit)),
      title: TextField(
        controller: nameCon,
        enabled: false,
        decoration: const InputDecoration(
          labelText: "About",
          border: InputBorder.none,
        ),
      ),
    );
  }
}


