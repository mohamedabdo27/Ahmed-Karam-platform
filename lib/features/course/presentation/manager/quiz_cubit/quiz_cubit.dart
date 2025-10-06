import 'package:ahmed_karam/features/course/data/model/quiz.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitialState());

  getQuizzes({required String id}) async {
    emit(GetQuizLoadingState());
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection("courses")
              .doc(id)
              .collection("quiz")
              .orderBy("createdAt", descending: true)
              .get();
      List<Quiz> quizzes =
          snapshot.docs.map((element) {
            Quiz quiz = Quiz.fromJson(element.data());
            quiz.id = element.id;
            return quiz;
          }).toList();
      emit(GetQuizSuccessState(quizzes: quizzes));
    } catch (e) {
      emit(GetQuizFailureState());
    }
  }
}
