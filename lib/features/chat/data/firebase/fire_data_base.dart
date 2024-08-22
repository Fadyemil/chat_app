import 'dart:async';

import 'package:chat_app/core/models/chat_room_model.dart';
import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/core/models/message_model.dart';
// import 'package:chat_app/features/chat/ui/widget/list_message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class FireDataBase {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final String myUid = FirebaseAuth.instance.currentUser!.uid;

  String now = DateTime.now().millisecondsSinceEpoch.toString();

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
          createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
          members: members,
          lastMessage: '',
          latestMessageTime: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        await firestore
            .collection('rooms')
            .doc(members.toString())
            .set(chatRoomModel.toJson());
      }
    }
  }

  Future createGroub({required String name, required List members}) async {
    String gid = Uuid().v1();
    members.add(myUid);
    GroubModel groubModel = GroubModel(
      id: gid,
      name: name,
      image: '',
      members: members,
      admin: [myUid],
      lastMessage: '',
      lastMessageTime: now,
      createdAt: now,
    );

    await firestore.collection('groups').doc(gid).set(groubModel.toJson());
  }

  Future addContact({required String email}) async {
    QuerySnapshot userEmail = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    if (userEmail.docs.isNotEmpty) {
      String userId = userEmail.docs.first.id;
      await firestore.collection('users').doc(myUid).update(
        {
          'my_users': FieldValue.arrayUnion([userId]),
        },
      );
    }
  }

  Future sendMessage(
      {required String uid,
      required String msg,
      required String roomId,
      String? type}) async {
    String msgId = Uuid().v1();
    MessageModel messageModel = MessageModel(
      id: msgId,
      toId: uid,
      fromId: myUid,
      msg: msg,
      type: type ?? 'text',
      read: '',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .set(messageModel.toJson());

    firestore.collection('rooms').doc(roomId).update({
      'last_message': type ?? msg,
      'latest_message_time': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  Future readMessage({required String roomId, required String msgId}) async {
    await firestore
        .collection('rooms')
        .doc(roomId)
        .collection('messages')
        .doc(msgId)
        .update({
      'read': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  deleteMsg({
    required String roomId,
    required List<String> selectedMsg,
  }) async {
    for (var element in selectedMsg) {
      await firestore
          .collection('rooms')
          .doc(roomId)
          .collection('messages')
          .doc(element)
          .delete();
    }
    selectedMsg.clear();
  }
}
