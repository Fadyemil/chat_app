import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

AppBar AppBarDetailsChatScreen(
    BuildContext context, ChatUserModel chatUserModel) {
  return AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(chatUserModel.name!),
        Text(
         chatUserModel.lastActivated!,
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
