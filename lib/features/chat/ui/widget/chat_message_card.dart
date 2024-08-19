import 'package:chat_app/core/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ChatMessageCard extends StatelessWidget {
  // final int index;
  const ChatMessageCard({
    super.key,
    // required this.index,
    required this.messageitem,
  });
  final MessageModel messageitem;

  @override
  Widget build(BuildContext context) {
    bool isMe = messageitem.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isMe
            ? IconButton(onPressed: () {}, icon: Icon(Iconsax.message_edit))
            : SizedBox(),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          )),
          color: isMe
              ? Theme.of(context).colorScheme.surface
              : Theme.of(context).colorScheme.primaryContainer,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(messageitem.msg!),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isMe
                          ? Icon(
                              Iconsax.tick_circle,
                              color: Colors.blueAccent,
                              size: 18,
                            )
                          : SizedBox(),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        DateFormat.yMMMEd()
                            .format(
                              DateTime.fromMillisecondsSinceEpoch(
                                int.parse(messageitem.createdAt!),
                              ),
                            )
                            .toString(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
