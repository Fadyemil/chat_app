import 'package:chat_app/features/setting/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Profile"),
      leading: Icon(Iconsax.user),
      trailing: Icon(Iconsax.arrow_right_3),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(),
          )),
    );
  }
}

