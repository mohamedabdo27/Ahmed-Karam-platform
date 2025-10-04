part of 'quiz_cubit.dart';

sealed class QuizState {}

final class QuizInitialState extends QuizState {}

final class GetQuizSuccessState extends QuizState {
  final List<Quiz> quizzes;

  GetQuizSuccessState({required this.quizzes});
}

final class GetQuizFailureState extends QuizState {}

final class GetQuizLoadingState extends QuizState {}
