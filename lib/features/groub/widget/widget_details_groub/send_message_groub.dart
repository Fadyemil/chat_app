import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SendMessageGroub extends StatelessWidget {
  const SendMessageGroub({
    super.key, required this.sendMessageGroub,
  });
  final  TextEditingController sendMessageGroub;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        controller: sendMessageGroub,
        maxLines: 5,
        minLines: 1,
        decoration: InputDecoration(
          suffixIcon: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.emoji_happy),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.camera),
              ),
            ],
          ),
          border: InputBorder.none,
          hintText: "Message",
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 10),
        ),
      ),
    );
  }
}
