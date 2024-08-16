import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class phone extends StatelessWidget {
  const phone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Iconsax.timer_1),
        title: Text("Joined On"),
        subtitle: Text("20048102"));
  }
}

class Email extends StatelessWidget {
  const Email({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ListTile(
        leading: Icon(Iconsax.direct),
        title: Text("Email"),
        subtitle: Text("email@mail.com"));
  }
}
