import 'package:chat_app/core/widget/text_field.dart';
import 'package:chat_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/ui/widget/Bloc_ConsumerLogin.dart';
import 'package:chat_app/features/auth/ui/widget/bloc_consumer_create_acount.dart';
import 'package:chat_app/features/auth/ui/widget/forget_password.dart';
import 'package:chat_app/features/auth/ui/widget/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              const SizedBox(
                height: 20,
              ),
              Text(
                "Welcome Back,",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                "Material Chat App With Nabil AL Amawi",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Form(
                key: context.read<AuthCubit>().formKey,
                child: Column(
                  children: [
                    CustomField(
                      controller: context.read<AuthCubit>().emailLogin,
                      lable: "Email",
                      icon: Iconsax.direct,
                    ),
                    CustomField(
                      controller: context.read<AuthCubit>().passwordLogin,
                      lable: "Password",
                      icon: Iconsax.password_check,
                      isPass: true,
                    ),
                    const SizedBox(height: 16),
                    ForgetPassword(),
                    const SizedBox(height: 16),
                    BlocConsumerLogin(),
                    const SizedBox(height: 16),
                    BlocConsumerCreateAcount(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
