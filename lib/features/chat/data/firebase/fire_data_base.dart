import 'dart:async';
import 'dart:developer';

import 'package:chat_app/core/models/chat_room_model.dart';
import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/core/models/cloud_messaging.dart';
import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/core/models/message_model.dart';
// import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
// import 'package:chat_app/features/chat/ui/widget/list_message_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
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
    log('Group Data Before Saving: ${groubModel.toJson()}');

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

  Future sendMessage({
    required String uid,
    required String msg,
    required String roomId,
    required BuildContext context,
    required ChatUserModel chatUsers,
    String? type,
  }) async {
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
        .set(messageModel.toJson())
        .then((value) {
      PushNotificationService.sendNotificationToAdmin(
          chatUser: chatUsers, context: context, messageBody: type ?? msg);
    });

    await firestore.collection('rooms').doc(roomId).update({
      'last_message': type ?? msg,
      'latest_message_time': DateTime.now().millisecondsSinceEpoch.toString(),
    });
  }

  Future sendGroubMessage({
    required String msg,
    required String groupId,
    required BuildContext context,
    required GroubModel chatGroup,
    String? type,
  }) async {
    List<ChatUserModel> chatUsers = [];
    chatGroup.members =
        chatGroup.members!.where((element) => element != myUid).toList();
    firestore
        .collection('users')
        .where('id', whereIn: chatGroup.members)
        .get()
        .then(
          (value) => chatUsers.addAll(
            value.docs.map(
              (e) => ChatUserModel.fromJson(e.data()),
            ),
          ),
        );
    String msgId = Uuid().v1();
    MessageModel messageModel = MessageModel(
      id: msgId,
      toId: '',
      fromId: myUid,
      msg: msg,
      type: type ?? 'text',
      read: '',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
    );

    await firestore
        .collection('groups')
        .doc(groupId)
        .collection('messages')
        .doc(msgId)
        .set(messageModel.toJson())
        .then(
      (value) {
        for (var element in chatUsers) {
          PushNotificationService.sendNotificationToAdmin(
            chatUser: element,
            context: context,
            messageBody: type ?? msg,
            groupName: chatGroup.name,
          );
        }
      },
    );

    await firestore.collection('groups').doc(groupId).update({
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

  Future editGroup({required String gid, String? name, List? members}) async {
    await firestore.collection('groups').doc(gid).update({
      'name': name,
      'members': FieldValue.arrayUnion(members!),
    });
  }

  Future removeMember({required String gid, required String memberId}) async {
    await firestore.collection('groups').doc(gid).update({
      'members': FieldValue.arrayRemove([memberId]),
    });
  }

  Future prompAdmin({required String gid, required String memberId}) async {
    await firestore.collection('groups').doc(gid).update({
      'admins_id': FieldValue.arrayUnion([memberId]),
    });
  }

  Future removeAdmin({required String gid, required String memberId}) async {
    await firestore.collection('groups').doc(gid).update({
      'admins_id': FieldValue.arrayRemove([memberId]),
    });
  }

  Future editProfiel({String? name, String? about}) async {
    await firestore.collection('users').doc(myUid).update({
      'name': name,
      'about': about,
    });
  }
}
