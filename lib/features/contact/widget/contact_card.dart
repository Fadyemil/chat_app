import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:chat_app/features/chat/ui/screen/details_chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        trailing: IconButton(
          onPressed: () {
            List<String> members = [
              user.id!,
              FirebaseAuth.instance.currentUser!.uid,
            ]..sort((a, b) => a.compareTo(b));
            FireDataBase().createRoom(user.email!).then(
                  (value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return DetailsChatScreen(
                            roomId: members.toString(), chatUserModel: user);
                      },
                    ),
                  ),
                );
          },
          icon: const Icon(Iconsax.message),
        ),
      ),
    );
  }
}
