import 'package:chat_app/features/chat/widget/chat_message_card.dart';
import 'package:flutter/material.dart';

class ListMessageCard extends StatelessWidget {
  const ListMessageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: 6,
      itemBuilder: (context, index) {
        return ChatMessageCard(
          index: index,
        );
      },
    );
  }
}

