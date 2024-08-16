import 'package:flutter/material.dart';

class AddPhoto extends StatelessWidget {
  const AddPhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        CircleAvatar(
          radius: 40,
        ),
        Positioned(
          bottom: -10,
          right: -10,
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.add_a_photo),
          ),
        )
      ],
    );
  }
}

