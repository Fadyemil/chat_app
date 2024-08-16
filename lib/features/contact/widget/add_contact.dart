import 'package:chat_app/core/widget/text_field.dart';
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
            Spacer(),
            IconButton.filled(
              onPressed: () {},
              icon: Icon(Iconsax.scan_barcode),
            )
          ],
        ),
        CustomField(
          controller: emailCon,
          icon: Iconsax.direct,
          lable: "Email",
        ),
        SizedBox(
          height: 16
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              backgroundColor:
                  Theme.of(context).colorScheme.primaryContainer),
          onPressed: () {},
          child: Center(
            child: Text("Add Contact"),
          ),
        )
      ],
    );
  }
}
