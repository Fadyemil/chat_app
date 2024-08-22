import 'dart:developer';

import 'package:chat_app/features/groub/logic/cubit/group_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddMembersGroub extends StatefulWidget {
  const AddMembersGroub({
    super.key,
    required this.members,
    required this.onMembersUpdated,
  });
  final List<String> members;
  final VoidCallback onMembersUpdated; // Define the callback type

  @override
  State<AddMembersGroub> createState() => _AddMembersGroubState();
}

class _AddMembersGroubState extends State<AddMembersGroub> {
  @override
  void initState() {
    super.initState();
    context.read<GroupCubit>().loadContacts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        if (state is GroupLaading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GroupSucces) {
          final contacts = state.contacts;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return CheckboxListTile(
                checkboxShape: CircleBorder(),
                title: Text(contacts[index].name!),
                value: widget.members.contains(contacts[index].id),
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      widget.members.add(contacts[index].id!);
                      log('Added member: ${contacts[index].id!}');
                    } else {
                      widget.members.remove(contacts[index].id!);
                      log('Removed member: ${contacts[index].id!}');
                    }
                  });
                  widget
                      .onMembersUpdated(); // Trigger the callback to update the state
                },
              );
            },
          );
        } else if (state is GroupError) {
          return Center(child: Text(state.error));
        } else {
          return const Center(child: Text('No contacts available.'));
        }
      },
    );
  }
}
// return ListView(
    //   children: [
    //     CheckboxListTile(
    //       checkboxShape: CircleBorder(),
    //       title: Text("Nabil"),
    //       value: true,
    //       onChanged: (value) {},
    //     ),
    //     CheckboxListTile(
    //       checkboxShape: CircleBorder(),
    //       title: Text("Nabil"),
    //       value: false,
    //       onChanged: (value) {},
    //     ),
    //   ],
    // );