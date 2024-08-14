import 'package:chat_app/features/chat/screen/details_chat_screen.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.index,
  });
  final int index;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsChatScreen(),
          ),
        ),
        leading: CircleAvatar(),
        title: Text('User $index'),
        subtitle: Text('Message $index'),
        trailing: Badge(
          padding: EdgeInsets.symmetric(horizontal: 12),
          label: Text('3'),
          largeSize: 30,
        ),
      ),
    );
  }
}
