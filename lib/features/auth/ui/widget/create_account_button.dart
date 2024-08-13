import 'package:chat_app/features/auth/ui/screen/setup_profile.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(16),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => SetupProfile(),
            ),
            (route) => false);
      },
      child: Center(
        child: Text(
          "Create Account".toUpperCase(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
