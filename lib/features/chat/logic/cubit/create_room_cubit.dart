import 'package:bloc/bloc.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'create_room_state.dart';

class CreateRoomCubit extends Cubit<CreateRoomState> {
  CreateRoomCubit() : super(CreateRoomInitial());

  TextEditingController emailCreateRoom = TextEditingController();

  createRoom() async {
    emit(CreateRoomLoading());
    try {
      await FireDataBase().createRoom(emailCreateRoom.text);
      emit(CreateRoomSuccess());
    } catch (e) {
      emit(CreateRoomFailer(e.toString()));
    }
  }
}
