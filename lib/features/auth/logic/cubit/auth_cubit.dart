import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController emailLogin = TextEditingController();
  TextEditingController passwordLogin = TextEditingController();
  TextEditingController emailReset = TextEditingController();

  Future<void> registerUser() async {
    emit(CreateLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailLogin.text, password: passwordLogin.text);
      emit(CreateSuccess());
    } catch (e) {
      emit(CreateError(e.toString()));
    }
  }

  Future<void> loginUser() async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailLogin.text, password: passwordLogin.text);
      emit(LoginSuccess());
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> resetPassword() async {
    emit(ResetLoading());
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailReset.text);
      emit(ResetSuccess());
    } catch (e) {
      emit(ResetError(e.toString()));
    }
  }
}
