import 'package:ahmed_karam/core/utils/adaptive_ui.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/course_item.dart';

import 'package:ahmed_karam/features/home/presentation/views/widgets/home_app_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: AdaptiveUi(
        mobileBuilder: (context) => HomeViewMobile(),
        tabletBuilder: (context) => HomeViewWeb(),
        webBuilder: (context) => HomeViewWeb(),
      ),
    ); //
  }
}

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Welcome to Ahmed Karam Platform")),
          SizedBox(height: 30),
          Text("Courses : "),
          SizedBox(height: 16),

          Expanded(
            child: GridView.builder(
              itemCount: 10,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.8,
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => CourseItem(),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeViewWeb extends StatelessWidget {
  const HomeViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text("Welcome to Ahmed Karam Platform")),
          SizedBox(height: 30),
          Text("Courses : "),
          SizedBox(height: 16),

          Expanded(
            child: GridView.builder(
              itemCount: 200,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.8,
                maxCrossAxisExtent: 300,
              ),
              itemBuilder: (context, index) => CourseItem(),
            ),
          ),
        ],
      ),
    );
  }
}
