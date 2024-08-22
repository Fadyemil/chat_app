import 'dart:developer';

import 'package:chat_app/core/models/groub_model.dart';
import 'package:chat_app/core/widget/text_field.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:chat_app/features/groub/logic/cubit/group_cubit.dart';
import 'package:chat_app/features/groub/widget/widget_create_groub/AddPhoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class EditGroupScreen extends StatefulWidget {
  const EditGroupScreen({
    super.key,
    required this.groubModel,
    // required this.members,
    // required this.onMembersUpdated,
  });
  final GroubModel groubModel;
  // final List<String> members;
  // final VoidCallback onMembersUpdated; // Define the callback type
  @override
  State<EditGroupScreen> createState() => _EditGroupScreenState();
}

class _EditGroupScreenState extends State<EditGroupScreen> {
  TextEditingController gNameCon = TextEditingController();
  List members = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gNameCon.text = widget.groubModel.name!;
    context.read<GroupCubit>().editGroup(widget.groubModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          FireDataBase()
              .editGroup(
            gid: widget.groubModel.id!,
            name: gNameCon.text,
            members: members,
          )
              .then((vlaue) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Done')),
            );
            Navigator.pop(context);
          });
        },
        label: const Text("Done"),
        icon: const Icon(Iconsax.tick_circle),
      ),
      appBar: AppBar(
        title: const Text("Edit Group"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: AddPhoto(),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomField(
                    controller: gNameCon,
                    icon: Iconsax.user_octagon,
                    lable: "Group Name",
                  ),
                ),
              ],
            ),
            const Divider(
              height: 32,
              thickness: 2,
            ),
            const Row(
              children: [
                Text("Add Members"),
                Spacer(),
                Text("0"),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<GroupCubit, GroupState>(
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
                          value: members.contains(contacts[index].id),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                members.add(contacts[index].id!);
                                log('Added member: ${contacts[index].id!}');
                              } else {
                                members.remove(contacts[index].id!);
                                log('Removed member: ${contacts[index].id!}');
                              }
                            });
                            // widget
                            //     .onMembersUpdated(); // Trigger the callback to update the state
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
