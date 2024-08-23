import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class phone extends StatelessWidget {
  const phone({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Iconsax.timer_1),
      title: Text("Joined On"),
      subtitle: Text(
        context.read<GetUserCubit>().me!.createdAt.toString(),
      ),
    );
  }
}

class Email extends StatelessWidget {
  const Email({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(Iconsax.direct),
        title: Text("Email"),
        subtitle: Text(context.read<GetUserCubit>().me!.email!));
  }
}
