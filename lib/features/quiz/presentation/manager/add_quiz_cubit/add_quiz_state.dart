part of 'add_quiz_cubit.dart';

sealed class AddQuizState {}

final class AddQuizInitialState extends AddQuizState {}

final class AddQuizLoadingState extends AddQuizState {}

final class AddQuizFailureState extends AddQuizState {
  final String error;

  AddQuizFailureState({required this.error});
}

final class AddQuizSuccessState extends AddQuizState {}

final class AddQuestionsSuccessState extends AddQuizState {}

final class AddQuestionsLoadingState extends AddQuizState {}

final class AddQuestionsFailureState extends AddQuizState {
  final String error;

  AddQuestionsFailureState({required this.error});
}

final class GetQuestionsSuccessState extends AddQuizState {}

final class GetQuestionsLoadingState extends AddQuizState {}

final class GetQuestionsFailureState extends AddQuizState {
  final String error;

  GetQuestionsFailureState({required this.error});
}

final class PickImageSuccessState extends AddQuizState {}

final class PickImageFailureState extends AddQuizState {}

final class AddAnswerState extends AddQuizState {}
