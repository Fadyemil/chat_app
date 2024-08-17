import 'package:chat_app/features/chat/ui/widget/chat_card.dart';
import 'package:flutter/material.dart';

class ListChat extends StatelessWidget {
  const ListChat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ChatCard(
          index: index,
        );
      },
    );
  }
}

