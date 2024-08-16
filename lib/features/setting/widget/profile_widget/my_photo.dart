import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class MyPhoto extends StatelessWidget {
  const MyPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const CircleAvatar(
            radius: 70,
          ),
          Positioned(
            bottom: -5,
            right: -5,
            child: IconButton.filled(
              onPressed: () {},
              icon: const Icon(Iconsax.edit),
            ),
          )
        ],
      ),
    );
  }
}
