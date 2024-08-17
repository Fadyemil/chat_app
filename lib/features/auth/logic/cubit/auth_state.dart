part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class CreateLoading extends AuthState {}

class CreateSuccess extends AuthState {}

class CreateError extends AuthState {
  final String error;
  CreateError(this.error);
}

class LoginLoading extends AuthState {}

class LoginSuccess extends AuthState {}

class LoginError extends AuthState {
  final String error;
  LoginError(this.error);
}

class ResetLoading extends AuthState {}

class ResetSuccess extends AuthState {}

class ResetError extends AuthState {
  final String error;
  ResetError(this.error);
}
