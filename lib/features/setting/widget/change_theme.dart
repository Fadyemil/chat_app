import 'dart:developer';

import 'package:chat_app/features/setting/logic/cubit/app_theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iconsax/iconsax.dart';

class changeTheme extends StatelessWidget {
  const changeTheme({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: BlockPicker(
                  pickerColor: Color(
                    context.read<AppThemeCubit>().mainColor,
                  ),
                  onColorChanged: (value) {
                    log(value.value.toRadixString(16));
                    context.read<AppThemeCubit>().changeColor(value.value);
                  },
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Done"))
              ],
            );
          },
        );
      },
      title: Text("Theme"),
      leading: Icon(Iconsax.color_swatch),
    );
  }
}
