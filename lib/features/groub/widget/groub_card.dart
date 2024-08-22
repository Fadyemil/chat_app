import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/groub/screen/details_groub_screen.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.ChatGroup,
  });
  final GroubModel ChatGroup;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailsGroubScreen(
                    groubModel: ChatGroup,
                  )),
        ),
        leading: CircleAvatar(
          child: Text(ChatGroup.name!.characters.first),
        ),
        title: Text(ChatGroup.name!),
        subtitle: Text(
          ChatGroup.lastMessage == ""
              ? 'send first message'
              : ChatGroup.lastMessage!,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Text(ChatGroup.lastMessageTime!),
        // trailing: const Badge(
        //   padding: EdgeInsets.symmetric(horizontal: 12),
        //   label: Text("3"),
        //   largeSize: 30,
        // ),
      ),
    );
  }
}
