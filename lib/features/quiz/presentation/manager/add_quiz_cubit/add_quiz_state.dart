part of 'add_quiz_cubit.dart';

sealed class AddQuizState {}

final class AddQuizInitialState extends AddQuizState {}

final class AddQuizLoadingState extends AddQuizState {}

final class AddQuizFailureState extends AddQuizState {
  final String error;

  AddQuizFailureState({required this.error});
}

final class AddQuizSuccessState extends AddQuizState {}

final class PickImageSuccessState extends AddQuizState {}

final class PickImageFailureState extends AddQuizState {}
