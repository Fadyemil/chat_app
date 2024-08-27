// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireStorage {
  final FirebaseStorage fireStorage = FirebaseStorage.instance;

  Future<void> sendImage({
    required File file,
    required String roomId,
    required String userId,
    required BuildContext context,
    required ChatUserModel chatUser,
  }) async {
    try {
      String ext = file.path.split('.').last;

      final ref = fireStorage
          .ref()
          .child('image/$roomId/${DateTime.now().millisecondsSinceEpoch}.$ext');

      // رفع الملف وانتظار انتهاء العملية
      UploadTask uploadTask = ref.putFile(file);

      // انتظار انتهاء الرفع والحصول على الرابط
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await snapshot.ref.getDownloadURL();

      // إرسال رسالة تحتوي على رابط الصورة
      await FireDataBase().sendMessage(
        uid: userId,
        msg: imageUrl,
        roomId: roomId,
        type: 'image',
        context: context,
        chatUsers: chatUser,
      );

      log('Image URL: $imageUrl');
    } catch (e) {
      log('Error uploading image: $e');
    }
  }

  Future<void> sendImageGroup({
    required File file,
    required String groupId,
    required BuildContext context,
    required GroubModel chatGroup,
  }) async {
    try {
      String ext = file.path.split('.').last;

      final ref = fireStorage.ref().child(
          'image/$groupId/${DateTime.now().millisecondsSinceEpoch}.$ext');

      // رفع الملف وانتظار انتهاء العملية
      UploadTask uploadTask = ref.putFile(file);

      // انتظار انتهاء الرفع والحصول على الرابط
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await snapshot.ref.getDownloadURL();

      // إرسال رسالة تحتوي على رابط الصورة
      await FireDataBase().sendGroubMessage(
        msg: imageUrl,
        groupId: groupId,
        context: context,
        chatGroup: chatGroup,
        type: 'image',
      );

      log('Image URL: $imageUrl');
    } catch (e) {
      log('Error uploading image: $e');
    }
  }

  Future<void> updateProfileImage({
    required File file,
    // required String roomId,
    // required String userId,
  }) async {
    try {
      String ext = file.path.split('.').last;
      String userId = FirebaseAuth.instance.currentUser!.uid;
      final ref = fireStorage.ref().child(
          'progile/$userId/${DateTime.now().millisecondsSinceEpoch}.$ext');

      // رفع الملف وانتظار انتهاء العملية
      UploadTask uploadTask = ref.putFile(file);

      // انتظار انتهاء الرفع والحصول على الرابط
      TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await snapshot.ref.getDownloadURL();

      // إرسال رسالة تحتوي على رابط الصورة
      // await FireDataBase().sendMessage(
      //   uid: userId,
      //   msg: imageUrl,
      //   roomId: roomId,
      //   type: 'image',
      // );
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'image': imageUrl,
      });

      log('Profile image URL: $imageUrl');

      log('Image URL: $imageUrl');
    } catch (e) {
      log('Error uploading image: $e');
    }
  }
}
