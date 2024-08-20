import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:chat_app/features/chat/ui/widget/list_message_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

AppBar AppBarDetailsChatScreen(
  BuildContext context,
  ChatUserModel chatUserModel,
  String roomId,
) {
  return AppBar(
    elevation: 0,
    scrolledUnderElevation: 0,
    backgroundColor: Colors.transparent,
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
      selectedMsg.isNotEmpty
          ? IconButton(
              onPressed: () {
                FireDataBase().deleteMsg(roomId: roomId);
                // selectedMsg.clear();
              },
              icon: const Icon(Iconsax.trash),
            )
          : Container(),
      IconButton(
        onPressed: () {},
        icon: const Icon(Iconsax.copy),
      ),
    ],
  );
}
