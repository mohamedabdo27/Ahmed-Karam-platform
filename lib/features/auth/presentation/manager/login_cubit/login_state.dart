part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitialState extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState extends LoginState {}

final class LoginFailureState extends LoginState {
  final String error;

  LoginFailureState({required this.error});
}

final class SignupLoadingState extends LoginState {}

final class SignupSuccessState extends LoginState {}

final class SignupFailureState extends LoginState {
  final String error;

  SignupFailureState({required this.error});
}
