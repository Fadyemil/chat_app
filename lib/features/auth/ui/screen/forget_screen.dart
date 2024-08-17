import 'package:chat_app/core/widget/text_field.dart';
import 'package:chat_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/ui/widget/bloc_Cunsumer_Reset_Email.dart';
import 'package:chat_app/features/auth/ui/widget/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const LogoApp(),
              const SizedBox(height: 20),
              Text(
                "Reset Password,",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "Please Enter Your Email",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              CustomField(
                controller: context.read<AuthCubit>().emailReset,
                lable: "Email",
                icon: Iconsax.direct,
              ),
              const SizedBox(height: 16),
              const BlocCunsumerResetEmail(),
            ],
          ),
        ),
      ),
    );
  }
}