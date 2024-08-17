import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

AppBar AppBarDetailsChatScreen(BuildContext context) {
  return AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('fady'),
        Text(
          "Last Seen 11:28 am",
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(Iconsax.trash),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Iconsax.copy),
      ),
    ],
  );
}
