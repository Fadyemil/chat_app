
import 'package:chat_app/core/utlie/colors.dart';
import 'package:chat_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetButton extends StatelessWidget {
  const ResetButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AuthCubit>().resetPassword();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: kPrimaryColor,
        padding: const EdgeInsets.all(16),
      ),
      child: Center(
        child: Text(
          "Send Email".toUpperCase(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
