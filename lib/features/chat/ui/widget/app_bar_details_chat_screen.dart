import 'package:chat_app/core/models/chat_user_model.dart';
import 'package:chat_app/features/chat/data/firebase/fire_data_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class AppBarDetailsChatScreen extends StatefulWidget
    implements PreferredSizeWidget {
  final ChatUserModel chatUserModel;
  final String roomId;
  final List<String> selectedMsg;
  final List<String> copyMsg;

  const AppBarDetailsChatScreen({
    Key? key,
    required this.chatUserModel,
    required this.roomId,
    required this.selectedMsg,
    required this.copyMsg,
  }) : super(key: key);

  @override
  _AppBarDetailsChatScreenState createState() =>
      _AppBarDetailsChatScreenState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarDetailsChatScreenState extends State<AppBarDetailsChatScreen> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.chatUserModel.name!),
          Text(
            widget.chatUserModel.lastActivated!,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
      actions: [
        if (widget.selectedMsg
            .isNotEmpty) // Show delete button if messages are selected
          IconButton(
            onPressed: () async {
              await FireDataBase().deleteMsg(
                  roomId: widget.roomId, selectedMsg: widget.selectedMsg);
              setState(() {
                widget.selectedMsg
                    .clear(); // Clear selected messages after deletion
                widget.copyMsg.clear();
              });
            },
            icon: const Icon(Iconsax.trash),
          ),
        if (widget.copyMsg
            .isNotEmpty) // Show copy button if there are messages to copy
          IconButton(
            onPressed: () {
              Clipboard.setData(
                  ClipboardData(text: widget.copyMsg.join(' \n')));
              setState(() {
                widget.copyMsg.clear(); // Clear copied messages after copying
                widget.selectedMsg.clear();
              });
            },
            icon: const Icon(Iconsax.copy),
          ),
      ],
    );
  }
}
