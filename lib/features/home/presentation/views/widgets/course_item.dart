import 'package:ahmed_karam/core/utils/app_navigate.dart';
import 'package:ahmed_karam/features/home/data/models/course.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({super.key, required this.model});
  final Course model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppNavigate.kCourseView, extra: model);
      },
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: const Color.fromARGB(255, 64, 102, 100),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Expanded(
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: model.image ?? "",
                fit: BoxFit.cover,
                errorWidget:
                    (context, url, error) =>
                        Center(child: Icon(Icons.error_outlined)),
              ),

              // Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       fit: BoxFit.cover,
              //       image: AssetImage("assets/images/profile_image.jpeg"),
              //     ),
              //   ),
              // ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title ?? " ",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      model.des ?? " ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Spacer(),

                    FittedBox(
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.book_outlined, size: 16),
                              SizedBox(width: 5),
                              Text("15", style: TextStyle(fontSize: 12)),
                              SizedBox(width: 5),
                              Text("Quizzes", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                          SizedBox(width: 16),

                          Row(
                            children: [
                              Icon(Icons.group_rounded, size: 16),
                              SizedBox(width: 5),
                              Text("100", style: TextStyle(fontSize: 12)),
                              SizedBox(width: 5),
                              Text("Students", style: TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
