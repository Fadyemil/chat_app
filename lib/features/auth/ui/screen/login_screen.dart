import 'package:chat_app/core/widget/text_field.dart';
import 'package:chat_app/features/auth/ui/widget/create_account_button.dart';
import 'package:chat_app/features/auth/ui/widget/forget_password.dart';
import 'package:chat_app/features/auth/ui/widget/login_button.dart';
import 'package:chat_app/features/auth/ui/widget/logo_app.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailCon = TextEditingController();
    TextEditingController passCon = TextEditingController();
    final formKey = GlobalKey<FormState>();
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
                key: formKey,
                child: Column(
                  children: [
                    CustomField(
                      controller: emailCon,
                      lable: "Email",
                      icon: Iconsax.direct,
                    ),
                    CustomField(
                      controller: passCon,
                      lable: "Password",
                      icon: Iconsax.password_check,
                      isPass: true,
                    ),
                    const SizedBox(height: 16),
                    ForgetPassword(),
                    const SizedBox(height: 16),
                    LogInButton(),
                    const SizedBox(height: 16),
                    CreateAccountButton(),
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
