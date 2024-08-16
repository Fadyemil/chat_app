import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)),
        backgroundColor:
            Theme.of(context).colorScheme.primaryContainer,
        padding: const EdgeInsets.all(16),
      ),
      child: Center(
        child: Text(
          "Save".toUpperCase(),
          // style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
