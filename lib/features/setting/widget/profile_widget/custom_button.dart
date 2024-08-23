import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatefulWidget {
  CustomButton({
    super.key,
    required this.namecon,
    required this.aboutCon,
    this.aboutEdit,
    this.nameEdit,
  });
  final TextEditingController namecon;
  final TextEditingController aboutCon;
  bool? nameEdit;
  bool? aboutEdit;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (widget.aboutCon.text.isNotEmpty || widget.namecon.text.isNotEmpty) {
          setState(() {
            FireDataBase()
                .editProfiel(
                    name: widget.namecon.text, about: widget.aboutCon.text)
                .then((val) {
              setState(() {
                widget.aboutEdit = false;
                widget.nameEdit = false;
              });
            });
          });
        }
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
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
