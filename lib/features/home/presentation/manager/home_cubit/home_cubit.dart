import 'dart:developer';

import 'package:ahmed_karam/core/constants.dart';
import 'package:ahmed_karam/features/auth/data/models/user_model.dart';
import 'package:ahmed_karam/features/home/data/models/course.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  logout() async {
    emit(LogoutLoadingState());
    try {
      var box = Hive.box<UserModel>(kUserBox);
      await box.clear();
      userModel = null;
      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutFailureState(error: "there was an error while logging out"));
    }
  }

  List<Course> courses = [];
  getCourses() async {
    emit(GetCoursesLoadingState());
    courses = [];
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("courses").get();

      // log(snapshot.docs[0].data().toString());
      for (var element in snapshot.docs) {
        var course = Course.fromJson(element.data());
        course.id = element.id;
        courses.add(course);
      }
      // courses =
      //     snapshot.docs.map((element) {
      //       return Course.fromJson(element.data());
      //     }).toList();
      emit(GetCoursesSuccessState(courses: courses));
    } catch (e) {
      log(e.toString());
      emit(GetCoursesFailureState());
    }
  }
}
