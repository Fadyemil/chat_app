import 'package:chat_app/features/contact/logic/cubit/contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ContactAppBar extends StatefulWidget implements PreferredSizeWidget {
  // final bool searched;
  // final VoidCallback onToggleSearch;

  const ContactAppBar({
    Key? key,
    // required this.searched,
    // required this.onToggleSearch,
  }) : super(key: key);

  @override
  State<ContactAppBar> createState() => _ContactAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ContactAppBarState extends State<ContactAppBar> {
  bool searched = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [_buildSearchAction()],
      title: searched ? _buildSearchField() : const Text("My Contacts"),
    );
  }

  Widget _buildSearchAction() {
    return IconButton(
      onPressed: () {
        setState(() {
          searched = !searched;
          if (!searched) {
            context.read<ContactCubit>().searchCon.clear();
            context.read<ContactCubit>().loadContacts(); // Reload all contacts
          }
        });
      },
      icon: Icon(searched ? Iconsax.close_circle : Iconsax.search_normal),
    );
  }

  Widget _buildSearchField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              context.read<ContactCubit>().loadContacts();
              setState(() {
                context.read<ContactCubit>().searchCon.text = value;
              });
            },
            autofocus: true,
            controller: context.read<ContactCubit>().searchCon,
            decoration: const InputDecoration(
              hintText: "Search by name",
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
