import 'package:chat_app/features/chat/logic/cubit/create_room_cubit.dart';
import 'package:chat_app/features/chat/ui/widget/button_create_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCunsumerCreateRoom extends StatelessWidget {
  const BlocCunsumerCreateRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateRoomCubit, CreateRoomState>(
      listener: (context, state) {
        if (state is CreateRoomSuccess) {
          context.read<CreateRoomCubit>().emailCreateRoom.clear();
          Navigator.pop(context);
        } else if (state is CreateRoomFailer) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is CreateRoomLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return const ButtonCreateRoom();
      },
    );
  }
}

