import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/groub/widget/member_items.dart';
import 'package:flutter/material.dart';

class ListMembetItems extends StatelessWidget {
  const ListMembetItems({
    super.key,
    required this.groubModel,
  });
  final GroubModel groubModel;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return MemberItems(
                groubModel: groubModel,
              );
            },
          );
        });
  }
}
