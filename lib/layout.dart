// import 'dart:developer';

import 'dart:developer';

import 'package:chat_app/features/auth/data/firebase/fire_auth.dart';
import 'package:chat_app/features/chat/ui/screen/chat_screen.dart';
import 'package:chat_app/features/contact/screen/contact_screen.dart';
import 'package:chat_app/features/groub/screen/groub_screen.dart';
import 'package:chat_app/features/setting/logic/get_user_cubit/get_user_cubit.dart';
import 'package:chat_app/features/setting/screen/setting_screen.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with WidgetsBindingObserver {
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
    context.read<GetUserCubit>().getUserDetails();
    WidgetsBinding.instance.addObserver(this);

    // تحقق من الحالة الحالية عند بدء التطبيق
    if (WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed) {
      FireAuth().updateActivate(online: true);
    } else {
      FireAuth().updateActivate(online: false);
    }

    context.read<GetUserCubit>().getUserDetails();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    log('********************${state.toString()}****************');

    if (state == AppLifecycleState.resumed) {
      FireAuth().updateActivate(online: true);
    } else if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      FireAuth().updateActivate(online: false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

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
