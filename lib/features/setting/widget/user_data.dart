// import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          var me = context.read<GetUserCubit>().me!;
          return ListTile(
            minVerticalPadding: 40,
            leading: me.image == ""
                ? CircleAvatar(
                    radius: 30,
                  )
                : CircleAvatar(
                    radius: 30,
                    child: CachedNetworkImage(
                      height: 60,
                      width: 60,
                      fit: BoxFit.fill,
                      imageUrl: me.image!,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
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
