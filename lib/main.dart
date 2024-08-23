import 'package:chat_app/core/di/dependency_injection.dart';
import 'package:chat_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/features/auth/ui/screen/login_screen.dart';
import 'package:chat_app/features/auth/ui/screen/setup_profile.dart';
import 'package:chat_app/features/chat/logic/cubit/create_room_cubit.dart';
import 'package:chat_app/features/contact/logic/cubit/contact_cubit.dart';
import 'package:chat_app/features/groub/logic/cubit/group_cubit.dart';
import 'package:chat_app/features/setting/data/constant.dart';
import 'package:chat_app/features/setting/data/enum/theme_state.dart';
import 'package:chat_app/features/setting/logic/cubit/app_theme_cubit.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/layout.dart';
// import 'package:chat_app/layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedPreferences = await SharedPreferences.getInstance();
  setupLocator();
  runApp(
      // DevicePreview(
      //   enabled: true,
      //   builder: (context) {
      const MyApp()
      //   },
      // ),
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt<CreateRoomCubit>(),
        ),
        BlocProvider(
          create: (context) => ContactCubit()..loadContacts(),
        ),
        BlocProvider(
          create: (context) => GroupCubit()..loadContacts(),
        ),
        BlocProvider(
          create: (context) => AppThemeCubit()..changeTheme(Themestate.initial),
        ),
      ],
      child: Builder(builder: (context) {
        var themeState = context.select((AppThemeCubit bloc) => bloc.state);
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          // themeMode: ThemeMode.system,
          // darkTheme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(
          //       seedColor: Colors.red, brightness: Brightness.dark),
          // ),
          theme: (themeState is LightCubit)
              ? lightTheme(context)
              : darkTheme(context),
          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(
          //       seedColor: Colors.blue, brightness: Brightness.light),
          //   useMaterial3: true,
          // ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (FirebaseAuth.instance.currentUser!.displayName == "" ||
                    FirebaseAuth.instance.currentUser!.displayName == null) {
                  return SetupProfile();
                } else {
                  return Layout();
                }
              } else {
                return LoginScreen();
              }
            },
          ),
        );
      }),
    );
  }

  ThemeData lightTheme(BuildContext context) {
    var themeState = context.read<AppThemeCubit>().mainColor;
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Color(themeState), brightness: Brightness.light),
    );
  }

  ThemeData darkTheme(BuildContext context) {
    var themeState = context.read<AppThemeCubit>().mainColor;

    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
          seedColor: Color(themeState), brightness: Brightness.dark),
    );
  }
}
