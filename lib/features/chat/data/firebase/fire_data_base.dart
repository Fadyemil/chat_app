import 'package:chat_app/core/models/chat_room_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireDataBase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String myUid = FirebaseAuth.instance.currentUser!.uid;

  Future createRoom(String email) async {
    QuerySnapshot userEmail = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      List<String> members = [myUid, userId]..sort(
          (a, b) {
            return a.compareTo(b);
          },
        );

      QuerySnapshot roomExists = await firestore
          .collection('rooms')
          .where('members', isEqualTo: members)
          .get();
      if (roomExists.docs.isEmpty) {
        ChatRoomModel chatRoomModel = ChatRoomModel(
          id: members.toString(),
          createdAt: DateTime.now().toString(),
          members: members,
          lastMessage: '',
          latestMessageTime: DateTime.now().toString(),
        );

        await firestore
            .collection('rooms')
            .doc(members.toString())
            .set(chatRoomModel.toJson());
      }
    }
  }
}
