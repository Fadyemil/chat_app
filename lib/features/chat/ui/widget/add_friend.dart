import 'package:chat_app/core/widget/text_field.dart';
import 'package:chat_app/features/chat/logic/cubit/create_room_cubit.dart';
import 'package:chat_app/features/chat/ui/widget/bloc_cunsumer_create_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class AddFriend extends StatefulWidget {
  const AddFriend({
    super.key,
  });


  @override
  State<AddFriend> createState() => _AddFriendState();
}

class _AddFriendState extends State<AddFriend> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Enter Friend Email",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Iconsax.scan_barcode),
              )
            ],
          ),
          CustomField(
            controller: context.read<CreateRoomCubit>().emailCreateRoom,
            icon: Iconsax.direct,
            lable: "Email",
          ),
          const SizedBox(height: 16),
          const BlocCunsumerCreateRoom(),
        ],
      ),
    );
  }
}
