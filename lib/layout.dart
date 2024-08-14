import 'package:chat_app/features/chat/screen/chat_screen.dart';
import 'package:chat_app/features/contact/screen/contact_screen.dart';
import 'package:chat_app/features/groub/screen/groub_screen.dart';
import 'package:chat_app/features/setting/screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        controller: pageController,
        children: [
          ChatScreen(),
          GroubScreen(),
          ContactScreen(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        selectedIndex: currentIndex,
        onDestinationSelected: (value) {
          setState(
            () {
              currentIndex = value;
              pageController.jumpToPage(value);
            },
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Iconsax.message), label: "Chat"),
          NavigationDestination(icon: Icon(Iconsax.messages), label: "Group"),
          NavigationDestination(icon: Icon(Iconsax.user), label: "Contacts"),
          NavigationDestination(icon: Icon(Iconsax.setting), label: "Setting"),
        ],
      ),
    );
  }
}
