import 'package:chat_app/features/groub/widget/group_message_card.dart';
// import 'package:chat_app/features/chat/widget/welcome_message.dart';
import 'package:chat_app/features/groub/widget/widget_details_groub/app_bar_details_screen.dart';
import 'package:chat_app/features/groub/widget/widget_details_groub/send_message_groub.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DetailsGroubScreen extends StatelessWidget {
  const DetailsGroubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetailsFroubScreen(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GroupMessageCard(
                    index: index,
                  );
                },
              ),
              // child: Center(
              //   child: GestureDetector(
              //     child: WelcomeMessage(),
              //   ),
              // ),
            ),
            Row(
              children: [
                Expanded(
                  child: SendMessageGroub(),
                ),
                IconButton.filled(onPressed: () {}, icon: Icon(Iconsax.send_1))
              ],
            )
          ],
        ),
      ),
    );
  }
}

