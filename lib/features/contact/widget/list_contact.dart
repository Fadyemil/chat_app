import 'package:chat_app/features/contact/logic/cubit/contact_cubit.dart';
import 'package:chat_app/features/contact/widget/contact_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListContact extends StatelessWidget {
  const ListContact({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        if (state is ContactLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ContactLoaded) {
          final contacts = state.contacts;
          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return ContactCard(user: contacts[index]);
            },
          );
        } else if (state is ContactError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('No contacts available.'));
        }
      },
    );
  }
}
