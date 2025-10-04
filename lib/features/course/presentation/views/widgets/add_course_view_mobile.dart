import 'package:ahmed_karam/core/utils/function/validate_text_form_field.dart';
import 'package:ahmed_karam/features/auth/presentation/views/widget/login_button.dart';
import 'package:ahmed_karam/features/course/presentation/manager/add_course_cubit/add_course_cubit.dart';
import 'package:ahmed_karam/features/course/presentation/views/widgets/add_course_field.dart';
import 'package:ahmed_karam/features/course/presentation/views/widgets/add_course_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCourseViewMobile extends StatefulWidget {
  const AddCourseViewMobile({super.key});

  @override
  State<AddCourseViewMobile> createState() => _AddCourseViewMobileState();
}

class _AddCourseViewMobileState extends State<AddCourseViewMobile> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final GlobalKey<AddCourseImageState> imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Course")),
      body: BlocBuilder<AddCourseCubit, AddCourseState>(
        builder: (context, state) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      spacing: 16,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 24),
                        AddCourseImage(key: imageKey),

                        AddCourseField(
                          validator: (value) {
                            return validateText(
                              value: value,
                              title: "Course Title",
                            );
                          },
                          title: "Course Title",
                          controller: titleController,
                        ),
                        AddCourseField(
                          validator: (value) {
                            return validateText(
                              value: value,
                              title: "Course description",
                            );
                          },
                          title: "Course description",
                          maxLines: 2,
                          controller: descController,
                        ),
                        Expanded(child: SizedBox(height: 24)),
                        LoginButton(
                          text: "Add Course",
                          isLoading: false,
                          onTap: () {
                            if (imageKey.currentState!.validate() &&
                                formKey.currentState!.validate()) {
                              BlocProvider.of<AddCourseCubit>(
                                context,
                              ).addCourse(
                                title: titleController.text,
                                des: descController.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
