import 'dart:developer';

import 'package:ahmed_karam/features/auth/data/services/auth_service.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authService) : super(LoginInitialState());
  final AuthService authService;

  login({required String email, required String password}) async {
    emit(LoginLoadingState());
    Either<Failure, User?> result = await authService.login(
      email: email,
      password: password,
    );
    result.fold(
      (failure) {
        emit(LoginFailureState(error: failure.message));
      },
      (user) {
        log(user.toString());
        emit(LoginSuccessState());
      },
    );
  }

  signup({
    required String email,
    required String password,
    required name,
  }) async {
    emit(SignupLoadingState());
    Either<Failure, User?> result = await authService.signup(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) {
        emit(SignupFailureState(error: failure.message));
      },
      (user) {
        log(user.toString());
        emit(SignupSuccessState());
      },
    );
  }
}
