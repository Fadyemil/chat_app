import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/features/chat/data/firebase/fire_storage.dart';
import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class MyPhoto extends StatefulWidget {
  const MyPhoto({
    super.key,
  });

  @override
  State<MyPhoto> createState() => _MyPhotoState();
}

class _MyPhotoState extends State<MyPhoto> {
  String img = '';

  @override
  Widget build(BuildContext context) {
    var me = context.read<GetUserCubit>().me;
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          img == ""
              ? me!.image == ""
                  ? CircleAvatar(
                      radius: 70,
                    )
                  : CircleAvatar(
                      radius: 70,
                      child: CachedNetworkImage(
                        height: 140,
                        width: 140,
                        fit: BoxFit.fill,
                        imageUrl: me.image!,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    )
              : CircleAvatar(
                  radius: 70,
                  backgroundImage: FileImage(File(img)),
                ),
          Positioned(
            bottom: -5,
            right: -5,
            child: IconButton.filled(
              onPressed: () async {
                ImagePicker imagePicker = ImagePicker();
                XFile? image =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  setState(() {
                    img = image.path;
                  });
                  FireStorage().updateProfileImage(file: File(image.path));
                  log(image.path);
                }
              },
              icon: const Icon(Iconsax.edit),
            ),
          )
        ],
      ),
    );
  }
}
// CachedNetworkImage(
//                               imageUrl: widget.messageitem.msg!,
//                               progressIndicatorBuilder:
//                                   (context, url, downloadProgress) =>
//                                       CircularProgressIndicator(
//                                           value: downloadProgress.progress),
//                               errorWidget: (context, url, error) =>
//                                   const Icon(Icons.error),
//                             ),