import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChangeMode extends StatelessWidget {
  const ChangeMode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Dark Mode"),
      leading: Icon(Iconsax.user),
      trailing: Switch(
        value: true,
        onChanged: (value) {},
      ),
    );
  }
}
