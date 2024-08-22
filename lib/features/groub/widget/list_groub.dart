import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/groub/widget/groub_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListGroub extends StatelessWidget {
  const ListGroub({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('groups')
            .where('members',
                arrayContains: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<GroubModel> items = snapshot.data!.docs
                .map((e) => GroubModel.formJson(e.data()))
                .toList()
              ..sort(
                  (a, b) => a.lastMessageTime!.compareTo(b.lastMessageTime!));
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GroupCard(
                  ChatGroup: items[index],
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
