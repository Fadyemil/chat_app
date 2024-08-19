import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/core/models/message_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';

class ChatMessageCard extends StatefulWidget {
  // final int index;
  const ChatMessageCard({
    super.key,
    // required this.index,
    required this.messageitem,
    required this.roomId,
  });
  final MessageModel messageitem;
  final String roomId;

  @override
  State<ChatMessageCard> createState() => _ChatMessageCardState();
}

class _ChatMessageCardState extends State<ChatMessageCard> {
  @override
  void initState() {
    super.initState();
    if (widget.messageitem.toId == FirebaseAuth.instance.currentUser!.uid) {
      FireDataBase().readMessage(
        roomId: widget.roomId,
        msgId: widget.messageitem.id!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMe =
        widget.messageitem.fromId == FirebaseAuth.instance.currentUser!.uid;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        isMe
            ? IconButton(
                onPressed: () {}, icon: const Icon(Iconsax.message_edit))
            : const SizedBox(),
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(isMe ? 16 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16),
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
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
                  widget.messageitem.type == "image"
                      ? Container(
                          child: CachedNetworkImage(
                            imageUrl: widget.messageitem.msg!,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                      : Text(widget.messageitem.msg!),
                  SizedBox(height: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      isMe
                          ? Icon(
                              Iconsax.tick_circle,
                              color: widget.messageitem.read == ''
                                  ? Colors.grey
                                  : Colors.blueAccent,
                              size: 18,
                            )
                          : const SizedBox(),
                      const SizedBox(width: 6),
                      Text(
                        DateFormat.yMMMEd()
                            .format(
                              DateTime.fromMillisecondsSinceEpoch(
                                int.parse(widget.messageitem.createdAt!),
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
