import 'package:chat_app/core/widget/text_field.dart';
import 'package:chat_app/features/groub/widget/widget_create_groub/AddPhoto.dart';
import 'package:chat_app/features/groub/widget/widget_create_groub/AddMembersGroub.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EditGroupScreen extends StatefulWidget {
  const EditGroupScreen({super.key});

  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  TextEditingController gNameCon = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gNameCon.text = " Name";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Done"),
        icon: const Icon(Iconsax.tick_circle),
      ),
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
            const Row(
              children: [
                Text("Add Members"),
                Spacer(),
                Text("0"),
              ],
            ),
            const SizedBox(height: 16),
            const Expanded(
              child: AddMembersGroub(),
            )
          ],
        ),
      ),
    );
  }
}
