import 'package:chat_app/features/groub/screen/edit_group_screen.dart';
import 'package:chat_app/features/groub/widget/list_membet_items.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupMemberScreen extends StatefulWidget {
  const GroupMemberScreen({super.key});

  @override
  State<GroupMemberScreen> createState() => _GroupMemberScreenState();
}

class _GroupMemberScreenState extends State<GroupMemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group members"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditGroupScreen(),
                  ));
            },
            icon: const Icon(Iconsax.user_edit),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListMembetItems(),
            ),
          ],
        ),
      ),
    );
  }
}
