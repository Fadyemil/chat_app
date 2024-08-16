import 'package:chat_app/features/groub/widget/member_items.dart';
import 'package:flutter/material.dart';

class ListMembetItems extends StatelessWidget {
  const ListMembetItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return MemberItems();
      },
    );
  }
}

