import 'package:chat_app/core/widget/text_field.dart';
import 'package:chat_app/features/contact/widget/button_add_contact.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddContact extends StatelessWidget {
  const AddContact({
    super.key,
    required this.emailCon,
  });

  final TextEditingController emailCon;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 16),
        ButtonAddContact(emailCon: emailCon)
      ],
    );
  }
}
