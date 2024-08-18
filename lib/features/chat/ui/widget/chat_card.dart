import 'package:chat_app/core/models/chat_room_model.dart';
import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/features/chat/ui/screen/details_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    super.key,
    required this.items,
  });

  final ChatRoomModel items;

  @override
  Widget build(BuildContext context) {
    final userId = _getUserId();
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading();
        }
        if (snapshot.hasError) {
          return _buildError();
        }
        if (snapshot.hasData) {
          final chatUserModel = _getChatUserModel(snapshot.data!);
          return _buildChatCard(context, chatUserModel);
        }
        return _buildEmpty();
      },
    );
  }

  /// Retrieves the ID of the other user in the chat room.
  /// It filters out the current user's ID from the list of members
  /// and returns the first matching ID (which is the other participant).
  String _getUserId() {
    return items.members!
        .where((element) => element != FirebaseAuth.instance.currentUser!.uid)
        .first;
  }

  /// Converts Firestore snapshot data into a ChatUserModel object.
  ChatUserModel _getChatUserModel(DocumentSnapshot snapshot) {
    return ChatUserModel.formJson(snapshot.data() as Map<String, dynamic>);
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError() {
    return const Center(child: Text('Error loading data'));
  }

  Widget _buildEmpty() {
    return const Center(child: Text('No data available'));
  }

  Widget _buildChatCard(BuildContext context, ChatUserModel chatUserModel) {
    return Card(
      child: ListTile(
        onTap: () => _navigateToDetails(context, chatUserModel),
        leading: const CircleAvatar(),
        title: Text(chatUserModel.name ?? 'Unknown'),
        subtitle: Text(items.lastMessage?.isEmpty ?? true
            ? chatUserModel.about ?? 'No information'
            : items.lastMessage!),
        trailing: _buildTrailing(),
      ),
    );
  }

  void _navigateToDetails(BuildContext context, ChatUserModel chatUserModel) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsChatScreen(
          roomId: items.id!,
          chatUserModel: chatUserModel,
        ),
      ),
    );
  }

  Widget _buildTrailing() {
    return 1 / 1 != 0
        ? const Badge(
            padding: EdgeInsets.symmetric(horizontal: 12),
            label: Text('3'),
            largeSize: 30,
          )
        : Text(items.latestMessageTime ?? '');
  }
}
