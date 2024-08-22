import 'dart:developer';

import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/features/groub/screen/group_member_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

AppBar AppBarDetailsFroubScreen(context, GroubModel groubModel) {
  return AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(groubModel.name!),
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('id', whereIn: groubModel.members)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List membersName = [];
                for (var element in snapshot.data!.docs) {
                  membersName.add(element.data()['name']);
                }
                return Text(
                  membersName.join(', '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelLarge,
                );
              } else {
                return Container();
              }
            }),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          log('Admin List: ${groubModel.admin}');
          log('Current User ID: ${FirebaseAuth.instance.currentUser!.uid}');
          bool isAdmin = groubModel.admin!
              .contains(FirebaseAuth.instance.currentUser!.uid);
          log(isAdmin.toString());
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupMemberScreen(
                groubModel: groubModel,
              ),
            ),
          );
        },
        icon: const Icon(Iconsax.user),
      ),
      // IconButton(
      //   onPressed: () {},
      //   icon: const Icon(Iconsax.copy),
      // ),
    ],
  );
}
