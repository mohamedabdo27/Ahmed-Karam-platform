part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitialState extends HomeState {}

final class LogoutLoadingState extends HomeState {}

final class LogoutFailureState extends HomeState {
  final String error;

  LogoutFailureState({required this.error});
}

final class LogoutSuccessState extends HomeState {}
