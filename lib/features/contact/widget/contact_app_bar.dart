import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool searched;
  final TextEditingController searchCon;
  final VoidCallback onToggleSearch;

  const ContactAppBar({
    Key? key,
    required this.searched,
    required this.searchCon,
    required this.onToggleSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [_buildSearchAction()],
      title: searched ? _buildSearchField() : const Text("My Contacts"),
    );
  }

  Widget _buildSearchAction() {
    return IconButton(
      onPressed: onToggleSearch,
      icon: Icon(searched ? Iconsax.close_circle : Iconsax.search_normal),
    );
  }

  Widget _buildSearchField() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            controller: searchCon,
            decoration: const InputDecoration(
              hintText: "Search by name",
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
