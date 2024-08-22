import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/core/models/message_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:chat_app/features/chat/ui/widget/welcome_message.dart';
import 'package:chat_app/features/groub/widget/group_message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListChatMessages extends StatefulWidget {
  const ListChatMessages({
    super.key,
    required this.groubModel,
  });
  final GroubModel groubModel;

  @override
  State<ListChatMessages> createState() => _ListChatMessagesState();
}

class _ListChatMessagesState extends State<ListChatMessages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('groups')
            .doc(widget.groubModel.id)
            .collection('messages')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<MessageModel> msgs = snapshot.data!.docs
                .map((e) => MessageModel.formJson(e.data()))
                .toList()
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            if (msgs.isNotEmpty) {
              return ListView.builder(
                reverse: true,
                itemCount: msgs.length,
                itemBuilder: (context, index) {
                  return GroupMessageCard(
                    message: msgs[index],
                  );
                },
              );
            } else {
              return Center(
                child: InkWell(
                  onTap: () {
                    FireDataBase().sendGroubMessage(
                        msg: 'Say Assalamu Alaikum 👋',
                        groupId: widget.groubModel.id!);
                  },
                  child: WelcomeMessage(),
                ),
              );
            }
          } else {
            return Container();
          }
        });
  }
}
