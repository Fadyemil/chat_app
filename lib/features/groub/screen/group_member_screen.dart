import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/groub/screen/edit_group_screen.dart';
import 'package:chat_app/features/groub/widget/list_membet_items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class GroupMemberScreen extends StatefulWidget {
  const GroupMemberScreen({super.key, required this.groubModel});
  final GroubModel groubModel;

  @override
  State<GroupMemberScreen> createState() => _GroupMemberScreenState();
}

class _GroupMemberScreenState extends State<GroupMemberScreen> {
  @override
  Widget build(BuildContext context) {
    bool isAdmin = widget.groubModel.admin!
        .contains(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group members"),
        actions: [
          isAdmin
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditGroupScreen(
                            groubModel: widget.groubModel,
                            // members: widget.groubModel.members,
                            // onMembersUpdated: () {},
                          ),
                        ));
                  },
                  icon: const Icon(Iconsax.user_edit),
                )
              : Container(),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListMembetItems(
                groubModel: widget.groubModel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
