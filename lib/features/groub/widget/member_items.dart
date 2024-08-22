import 'package:chat_app/core/models/groub_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MemberItems extends StatelessWidget {
  const MemberItems({
    super.key,
    required this.groubModel,
  });
  final GroubModel groubModel;

  @override
  Widget build(BuildContext context) {
    bool isAdmin =
        groubModel.admin!.contains(FirebaseAuth.instance.currentUser!.uid);
    return ListTile(
      title: Text("Name"),
      subtitle: Text("Admin"),
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
