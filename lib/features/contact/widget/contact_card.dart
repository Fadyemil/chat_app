import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.user,
  });
  final ChatUserModel user;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(),
        subtitle: Text(
          user.about!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        title: Text(user.name!),
        trailing:
            IconButton(onPressed: () {}, icon: const Icon(Iconsax.message)),
      ),
    );
  }
}
