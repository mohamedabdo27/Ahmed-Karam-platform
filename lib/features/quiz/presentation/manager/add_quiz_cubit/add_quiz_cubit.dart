import 'dart:io';

import 'package:ahmed_karam/core/utils/function/show_error_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'add_quiz_state.dart';

class AddQuizCubit extends Cubit<AddQuizState> {
  AddQuizCubit() : super(AddQuizInitialState());

  addQuiz({
    required String courseId,
    required String des,
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required int minutes,
    required int hours,
  }) async {
    emit(AddQuizLoadingState());
    try {
      final CollectionReference snapshot = FirebaseFirestore.instance
          .collection("courses")
          .doc(courseId)
          .collection("quiz");

      final createdAt = DateTime.now();
      await snapshot.add({
        "description": des,
        "title": title,
        "minutes": minutes,
        "houres": hours,
        "startDate": startDate,
        "endDate": endDate,
        "createdAt": createdAt,
      });
      emit(AddQuizSuccessState());
    } catch (e) {
      emit(AddQuizFailureState(error: "error to Create quizz"));
    }
  }

  dispose() {
    for (var element in questions) {
      element.questionController.dispose();

      for (var e in element.answers) {
        e.answerController.dispose();
      }
    }
  }

  ImagePicker picker = ImagePicker();
  // File? questionImage;
  List<File?> questionImages = [null];

  pickImage(int pageIndex) async {
    // emit(PickImageLoadingState());
    try {
      XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        questionImages[pageIndex] = File(imageFile.path);
      }
      emit(PickImageSuccessState());
    } catch (e) {
      emit(PickImageFailureState());
    }
  }

  Future<String> uploadImage(File? questionImage) async {
    final cloudName = "dw0lhb4bs"; // من Dashboard
    final uploadPreset = "my_unsigned_preset"; // اللي عملته في Cloudinary

    final url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    final formData = FormData.fromMap({
      'upload_preset': uploadPreset,
      'file': await MultipartFile.fromFile(
        questionImage!.path,
        filename: questionImage.path.split('/').last,
      ),
      'public_id': "courses/${DateTime.now().millisecondsSinceEpoch}",
    });

    final response = await Dio().post(url, data: formData);
    String imageUrl;
    if (response.statusCode == 200) {
      imageUrl = response.data['secure_url'];
    } else {
      throw "null image";
    }
    return imageUrl;
  }

  List<Question> questions = [
    Question(answers: [Answer(text: "Answer 1"), Answer(text: "Answer 2")]),
  ];
  addQuestion(int pageIndex) {
    questionImages.add(null);
    questions.add(
      Question(answers: [Answer(text: "Answer 1"), Answer(text: "Answer 2")]),
    );
    emit(AddAnswerState());
  }

  deleteQuestion(pageIndex, context) {
    if (questions.length > 1) {
      questions.removeAt(pageIndex);
      questionImages.removeAt(pageIndex);
      emit(AddAnswerState());
    } else {
      showErrorSnackBar(context, msg: "The questions must be at least one");
    }
  }

  bool isSubmitted = false;
  getQuestions({required String courseId, required String quizId}) async {
    emit(GetQuestionsLoadingState());
    try {
      final CollectionReference<Map<String, dynamic>> snapshot =
          FirebaseFirestore.instance
              .collection("courses")
              .doc(courseId)
              .collection("quiz")
              .doc(quizId)
              .collection("questions");
      final data = await snapshot.orderBy("createdAt").get();
      if (data.docs.isEmpty) {
        isSubmitted = false;
        emit(GetQuestionsSuccessState());
      } else {
        questions = [];
        questionImages = [];
        questions =
            data.docs.map((toElement) {
              // list of Answers text of this question
              List<dynamic> answersList = toElement["answers"];

              //convert the answers text to answers model
              List<Answer> initAnswers =
                  answersList.map((data) {
                    return Answer(text: "");
                  }).toList();
              //add question image "File?" with "null" to this question
              questionImages.add(null);
              // init new question
              var question = Question(answers: initAnswers);

              // add answers text to this question
              for (int i = 0; i < question.answers.length; i++) {
                question.answers[i].answerController.text = answersList[i];
                question.answers[i].text = "Answer ${i + 1}";
              }
              // add question details
              question.image = toElement["image"];
              question.id = toElement["id"];
              question.questionController.text = toElement["title"];
              question.isFromJson = true;
              // add this question to my list
              return question;
            }).toList();
        isSubmitted = true;
        emit(GetQuestionsSuccessState());
      }
    } catch (e) {
      emit(GetQuestionsFailureState(error: "there was an error"));
    }
  }

  submitQuestions({required String courseId, required String quizId}) async {
    emit(AddQuestionsLoadingState());
    try {
      List<String?> imagesUrl = [];
      for (File? element in questionImages) {
        if (element != null) {
          imagesUrl.add(await uploadImage(element));
        } else {
          imagesUrl.add(null);
        }
      }

      final CollectionReference<Map<String, dynamic>> snapshot =
          FirebaseFirestore.instance
              .collection("courses")
              .doc(courseId)
              .collection("quiz")
              .doc(quizId)
              .collection("questions");
      for (int i = 0; i < questions.length; i++) {
        if (questions[i].isFromJson) {
        } else {
          DateTime createdAt = DateTime.now();
          DocumentReference<Map<String, dynamic>> data = await snapshot.add({
            "createdAt": createdAt,
            "answers":
                questions[i].answers
                    .map((toElement) => toElement.answerController.text)
                    .toList(),
            "title": questions[i].questionController.text,
            "image": imagesUrl[i],
          });
          await snapshot.doc(data.id).update({"id": data.id});
        }
      }
      emit(AddQuestionsSuccessState());
    } catch (e) {
      emit(AddQuestionsFailureState(error: "error to add Questions"));
    }
  }

  addAnswer({required int index}) {
    int answerLenght = questions[index].answers.length;
    questions[index].answers.add(Answer(text: "Answer ${answerLenght + 1}"));
    emit(AddAnswerState());
  }

  deleteAnswer({required int questionIndex, required int answerIndex}) {
    questions[questionIndex].answers[answerIndex].answerController.dispose();
    questions[questionIndex].answers.removeAt(answerIndex);
    for (int i = 0; i < questions[questionIndex].answers.length; i++) {
      Answer answer = questions[questionIndex].answers[i];
      answer.text = "Answer ${i + 1}";
    }
    emit(AddAnswerState());
  }
}

class Question {
  Question({
    this.image,
    required this.answers,
    this.id,
    this.isFromJson = false,
  });
  String? image, id;
  bool isFromJson;
  final TextEditingController questionController = TextEditingController();
  List<Answer> answers;
}

class Answer {
  final TextEditingController answerController = TextEditingController();
  String text;

  Answer({required this.text});
}
