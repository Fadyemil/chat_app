import 'package:chat_app/features/contact/widget/contact_card.dart';
import 'package:flutter/material.dart';

class ListContact extends StatelessWidget {
  const ListContact({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
    return ContactCard();
                },
              );
  }
}
