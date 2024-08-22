import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/core/models/groub_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MemberItems extends StatelessWidget {
  const MemberItems({
    super.key,
    required this.groubModel,
    required this.members,
  });
  final GroubModel groubModel;
  final ChatUserModel members;
  @override
  Widget build(BuildContext context) {
    bool isAdmin =
        groubModel.admin!.contains(FirebaseAuth.instance.currentUser!.uid);
    bool admin = groubModel.admin!.contains(members.id);
    return ListTile(
      title: Text(members.name!),
      subtitle: admin
          ? Text(
              "Admin",
              style: TextStyle(color: Colors.green),
            )
          : Text('member'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isAdmin
              ? IconButton(onPressed: () {}, icon: Icon(Iconsax.user_tick))
              : Container(),
          isAdmin
              ? IconButton(onPressed: () {}, icon: Icon(Iconsax.trash))
              : Container(),
        ],
      ),
    );
  }
}
