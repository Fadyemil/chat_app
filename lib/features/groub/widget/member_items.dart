import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MemberItems extends StatefulWidget {
  const MemberItems({
    super.key,
    required this.groubModel,
    required this.members,
  });
  final GroubModel groubModel;
  final ChatUserModel members;

  @override
  State<MemberItems> createState() => _MemberItemsState();
}

class _MemberItemsState extends State<MemberItems> {
  @override
  Widget build(BuildContext context) {
    bool isAdmin = widget.groubModel.admin!
        .contains(FirebaseAuth.instance.currentUser!.uid);
    bool admin = widget.groubModel.admin!.contains(widget.members.id);
    String myId = FirebaseAuth.instance.currentUser!.uid;
    return ListTile(
      title: Text(widget.members.name!),
      subtitle: admin
          ? const Text(
              "Admin",
              style: TextStyle(color: Colors.green),
            )
          : const Text('member'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isAdmin && myId != widget.members.id
              ? IconButton(
                  onPressed: () {
                    if (admin) {
                      FireDataBase()
                          .removeAdmin(
                              gid: widget.groubModel.id!,
                              memberId: widget.members.id!)
                          .then((onValue) {
                        setState(() {
                          widget.groubModel.admin!.remove(widget.members.id!);
                          // Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Done')),
                          );
                        });
                      });
                    } else {
                      FireDataBase()
                          .prompAdmin(
                              gid: widget.groubModel.id!,
                              memberId: widget.members.id!)
                          .then((onValue) {
                        setState(() {
                          widget.groubModel.admin!.add(widget.members.id!);
                          // Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Done')),
                          );
                        });
                      });
                    }
                  },
                  icon: const Icon(Iconsax.user_tick))
              : Container(),
          isAdmin && myId != widget.members.id
              ? IconButton(
                  onPressed: () {
                    FireDataBase()
                        .removeMember(
                            gid: widget.groubModel.id!,
                            memberId: widget.members.id!)
                        .then((onValue) {
                      setState(() {
                        widget.groubModel.admin!.remove(widget.members.id!);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Done')),
                        );
                      });
                    });
                  },
                  icon: const Icon(Iconsax.trash))
              : Container(),
        ],
      ),
    );
  }
}
