import 'package:chat_app/features/auth/ui/screen/forget_screen.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        GestureDetector(
          child: const Text("Forget Password?"),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ForgetScreen(),
              ),
            );
          },
        )
      ],
    );
  }
}
