import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
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
      await snapshot.add({
        "description": des,
        "title": title,
        "minutes": minutes,
        "houres": hours,
        "startDate": startDate,
        "endDate": endDate,
      });
      emit(AddQuizSuccessState());
    } catch (e) {
      emit(AddQuizFailureState(error: "error to Create quizz"));
    }
  }

  ImagePicker picker = ImagePicker();
  File? questionImage;
  pickImage() async {
    // emit(PickImageLoadingState());
    try {
      XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        questionImage = File(imageFile.path);
      }
      emit(PickImageSuccessState());
    } catch (e) {
      emit(PickImageFailureState());
    }
  }

  Future<String> uploadImage() async {
    final cloudName = "dw0lhb4bs"; // من Dashboard
    final uploadPreset = "my_unsigned_preset"; // اللي عملته في Cloudinary

    final url = "https://api.cloudinary.com/v1_1/$cloudName/image/upload";

    final formData = FormData.fromMap({
      'upload_preset': uploadPreset,
      'file': await MultipartFile.fromFile(
        questionImage!.path,
        filename: questionImage!.path.split('/').last,
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

  addQuestions() {}
}
