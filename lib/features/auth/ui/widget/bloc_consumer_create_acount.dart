import 'package:chat_app/core/di/dependency_injection.dart';
// import 'package:chat_app/features/auth/data/firebase/fire_auth.dart';
import 'package:chat_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/ui/widget/create_account_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocConsumerCreateAcount extends StatelessWidget {
  const BlocConsumerCreateAcount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authCubit = getIt<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      bloc: authCubit,
      listener: (context, state) {
        if (state is CreateSuccess) {
          // FireAuth.createUser();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Done')),
          );
        } else if (state is CreateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is CreateLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return CreateAccountButton();
      },
    );
  }
}
