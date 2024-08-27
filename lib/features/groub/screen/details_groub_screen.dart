import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:chat_app/features/groub/widget/widget_details_groub/app_bar_details_screen.dart';
import 'package:chat_app/features/groub/widget/widget_details_groub/list_chat_messages.dart';
import 'package:chat_app/features/groub/widget/widget_details_groub/send_message_groub.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DetailsGroubScreen extends StatefulWidget {
  const DetailsGroubScreen({super.key, required this.groubModel});
  final GroubModel groubModel;

  @override
  State<DetailsGroubScreen> createState() => _DetailsGroubScreenState();
}

class _DetailsGroubScreenState extends State<DetailsGroubScreen> {
  TextEditingController sendMessageGroub = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailsFroubScreen(context, widget.groubModel),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListChatMessages(
                groubModel: widget.groubModel,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SendMessageGroub(
                    sendMessageGroub: sendMessageGroub,
                    chatGroup: widget.groubModel,
                  ),
                ),
                IconButton.filled(
                    onPressed: () {
                      if (sendMessageGroub.text.isNotEmpty) {
                        FireDataBase()
                            .sendGroubMessage(
                                context: context,
                                chatGroup: widget.groubModel,
                                msg: sendMessageGroub.text,
                                groupId: widget.groubModel.id!)
                            .then((v) => {
                                  setState(() {
                                    sendMessageGroub.text = "";
                                  })
                                });
                      }
                    },
                    icon: Icon(Iconsax.send_1))
              ],
            )
          ],
        ),
      ),
    );
  }
}
