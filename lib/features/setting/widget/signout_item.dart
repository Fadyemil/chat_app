import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignoutItem extends StatelessWidget {
  const SignoutItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Signout"),
      trailing: Icon(Iconsax.logout_1),
    );
  }
}
