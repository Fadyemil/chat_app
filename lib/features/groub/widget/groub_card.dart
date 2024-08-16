import 'package:chat_app/features/groub/screen/details_groub_screen.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailsGroubScreen()),
              ),
          leading: const CircleAvatar(
            child: Text("G"),
          ),
          title: const Text("Group Name"),
          subtitle: const Text("Last Message"),
          trailing: const Badge(
            padding: EdgeInsets.symmetric(horizontal: 12),
            label: Text("3"),
            largeSize: 30,
          )),
    );
  }
}