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
  List<String> selectedMsg = [];
  List<String> copyMsg = [];
  void _updateSelectedMsg(List<String> value) {
    setState(() {
      selectedMsg = value;
    });
  }

  void _updateCopyMsg(List<String> value) {
    setState(() {
      copyMsg = value;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailsChatScreen(
        chatUserModel: widget.chatUserModel,
        roomId: widget.roomId,
        selectedMsg: selectedMsg,
        copyMsg: copyMsg,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListMessageCard(
                roomId: widget.roomId,
                chatUserModel: widget.chatUserModel,
                selectedMsg: selectedMsg,
                copyMsg: copyMsg,
                onSelectedMsgChanged: _updateSelectedMsg,
                onCopyMsgChanged: _updateCopyMsg,
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
                        roomId: widget.roomId,
                        context: context,
                        chatUsers: widget.chatUserModel,
                      )
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
