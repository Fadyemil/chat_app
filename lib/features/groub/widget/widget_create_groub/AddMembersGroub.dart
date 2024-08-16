import 'package:flutter/material.dart';

class AddMembersGroub extends StatelessWidget {
  const AddMembersGroub({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CheckboxListTile(
          checkboxShape: CircleBorder(),
          title: Text("Nabil"),
          value: true,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          checkboxShape: CircleBorder(),
          title: Text("Nabil"),
          value: false,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
