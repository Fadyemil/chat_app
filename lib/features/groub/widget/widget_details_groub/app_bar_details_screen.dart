import 'package:chat_app/features/groub/screen/group_member_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

AppBar AppBarDetailsFroubScreen(context) {
  return AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Name"),
        Text(
          "ahmad, nabil, mohamad .... ",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupMemberScreen(),
            ),
          );
        },
        icon: const Icon(Iconsax.user),
      ),
      // IconButton(
      //   onPressed: () {},
      //   icon: const Icon(Iconsax.copy),
      // ),
    ],
  );
}
