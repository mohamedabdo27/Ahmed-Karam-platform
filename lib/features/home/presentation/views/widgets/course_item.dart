import 'package:ahmed_karam/core/utils/app_navigate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CourseItem extends StatelessWidget {
  const CourseItem({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppNavigate.kCourseView);
      },
      child: Container(
        width: 500,
        height: 200,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/images/profile_image.jpeg"),
          ),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 1),
        ),
      ),
    );
  }
}
