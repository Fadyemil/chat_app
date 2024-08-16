import 'package:chat_app/features/groub/widget/groub_card.dart';
import 'package:flutter/material.dart';

class ListGroub extends StatelessWidget {
  const ListGroub({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) {
        return const GroupCard();
      },
    );
  }
}
