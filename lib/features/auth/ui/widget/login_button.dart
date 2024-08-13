import 'package:chat_app/core/utlie/colors.dart';
import 'package:flutter/material.dart';

class LogInButton extends StatelessWidget {
  const LogInButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        backgroundColor: kPrimaryColor,
        padding: const EdgeInsets.all(16),
      ),
      child: Center(
        child: Text(
          "Login".toUpperCase(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
