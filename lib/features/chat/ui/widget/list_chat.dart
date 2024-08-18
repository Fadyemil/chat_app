import 'package:chat_app/core/models/chat_room_model.dart';
import 'package:chat_app/features/chat/ui/widget/chat_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListChat extends StatelessWidget {
  const ListChat({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fetchChatRoomsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong."));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No chat rooms available."));
        } else {
          List<ChatRoomModel> items = _processChatRooms(snapshot.data!.docs);
          return _buildChatRoomsList(items);
        }
      },
    );
  }

  /// Fetches the chat rooms stream from Firestore.
  Stream<QuerySnapshot> _fetchChatRoomsStream() {
    return FirebaseFirestore.instance
        .collection('rooms')
        .where('members', arrayContains: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  /// Processes Firestore documents into a sorted list of ChatRoomModel.
  List<ChatRoomModel> _processChatRooms(List<QueryDocumentSnapshot> docs) {
    List<ChatRoomModel> chatRooms = docs
        .map(
            (doc) => ChatRoomModel.formJson(doc.data() as Map<String, dynamic>))
        .toList();

    chatRooms.sort((a, b) {
      return b.latestMessageTime!.compareTo(a.latestMessageTime!);
    });

    return chatRooms;
  }

  /// Builds the list of chat rooms using ListView.
  Widget _buildChatRoomsList(List<ChatRoomModel> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ChatCard(items: items[index]);
      },
    );
  }
}
