import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class MyName extends StatelessWidget {
  const MyName({
    super.key,
    required this.nameCon,
  });

  final TextEditingController nameCon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserCubit, GetUserState>(
      builder: (context, state) {
        if (state is GetUser) {
          return ListTile(
            leading: const Icon(Iconsax.user_octagon),
            trailing:
                IconButton(onPressed: () {}, icon: const Icon(Iconsax.edit)),
            title: TextField(
              controller: nameCon,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'name',
                border: InputBorder.none,
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
