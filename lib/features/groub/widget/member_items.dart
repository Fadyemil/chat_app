import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MemberItems extends StatelessWidget {
  const MemberItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Name"),
      subtitle: Text("Admin"),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {}, icon: Icon(Iconsax.user_tick)),
          IconButton(onPressed: () {}, icon: Icon(Iconsax.trash)),
        ],
      ),
    );
  }
}
