import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

// ignore: must_be_immutable
class MyName extends StatefulWidget {
  MyName({
    super.key,
    required this.nameCon,
    this.nameEdit,
  });

  final TextEditingController nameCon;
  bool? nameEdit;
  @override
  State<MyName> createState() => _MyNameState();
}

class _MyNameState extends State<MyName> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserCubit, GetUserState>(
      builder: (context, state) {
        if (state is GetUser) {
          return ListTile(
            leading: const Icon(Iconsax.user_octagon),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    widget.nameEdit = true;
                  });
                },
                icon: const Icon(Iconsax.edit)),
            title: TextField(
              controller: widget.nameCon,
              enabled: widget.nameEdit,
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
