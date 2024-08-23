import 'dart:developer';
import 'dart:io';

import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireStorage {
  final FirebaseStorage fireStorage = FirebaseStorage.instance;

  Future<void> sendImage({
    required File file,
    required String roomId,
    required String userId,
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
