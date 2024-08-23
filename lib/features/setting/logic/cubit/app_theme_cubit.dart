import 'package:bloc/bloc.dart';
import 'package:chat_app/features/setting/data/constant.dart';
import 'package:chat_app/features/setting/data/enum/theme_state.dart';
import 'package:meta/meta.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeInitial()) {
    // استرجاع اللون المحفوظ عند تهيئة التطبيق
    loadMainColor();
  }

  int mainColor = 0xff4050B5;

  // تحميل اللون المحفوظ
  void loadMainColor() {
    final savedColor = sharedPreferences!.getInt('mainColor');
    if (savedColor != null) {
      mainColor = savedColor;
    }
    // إصدار الحالة بناءً على الثيم المحفوظ
    if (sharedPreferences!.getString('theme') == 'L') {
      emit(LightCubit());
    } else if (sharedPreferences!.getString('theme') == 'D') {
      emit(DarkCubit());
    }
  }

  // تغيير اللون وتخزينه
  void changeColor(int c) {
    mainColor = c;
    sharedPreferences!.setInt('mainColor', c);

    // الحفاظ على الثيم الحالي عند تغيير اللون
    if (state is LightCubit) {
      emit(ChageColor(color: c));
      emit(LightCubit());
    } else if (state is DarkCubit) {
      emit(ChageColor(color: c));
      emit(DarkCubit());
    }
  }

  // تبديل الثيم وتخزينه
  void changeTheme(Themestate state) {
    switch (state) {
      case Themestate.initial:
        final savedTheme = sharedPreferences!.getString('theme');
        if (savedTheme == 'L') {
          emit(LightCubit());
        } else if (savedTheme == 'D') {
          emit(DarkCubit());
        }
        break;
      case Themestate.light:
        sharedPreferences!.setString('theme', 'L');
        emit(LightCubit());
        break;
      case Themestate.dark:
        sharedPreferences!.setString('theme', 'D');
        emit(DarkCubit());
        break;
      default:
    }
  }
}
