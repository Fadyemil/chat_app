import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class SendMessageField extends StatelessWidget {
  const SendMessageField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        controller: controller,
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
                onPressed: () async {
                  ImagePicker picker = ImagePicker();
                  XFile? image =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    print(image.path);
                  }
                },
                icon: const Icon(Iconsax.camera),
              ),
            ],
          ),
          border: InputBorder.none,
          hintText: "Message",
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
    );
  }
}
