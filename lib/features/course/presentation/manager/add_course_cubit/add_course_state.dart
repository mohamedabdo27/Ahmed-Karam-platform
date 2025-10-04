part of 'add_course_cubit.dart';

sealed class AddCourseState {}

final class AddCourseInitialState extends AddCourseState {}

final class PickImageLoadingState extends AddCourseState {}

final class PickImageSuccessState extends AddCourseState {}

final class PickImageFailureState extends AddCourseState {}

final class AddCourseFailureState extends AddCourseState {}

final class AddCourseSuccessState extends AddCourseState {}

final class AddCourseLoadingState extends AddCourseState {}
