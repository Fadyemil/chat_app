import 'package:chat_app/core/widget/text_field.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddFriend extends StatelessWidget {
  const AddFriend({
    super.key,
    required this.emailCon,
  });

  final TextEditingController emailCon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                "Enter Friend Email",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              IconButton.filled(
                onPressed: () {},
                icon: const Icon(Iconsax.scan_barcode),
              )
            ],
          ),
          CustomField(
            controller: emailCon,
            icon: Iconsax.direct,
            lable: "Email",
          ),
          const SizedBox(
            height: 16
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor:
                    Theme.of(context).colorScheme.primaryContainer),
            onPressed: () {},
            child: const Center(
              child: Text("Create Chat"),
            ),
          ),
        ],
      ),
    );
  }
}
