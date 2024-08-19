import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/core/models/message_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:chat_app/features/chat/ui/widget/chat_message_card.dart';
import 'package:chat_app/features/chat/ui/widget/welcome_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListMessageCard extends StatelessWidget {
  const ListMessageCard({
    super.key,
    required this.roomId,
    required this.chatUserModel,
  });

  final String roomId;
  final ChatUserModel chatUserModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('rooms')
            .doc(roomId)
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
                      return ChatMessageCard(
                        // index: index,
                        messageitem: messagesItems[index], roomId: roomId,
                      );
                    },
                  )
                : Center(
                    child: GestureDetector(
                      onTap: () {
                        FireDataBase().sendMessage(
                          uid: chatUserModel.id!,
                          msg: 'Say Assalamu Alaikum 👋',
                          roomId: roomId,
                        );
                      },
                      child: WelcomeMessage(),
                    ),
                  );
          } else {
            return Center(child: Text('No messages yet'));
          }
        });
  }
}
