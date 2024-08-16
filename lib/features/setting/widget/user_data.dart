import 'package:chat_app/features/setting/screen/qr_code_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class userData extends StatelessWidget {
  const userData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 40,
      leading: CircleAvatar(
        radius: 30,
      ),
      title: Text("Name"),
      trailing: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QrCodeScreen(),
                ));
          },
          icon: Icon(Iconsax.scan_barcode)),
    );
  }
}

