import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireAuth {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  static User user = auth.currentUser!;

  //^ Method to create a new user and save their information in Firestore
  static Future createUser() async {
    //^ Creating a ChatUserModel object with user information
    ChatUserModel chatUserModel = ChatUserModel(
      id: user.uid, //~ Unique ID for the user
      name: user.displayName ?? "",
      email: user.email ?? "",
      about: "Hi I'm ENG/Fady",
      image: '',
      createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      lastActivated: DateTime.now().millisecondsSinceEpoch.toString(),
      puchToken: '',
      online: false,
      myUsers: [],
    );
    //~ Saving the user information to Firestore under the 'users' collection
    await firebaseFirestore
        .collection('users')
        .doc(chatUserModel.id) //~ Document ID is the user's unique ID
        .set(chatUserModel.toJson()); //~ Storing data as JSON
  }

  Future getToken({required String token}) async {
    await firebaseFirestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .update(
      {
        'puch_token': token,
      },
    );
  }
}
