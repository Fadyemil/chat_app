// ignore_for_file: must_be_immutable

import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:chat_app/features/chat/ui/widget/app_bar_details_chat_screen.dart';
import 'package:chat_app/features/chat/ui/widget/list_message_card.dart';
import 'package:chat_app/features/chat/ui/widget/send_message_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DetailsChatScreen extends StatefulWidget {
  const DetailsChatScreen(
      {super.key, required this.roomId, required this.chatUserModel});
  final String roomId;
  final ChatUserModel chatUserModel;

  @override
  State<DetailsChatScreen> createState() => _DetailsChatScreenState();
}

class _DetailsChatScreenState extends State<DetailsChatScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailsChatScreen(
        context,
        widget.chatUserModel,
        widget.roomId,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListMessageCard(
                roomId: widget.roomId,
                chatUserModel: widget.chatUserModel,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SendMessageField(
                    controller: controller,
                    roomId: widget.roomId,
                    chatUserModel: widget.chatUserModel,
                  ),
                ),
                IconButton.filled(
                  onPressed: () {
                    if (controller.text.isNotEmpty) {
                      FireDataBase()
                          .sendMessage(
                              uid: widget.chatUserModel.id!,
                              msg: controller.text,
                              roomId: widget.roomId)
                          .then((value) {
                        setState(() {
                          controller.text = '';
                        });
                      });
                    }
                  },
                  icon: const Icon(Iconsax.send_1),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
