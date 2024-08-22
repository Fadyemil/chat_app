import 'package:chat_app/core/widget/text_field.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:chat_app/features/groub/widget/widget_create_groub/AddPhoto.dart';
import 'package:chat_app/features/groub/widget/widget_create_groub/AddMembersGroub.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CreateGroubScreen extends StatefulWidget {
  const CreateGroubScreen({super.key});
  @override
  State<CreateGroubScreen> createState() => _CreateGroubScreenState();
}

class _CreateGroubScreenState extends State<CreateGroubScreen> {
  TextEditingController gNameCon = TextEditingController();
  List<String> members = [];
  void _updateMembers() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: members.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                FireDataBase()
                    .createGroub(name: gNameCon.text, members: members)
                    .then((value) {
                  Navigator.pop(context);
                  setState(() {
                    members = [];
                  });
                });
              },
              label: const Text("Done"),
              icon: const Icon(Iconsax.tick_circle),
            )
          : Container(),
      appBar: AppBar(
        title: const Text("Create Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: AddPhoto(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomField(
                    controller: gNameCon,
                    icon: Iconsax.user_octagon,
                    lable: "Group Name",
                  ),
                ),
              ],
            ),
            const Divider(
              height: 32,
              thickness: 2,
            ),
            Row(
              children: [
                Text("Members"),
                Spacer(),
                Text(members.length.toString()),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AddMembersGroub(
                members: members,
                onMembersUpdated: _updateMembers,
              ),
            )
          ],
        ),
      ),
    );
  }
}
