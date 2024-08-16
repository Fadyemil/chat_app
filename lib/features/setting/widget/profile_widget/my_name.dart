import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyName extends StatelessWidget {
  const MyName({
    super.key,
    required this.nameCon,
  });

  final TextEditingController nameCon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Iconsax.user_octagon),
      trailing: IconButton(
          onPressed: () {}, icon: const Icon(Iconsax.edit)),
      title: TextField(
        controller: nameCon,
        enabled: false,
        decoration: const InputDecoration(
          labelText: "Name",
          border: InputBorder.none,
        ),
      ),
    );
  }
}

