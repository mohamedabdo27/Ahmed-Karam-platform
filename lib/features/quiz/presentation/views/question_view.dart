import 'package:ahmed_karam/core/utils/function/show_error_snack_bar.dart';
import 'package:ahmed_karam/core/utils/function/validate_text_form_field.dart';
import 'package:ahmed_karam/core/widget/loading_widget.dart';
import 'package:ahmed_karam/features/auth/presentation/views/widget/login_button.dart';
import 'package:ahmed_karam/features/quiz/presentation/manager/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:ahmed_karam/features/quiz/presentation/views/widgets/next_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmed_karam/features/course/presentation/views/widgets/add_course_field.dart';
import 'package:go_router/go_router.dart';

class QuestionView extends StatefulWidget {
  const QuestionView({super.key, required this.quizId, required this.courseId});
  final String quizId;
  final String courseId;

  @override
  State<QuestionView> createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  final PageController pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoding = false;
    AddQuizCubit cubit = BlocProvider.of<AddQuizCubit>(context);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          cubit.dispose();
        }
      },
      child: Scaffold(
        body: BlocConsumer<AddQuizCubit, AddQuizState>(
          listener: (context, state) {
            if (state is AddQuestionsLoadingState) {
              isLoding = true;
            } else if (state is AddQuestionsFailureState) {
              isLoding = false;
              showErrorSnackBar(context, msg: state.error);
            } else if (state is AddQuestionsSuccessState) {
              isLoding = false;
              GoRouter.of(context).pop();
              showSuccessSnackBar(
                context,
                msg: "Questions have been added successfully.",
              );
            }
          },
          builder: (context, state) {
            if (state is GetQuestionsFailureState) {
              return Center(child: Text(state.error));
            }
            if (state is GetQuestionsLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: cubit.questions.length,
                    itemBuilder: (context, pageIndex) {
                      final GlobalKey<FormState> formKey = GlobalKey();
                      return Form(
                        key: formKey,
                        child: CustomScrollView(
                          slivers: [
                            SliverAppBar(
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    cubit.deleteQuestion(pageIndex, context);
                                  },
                                  icon: Icon(
                                    Icons.cancel_outlined,
                                    size: 32,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              ],
                              title: Text("Question ${pageIndex + 1}"),
                              centerTitle: true,
                            ),
                            SliverToBoxAdapter(
                              child: AbsorbPointer(
                                absorbing:
                                    cubit.questions[pageIndex].isFromJson,
                                child: Column(
                                  children: [
                                    SizedBox(height: 16),

                                    GestureDetector(
                                      onTap: () {
                                        cubit.pickImage(pageIndex);
                                      },
                                      child:
                                          cubit.questions[pageIndex].image !=
                                                  null
                                              ? Container(
                                                height: 250,
                                                width: double.infinity,

                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .onSecondaryContainer,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl:
                                                      cubit
                                                          .questions[pageIndex]
                                                          .image!,
                                                ),
                                              )
                                              : Container(
                                                width: double.infinity,

                                                height: 250,
                                                decoration: BoxDecoration(
                                                  image:
                                                      cubit.questionImages[pageIndex] ==
                                                              null
                                                          ? null
                                                          : DecorationImage(
                                                            fit: BoxFit.cover,
                                                            image: FileImage(
                                                              cubit
                                                                  .questionImages[pageIndex]!,
                                                            ),
                                                          ),
                                                  border: Border.all(
                                                    color:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .onSecondaryContainer,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child:
                                                    cubit.questionImages[pageIndex] !=
                                                            null
                                                        ? null
                                                        : Center(
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                "Select Image",
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),

                                                              Icon(
                                                                Icons
                                                                    .image_outlined,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                              ),
                                    ),
                                    SizedBox(height: 16),

                                    AddCourseField(
                                      title: "Question",
                                      maxLines: 2,
                                      controller:
                                          cubit
                                              .questions[pageIndex]
                                              .questionController,
                                      validator: (value) {
                                        return validateTextField(
                                          value: value,
                                          title: "Question",
                                        );
                                      },
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              ),
                            ),
                            SliverList.separated(
                              separatorBuilder:
                                  (context, index) => SizedBox(height: 12),
                              itemCount:
                                  cubit.questions[pageIndex].answers.length,
                              itemBuilder: (context, index) {
                                return AbsorbPointer(
                                  absorbing:
                                      cubit.questions[pageIndex].isFromJson,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: AddCourseField(
                                          title:
                                              cubit
                                                  .questions[pageIndex]
                                                  .answers[index]
                                                  .text,
                                          controller:
                                              cubit
                                                  .questions[pageIndex]
                                                  .answers[index]
                                                  .answerController,
                                          validator: (value) {
                                            return validateTextField(
                                              value: value,
                                              title: "Answer ${index + 1}",
                                            );
                                          },
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (cubit
                                                  .questions[pageIndex]
                                                  .answers
                                                  .length >
                                              2) {
                                            cubit.deleteAnswer(
                                              questionIndex: pageIndex,
                                              answerIndex: index,
                                            );
                                          }
                                        },
                                        icon: Icon(
                                          Icons.delete_outline,
                                          color:
                                              cubit
                                                          .questions[pageIndex]
                                                          .answers
                                                          .length >
                                                      2
                                                  ? Colors.red
                                                  : Colors.grey,
                                          size: 32,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            SliverFillRemaining(
                              hasScrollBody: false,
                              child: Column(
                                children: [
                                  SizedBox(height: 16),
                                  AbsorbPointer(
                                    absorbing:
                                        cubit.questions[pageIndex].isFromJson,
                                    child: TextButton(
                                      onPressed: () {
                                        cubit.addAnswer(index: pageIndex);
                                      },
                                      child: Text("Add Answer"),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      NextButton(
                                        text: "Prev",
                                        isNext: false,
                                        onTap: () {
                                          pageController.previousPage(
                                            duration: Duration(
                                              microseconds: 500,
                                            ),
                                            curve: Curves.easeIn,
                                          );
                                        },
                                      ),
                                      SizedBox(width: 16),
                                      NextButton(
                                        text: "Next",
                                        onTap: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            if (pageIndex ==
                                                cubit.questions.length - 1) {
                                              cubit.addQuestion(pageIndex);
                                            }
                                            pageController.nextPage(
                                              duration: Duration(
                                                microseconds: 500,
                                              ),
                                              curve: Curves.easeIn,
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  Expanded(child: SizedBox(height: 16)),
                                  // show it if the question is the last one "And"
                                  // this question not uploaded before
                                  if (pageIndex == cubit.questions.length - 1 &&
                                      !cubit.questions[pageIndex].isFromJson)
                                    LoginButton(
                                      // show "update" if the the quiz question are submeted before,
                                      // And "submit" if the quiz not submited before
                                      text:
                                          cubit.isSubmitted
                                              ? "Update"
                                              : "Submit",
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          cubit.submitQuestions(
                                            courseId: widget.courseId,
                                            quizId: widget.quizId,
                                          );
                                        }
                                      },
                                    ),
                                  SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                if (isLoding) LoadingWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
