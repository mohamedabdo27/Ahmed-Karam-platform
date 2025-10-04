import 'package:ahmed_karam/features/course/data/model/quiz.dart';
import 'package:ahmed_karam/features/quiz/presentation/manager/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionView extends StatelessWidget {
  const QuestionView({super.key, required this.quiz});
  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    AddQuizCubit cubit = BlocProvider.of<AddQuizCubit>(context);
    return Scaffold(
      body: BlocBuilder<AddQuizCubit, AddQuizState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomScrollView(
              slivers: [
                // SliverAppBar(
                //   floating: true,
                //   pinned: true,
                //   expandedHeight: 200,
                //   collapsedHeight: 80,
                //   flexibleSpace: FlexibleSpaceBar(
                //     background:
                //         cubit.questionImage == null
                //             ? null
                //             : Image.file(cubit.questionImage!, fit: BoxFit.fill),
                //   ),
                // ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          cubit.pickImage();
                        },
                        child: Container(
                          height: 250,
                          decoration: BoxDecoration(
                            image:
                                cubit.questionImage == null
                                    ? null
                                    : DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(cubit.questionImage!),
                                    ),
                            border: Border.all(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.onSecondaryContainer,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child:
                              cubit.questionImage != null
                                  ? null
                                  : Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text("Select Image"),
                                        SizedBox(width: 10),
                                        Icon(Icons.image_outlined),
                                      ],
                                    ),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
