import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
import 'package:chat_app/features/setting/widget/profile_widget/custom_button.dart';
import 'package:chat_app/features/setting/widget/profile_widget/email_phone.dart';
import 'package:chat_app/features/setting/widget/profile_widget/my_about.dart';
import 'package:chat_app/features/setting/widget/profile_widget/my_name.dart';
import 'package:chat_app/features/setting/widget/profile_widget/my_photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController aboutCon = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameCon.text = context.read<GetUserCubit>().me!.name!;
    aboutCon.text = context.read<GetUserCubit>().me!.about!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyPhoto(),
              const SizedBox(height: 20),
              Card(child: MyName(nameCon: nameCon)),
              Card(child: MyAbout(nameCon: aboutCon)),
              const Card(child: Email()),
              const Card(child: phone()),
              const SizedBox(height: 20),
              CustomButton(),
            ],
          ),
        ),
      ),
    );
  }
}
