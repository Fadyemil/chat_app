import 'package:chat_app/features/chat/ui/widget/add_friend.dart';
import 'package:chat_app/features/chat/ui/widget/list_chat.dart';
// import 'package:chat_app/features/chat/widget/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return AddFriend(emailCon: emailCon);
            },
          );
        },
        child: const Icon(Iconsax.message_add),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListChat(),
            ),
          ],
        ),
      ),
    );
  }
}
