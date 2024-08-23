part of 'app_theme_cubit.dart';

@immutable
sealed class AppThemeState {}

final class AppThemeInitial extends AppThemeState {}

final class DarkCubit extends AppThemeState {}

final class LightCubit extends AppThemeState {}

final class ChageColor extends AppThemeState {
  final int color;

  ChageColor({required this.color});
}
