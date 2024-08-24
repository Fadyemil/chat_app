// import 'package:chat_app/core/models/cloud_messaging.dart';
// import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
import 'package:chat_app/features/setting/widget/change_mode.dart';
import 'package:chat_app/features/setting/widget/change_theme.dart';
import 'package:chat_app/features/setting/widget/profile_item.dart';
import 'package:chat_app/features/setting/widget/signout_item.dart';
import 'package:chat_app/features/setting/widget/user_data.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // PushNotificationService.sendNotificationToAdmin(
          //   deviceToken: context.read<GetUserCubit>().me!.puchToken!,
          //   context: context,
          //   // tripId,
          //   messageBody: 'Hello world',
          // );
        },
        child: Icon(Icons.send_sharp),
      ),
      appBar: AppBar(title: const Text("Settings")),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            userData(),
            Card(
              child: ProfileItem(),
            ),
            Card(
              child: changeTheme(),
            ),
            Card(child: ChangeMode()),
            Card(child: SignoutItem()),
          ]),
        ),
      ),
    );
  }
}
