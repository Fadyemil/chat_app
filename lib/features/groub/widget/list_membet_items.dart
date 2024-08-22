import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/groub/widget/member_items.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListMembetItems extends StatelessWidget {
  const ListMembetItems({
    super.key,
    required this.groubModel,
  });
  final GroubModel groubModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('id', whereIn: groubModel.members)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ChatUserModel> members = snapshot.data!.docs
                .map((e) => ChatUserModel.fromJson(e.data()))
                .toList();
            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                return MemberItems(
                  groubModel: groubModel,
                  members: members[index],
                );
              },
            );
          } else {
           return Center(child: CircularProgressIndicator());
          }
        });
  }
}
