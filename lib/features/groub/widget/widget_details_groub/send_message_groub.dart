import 'dart:io';

import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_storage.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class SendMessageGroub extends StatelessWidget {
  const SendMessageGroub({
    super.key,
    required this.sendMessageGroub, required this.chatGroup,
  });
  final TextEditingController sendMessageGroub;
final GroubModel chatGroup;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        controller: sendMessageGroub,
        maxLines: 5,
        minLines: 1,
        decoration: InputDecoration(
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.emoji_happy),
              ),
              IconButton(
                onPressed: () async {
                  ImagePicker picker = ImagePicker();
                  XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    FireStorage().sendImageGroup(
                      file: File(image.path),
                      groupId: chatGroup.id!,
                      context: context,
                      chatGroup: chatGroup,
                    );
                  }
                },
                icon: const Icon(Iconsax.camera),
              ),
            ],
          ),
          border: InputBorder.none,
          hintText: "Message",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
    );
  }
}

//  onPressed: () async {
//                   ImagePicker picker = ImagePicker();
//                   XFile? image =
//                       await picker.pickImage(source: ImageSource.gallery);
//                   if (image != null) {
//                     FireStorage().sendImage(
//                       file: File(image.path),
//                       roomId: roomId,
//                       userId: chatUserModel.id!,
//                       context: context,
//                       chatUser: chatUserModel,
//                     );
//                   }
//                 },