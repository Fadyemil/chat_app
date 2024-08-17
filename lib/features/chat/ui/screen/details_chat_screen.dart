import 'package:chat_app/features/chat/ui/widget/app_bar_details_chat_screen.dart';
import 'package:chat_app/features/chat/ui/widget/list_message_card.dart';
import 'package:chat_app/features/chat/ui/widget/send_message_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DetailsChatScreen extends StatelessWidget {
  const DetailsChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailsChatScreen(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListMessageCard(),
              // child: Center(
              //   child: GestureDetector(
              //     child: WelcomeMessage(),
              //   ),
              // ),
            ),
            Row(
              children: [
                const Expanded(
                  child: SendMessageField(),
                ),
                IconButton.filled(
                  onPressed: () {},
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

