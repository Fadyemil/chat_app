import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:flutter/material.dart';

class ButtonAddContact extends StatefulWidget {
  const ButtonAddContact({
    super.key,
    required this.emailCon,
  });
  final TextEditingController emailCon;

  @override
  State<ButtonAddContact> createState() => _ButtonAddContactState();
}

class _ButtonAddContactState extends State<ButtonAddContact> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer),
      onPressed: () {
        FireDataBase().addContact(email: widget.emailCon.text).then((value) {
          setState(() {
            widget.emailCon.clear();
          });
          Navigator.pop(context);
        });
      },
      child: const Center(
        child: Text("Add Contact"),
      ),
    );
  }
}
