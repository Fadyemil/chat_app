import 'package:flutter/material.dart';
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
                  pickerColor: Colors.red,
                  onColorChanged: (value) {},
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
