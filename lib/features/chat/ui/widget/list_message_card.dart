import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/core/models/message_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:chat_app/features/chat/ui/widget/chat_message_card.dart';
import 'package:chat_app/features/chat/ui/widget/welcome_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListMessageCard extends StatefulWidget {
  const ListMessageCard({
    super.key,
    required this.roomId,
    required this.chatUserModel,
  });

  final String roomId;
  final ChatUserModel chatUserModel;

  @override
  State<ListMessageCard> createState() => _ListMessageCardState();
}

class _ListMessageCardState extends State<ListMessageCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('rooms')
            .doc(widget.roomId)
            .collection('messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<MessageModel> messagesItems = snapshot.data!.docs
                .map((e) => MessageModel.formJson(e.data()))
                .toList()
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            return messagesItems.isNotEmpty
                ? ListView.builder(
                    reverse: true,
                    itemCount: messagesItems.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMsg.isNotEmpty
                                ? selectedMsg.contains(messagesItems[index].id)
                                    ? selectedMsg
                                        .remove(messagesItems[index].id)
                                    : selectedMsg.add(messagesItems[index].id!)
                                : null;
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            selectedMsg.contains(messagesItems[index].id)
                                ? selectedMsg.remove(messagesItems[index].id)
                                : selectedMsg.add(messagesItems[index].id!);
                          });
                        },
                        child: ChatMessageCard(
                          select: selectedMsg.contains(messagesItems[index].id),
                          messageitem: messagesItems[index],
                          roomId: widget.roomId,
                        ),
                      );
                    },
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        FireDataBase().sendMessage(
                          uid: widget.chatUserModel.id!,
                          msg: 'Say Assalamu Alaikum 👋',
                          roomId: widget.roomId,
                        );
                      },
                      child: WelcomeMessage(),
                    ),
                  );
          }
          {
            return Center(child: Text('No messages yet'));
          }
        });
  }
}

List<String> selectedMsg = [];