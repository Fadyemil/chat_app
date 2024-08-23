import 'package:bloc/bloc.dart';
import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'get_user_state.dart';

class GetUserCubit extends Cubit<GetUserState> {
  GetUserCubit() : super(GetUserInitial());
  ChatUserModel? me;
  getUserDetails() async {
    String MyId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('users').doc(MyId).get().then(
          (value) => me = ChatUserModel.fromJson(value.data()!),
        );
    emit(GetUser());
  }
}
