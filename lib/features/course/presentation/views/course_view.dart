import 'package:ahmed_karam/core/utils/app_navigate.dart';
import 'package:ahmed_karam/features/course/data/model/quiz.dart';
import 'package:ahmed_karam/features/course/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:ahmed_karam/features/home/data/models/course.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CourseView extends StatelessWidget {
  const CourseView({super.key, required this.model});
  final Course model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(model.title!), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Container(
                    clipBehavior: Clip.hardEdge,
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),

                    child: CachedNetworkImage(
                      // height: 250,
                      // width: double.infinity,
                      imageUrl: model.image ?? "",
                      fit: BoxFit.fill,
                      errorWidget:
                          (context, url, error) =>
                              Center(child: Icon(Icons.error_outlined)),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(model.des ?? ""),
                  SizedBox(height: 32),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.push(
                            AppNavigate.kAddQuizView,
                            extra: model.id,
                          );
                        },
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            spacing: 8,
                            children: [Text("Add"), Icon(Icons.add_outlined)],
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: Theme.of(context).colorScheme.primaryContainer,
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          spacing: 8,
                          children: [Text("Students"), Text("22")],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 24)),
            BlocConsumer<QuizCubit, QuizState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is GetQuizSuccessState) {
                  return SliverList.builder(
                    itemCount: state.quizzes.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push(
                                AppNavigate.kQuestionView,
                                extra: state.quizzes[index],
                              );
                            },
                            child: QuizItem(model: state.quizzes[index]),
                          ),
                        ),
                  );
                }
                if (state is GetQuizFailureState) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text("error")),
                  );
                }
                return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class QuizItem extends StatelessWidget {
  const QuizItem({super.key, required this.model});
  final Quiz model;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.title ?? "",
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),

            // style: TextStyle(
            //   fontSize: 18,
            //   color: Theme.of(context).colorScheme.secondary,
            // ),
          ),
          SizedBox(height: 8),
          Text(
            model.des ?? "",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            //  TextStyle(
            //   fontSize: 16,
            //   color: Theme.of(context).colorScheme.secondaryContainer,
            // ),
          ),
        ],
      ),
    );
  }
}
