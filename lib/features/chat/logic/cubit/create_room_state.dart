part of 'create_room_cubit.dart';

@immutable
sealed class CreateRoomState {}

final class CreateRoomInitial extends CreateRoomState {}

final class CreateRoomLoading extends CreateRoomState {}

final class CreateRoomSuccess extends CreateRoomState {}

final class CreateRoomFailer extends CreateRoomState {
  final String error;

  CreateRoomFailer(this.error);
}
