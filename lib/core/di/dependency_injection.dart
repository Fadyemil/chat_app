import 'package:chat_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:chat_app/features/chat/logic/cubit/create_room_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<AuthCubit>(() => AuthCubit());
  getIt.registerFactory<CreateRoomCubit>(() => CreateRoomCubit());
}
