import 'package:chat_app/features/setting/data/enum/theme_state.dart';
import 'package:chat_app/features/setting/logic/cubit/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class ChangeMode extends StatefulWidget {
  const ChangeMode({
    super.key,
  });

  @override
  State<ChangeMode> createState() => _ChangeModeState();
}

class _ChangeModeState extends State<ChangeMode> {
  late bool isSwitching;

  @override
  void initState() {
    super.initState();
    // تحميل القيمة المحفوظة من shared_preferences أو من cubit
    isSwitching = context.read<AppThemeCubit>().state is! LightCubit;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Dark Mode"),
      leading: const Icon(Iconsax.user),
      trailing: Switch(
        value: isSwitching,
        onChanged: (value) {
          setState(() {
            isSwitching = value;
          });
          if (isSwitching == false) {
            context.read<AppThemeCubit>().changeTheme(Themestate.light);
          } else {
            context.read<AppThemeCubit>().changeTheme(Themestate.dark);
          }
        },
      ),
    );
  }
}
