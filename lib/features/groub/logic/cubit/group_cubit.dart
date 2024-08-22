import 'package:bloc/bloc.dart';
import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  GroupCubit() : super(GroupInitial());
  void loadContacts() {
    emit(GroupLaading());

    //* Listen to real-time changes in the current user's document in Firestore
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots() //* Activate real-time listening for changes in the document
        .listen((snapshot) async {
      try {
        //& Check if the user document exists
        if (snapshot.exists) {
          //& Retrieve the list of contact IDs from the 'my_users' field
          List<String> myContactIds =
              List<String>.from(snapshot.data()!['my_users']);

          //! If the contact list is empty, set it to a list with an empty string to prevent query issues
          if (myContactIds.isEmpty) myContactIds = [''];

          //~ Listen for changes in the 'users' collection based on the contact IDs
          FirebaseFirestore.instance
              .collection('users')
              .where('id',
                  whereIn:
                      myContactIds) //* Filter users based on the contact IDs
              .snapshots() //* Activate real-time listening for changes
              .listen((usersSnapshot) {
            // *Convert the retrieved documents into a list of ChatUserModel instances
            final List<ChatUserModel> contacts = usersSnapshot.docs
                .map((doc) => ChatUserModel.fromJson(doc.data()))
                .where((element) =>
                    element.id! != (FirebaseAuth.instance.currentUser!.uid))
                .toList()
              ..sort((a, b) => a.name!.compareTo(b.name!));

            emit(GroupSucces(contacts: contacts));
          });
        }
      } catch (e) {
        emit(GroupError(error: 'Failed to load contacts: $e'));
      }
    });
  }
}
