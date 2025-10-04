import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

part 'add_course_state.dart';

class AddCourseCubit extends Cubit<AddCourseState> {
  AddCourseCubit() : super(AddCourseInitialState());

  ImagePicker picker = ImagePicker();
  File? courseImage;
  pickImage() async {
    // emit(PickImageLoadingState());
    try {
      XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
      if (imageFile != null) {
        courseImage = File(imageFile.path);
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
        courseImage!.path,
        filename: courseImage!.path.split('/').last,
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

  addCourse({required String title, required String des}) async {
    emit(AddCourseLoadingState());
    try {
      String imageUrl = await uploadImage();
      CollectionReference courses = FirebaseFirestore.instance.collection(
        'courses',
      );
      courses.add({"image": imageUrl, "title": title, "description": des});
      emit(AddCourseSuccessState());
    } catch (e) {
      log(e.toString());
      emit(AddCourseFailureState());
    }
  }
}
