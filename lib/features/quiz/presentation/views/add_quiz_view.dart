import 'package:ahmed_karam/core/utils/function/show_error_snack_bar.dart';
import 'package:ahmed_karam/core/utils/function/validate_text_form_field.dart';
import 'package:ahmed_karam/core/widget/loading_widget.dart';
import 'package:ahmed_karam/features/auth/presentation/views/widget/login_button.dart';
import 'package:ahmed_karam/features/course/presentation/views/widgets/add_course_field.dart';
import 'package:ahmed_karam/features/quiz/presentation/manager/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:ahmed_karam/features/quiz/presentation/views/widgets/date_picker.dart';
import 'package:ahmed_karam/features/quiz/presentation/views/widgets/set_exam_duration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

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
      body: BlocConsumer<AddQuizCubit, AddQuizState>(
        listener: (context, state) {
          if (state is AddQuizLoadingState) {
            isLoading = true;
          } else if (state is AddQuizSuccessState) {
            isLoading = false;
            GoRouter.of(context).pop();
            showSuccessSnackBar(
              context,
              msg: "Quiz has been  added successfully",
            );
          } else if (state is AddQuizFailureState) {
            isLoading = false;
            showErrorSnackBar(context, msg: state.error);
          } else {
            isLoading = false;
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    pinned: true,
                    collapsedHeight: 80,
                    expandedHeight: 150.0,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image.asset(
                        colorBlendMode: BlendMode.srcIn,

                        "assets/images/quiz_image-removebg.png",
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
                                return validateTextField(
                                  value: value,
                                  title: "Title",
                                );
                              },
                            ),
                            SizedBox(height: 16),
                            AddCourseField(
                              title: "Description",
                              controller: desController,
                              maxLines: 3,
                              validator: (value) {
                                return validateTextField(
                                  value: value,
                                  title: "Description",
                                );
                              },
                            ),
                            SizedBox(height: 16),
                            DatePicker(
                              key: startDateTimeKey,
                              title: "Start date",
                              onSelectDateTime: (dateTime) {
                                startDateTime = dateTime;
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
                              },
                              onMinutesChange: (minutes) {
                                selectedMinutes = minutes;
                              },
                            ),
                            Expanded(child: SizedBox(height: 32)),
                            LoginButton(
                              text: "Add",
                              onTap: () {
                                if (formKey.currentState!.validate() &&
                                    startDateTimeKey.currentState!.validate() &&
                                    endDateTimeKey.currentState!.validate()) {
                                  BlocProvider.of<AddQuizCubit>(
                                    context,
                                  ).addQuiz(
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
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              if (isLoading) LoadingWidget(),
            ],
          );
        },
      ),
    );
  }
}
