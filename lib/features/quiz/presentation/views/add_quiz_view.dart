import 'dart:developer';

import 'package:ahmed_karam/core/utils/function/show_error_snack_bar.dart';
import 'package:ahmed_karam/core/utils/function/validate_text_form_field.dart';
import 'package:ahmed_karam/features/auth/presentation/views/widget/login_button.dart';
import 'package:ahmed_karam/features/course/presentation/views/widgets/add_course_field.dart';
import 'package:ahmed_karam/features/quiz/presentation/manager/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:ahmed_karam/features/quiz/presentation/views/widgets/date_picker.dart';
import 'package:ahmed_karam/features/quiz/presentation/views/widgets/set_exam_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddQuizView extends StatefulWidget {
  const AddQuizView({super.key, required this.courseId});
  final String courseId;
  @override
  State<AddQuizView> createState() => _AddQuizViewState();
}

class _AddQuizViewState extends State<AddQuizView> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<DatePickerState> startDateTimeKey = GlobalKey();
  final GlobalKey<DatePickerState> endDateTimeKey = GlobalKey();
  DateTime? startDateTime, endDateTime;
  int selectedHours = 0;
  int selectedMinutes = 30;
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return Scaffold(
      // appBar: AppBar(title: Text("Add Quiz"), centerTitle: true),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            collapsedHeight: 80,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              // title: const Text("Add Quiz"),
              background: Image.asset(
                colorBlendMode: BlendMode.srcIn,
                // colorFilter: ColorFilter.mode(
                //   Theme.of(context).colorScheme.onPrimaryContainer,
                //   BlendMode.srcIn,
                // ),
                "assets/images/quiz_image-removebg.png",
                // fit: BoxFit.cover,
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(height: 32),
                    AddCourseField(
                      title: "Title",
                      controller: titleController,
                      validator: (value) {
                        return validateText(value: value, title: "Title");
                      },
                    ),
                    SizedBox(height: 16),
                    AddCourseField(
                      title: "Description",
                      controller: desController,
                      maxLines: 3,
                      validator: (value) {
                        return validateText(value: value, title: "Description");
                      },
                    ),
                    SizedBox(height: 16),
                    DatePicker(
                      key: startDateTimeKey,
                      title: "Start date",
                      onSelectDateTime: (dateTime) {
                        startDateTime = dateTime;
                        log(startDateTime.toString());
                      },
                    ),
                    SizedBox(height: 16),
                    DatePicker(
                      key: endDateTimeKey,
                      title: "End date",
                      onSelectDateTime: (dateTime) {
                        endDateTime = dateTime;
                      },
                    ),
                    SizedBox(height: 16),

                    SetExamDurationScreen(
                      onHoursChange: (hours) {
                        selectedHours = hours;
                        log(hours.toString());
                      },
                      onMinutesChange: (minutes) {
                        selectedMinutes = minutes;
                        log(minutes.toString());
                      },
                    ),
                    Expanded(child: SizedBox(height: 32)),
                    BlocConsumer<AddQuizCubit, AddQuizState>(
                      listener: (context, state) {
                        if (state is AddQuizLoadingState) {
                          isLoading = true;
                        } else if (state is AddQuizSuccessState) {
                          isLoading = false;
                          showSuccessSnackBar(
                            context,
                            msg: "quiz added successfully",
                          );
                          // GoRouter.of(context).pushReplacement(AppNavigate.kHomeView);
                        } else if (state is AddQuizFailureState) {
                          isLoading = false;
                          showErrorSnackBar(context, msg: state.error);
                        } else {
                          isLoading = false;
                        }
                      },
                      builder: (context, state) {
                        return LoginButton(
                          text: "Add",
                          isLoading: isLoading,
                          onTap: () {
                            if (formKey.currentState!.validate() &&
                                startDateTimeKey.currentState!.validate() &&
                                endDateTimeKey.currentState!.validate()) {
                              BlocProvider.of<AddQuizCubit>(context).addQuiz(
                                courseId: widget.courseId,
                                des: desController.text,
                                title: titleController.text,
                                endDate: endDateTime!,
                                startDate: startDateTime!,
                                hours: selectedHours,
                                minutes: selectedMinutes,
                              );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
