import 'package:ahmed_karam/core/utils/adaptive_ui.dart';
import 'package:ahmed_karam/features/course/presentation/views/widgets/add_course_view_mobile.dart';
import 'package:ahmed_karam/features/course/presentation/views/widgets/add_course_view_web.dart';
import 'package:flutter/material.dart';

class AddCourseView extends StatelessWidget {
  const AddCourseView({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveUi(
      mobileBuilder: (context) => AddCourseViewMobile(),
      tabletBuilder: (context) => AddCourseViewWeb(),
      webBuilder: (context) => AddCourseViewWeb(),
    );
  }
}
