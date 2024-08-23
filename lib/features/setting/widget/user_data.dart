// import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
import 'package:chat_app/features/setting/screen/qr_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class userData extends StatelessWidget {
  const userData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ChatUserModel? me = context.read<GetUserCubit>().me;
    return BlocBuilder<GetUserCubit, GetUserState>(
      builder: (context, state) {
        if (state is GetUser) {
          return ListTile(
            minVerticalPadding: 40,
            leading: CircleAvatar(
              radius: 30,
            ),
            title: Text(context.read<GetUserCubit>().me!.name!),
            trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QrCodeScreen(),
                      ));
                },
                icon: Icon(Iconsax.scan_barcode)),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
