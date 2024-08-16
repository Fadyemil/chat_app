import 'package:chat_app/features/contact/widget/add_contact.dart';
import 'package:chat_app/features/contact/widget/contact_app_bar.dart';
import 'package:chat_app/features/contact/widget/list_contact.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  bool searched = false;
  TextEditingController emailCon = TextEditingController();
  TextEditingController searchCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ContactAppBar(
        searched: searched,
        searchCon: searchCon,
        onToggleSearch: () {
          setState(() {
            searched = !searched;
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(20),
                child: AddContact(emailCon: emailCon),
              );
            },
          );
        },
        child: const Icon(Iconsax.user_add),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(children: [Expanded(child: ListContact())]),
      ),
    );
  }
}