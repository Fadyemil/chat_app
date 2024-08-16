import 'package:chat_app/features/groub/screen/create_groub_screen.dart';
import 'package:chat_app/features/groub/widget/list_groub.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroubScreen extends StatelessWidget {
  const GroubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateGroubScreen(),
            ),
          );
        },
        child: const Icon(Iconsax.message_add_1),
      ),
      appBar: AppBar(title: Text("Group")),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: ListGroub(),
            )
          ],
        ),
      ),
    );
  }
}
