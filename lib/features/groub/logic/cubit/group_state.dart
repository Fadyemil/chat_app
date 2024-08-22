part of 'group_cubit.dart';

@immutable
sealed class GroupState {}

final class GroupInitial extends GroupState {}

final class GroupLaading extends GroupState {}

final class GroupSucces extends GroupState {
   final List<ChatUserModel> contacts;

  GroupSucces({required this.contacts});
}

final class GroupError extends GroupState {
  final String error;
  GroupError({required this.error});
}
