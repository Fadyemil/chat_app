import 'package:chat_app/features/chat/logic/cubit/create_room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonCreateRoom extends StatelessWidget {
  const ButtonCreateRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      onPressed: () {
        if (context
            .read<CreateRoomCubit>()
            .emailCreateRoom
            .text
            .isNotEmpty) {
          context.read<CreateRoomCubit>().createRoom();
        }
      },
      child: const Center(
        child: Text("Create Chat"),
      ),
    );
  }
}
