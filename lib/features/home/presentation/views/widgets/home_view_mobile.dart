import 'package:ahmed_karam/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/course_item.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/custom_drawer.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: CustomDrawer(),
      body: SafeArea(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is GetCoursesFailureState) {
              return Center(child: Text("error"));
            }
            if (state is GetCoursesSuccessState) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  scaffoldKey.currentState!.openDrawer();
                                },
                                child: Icon(Icons.menu_outlined, size: 30),
                              ),
                              SizedBox(width: 5),
                              SvgPicture.asset(
                                "assets/images/logo.svg",
                                height: 38,
                              ),
                              Spacer(),
                              ProfileImage(),
                            ],
                          ),

                          SizedBox(height: 30),
                          Text(
                            "Featured Courses",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    SliverGrid.builder(
                      itemCount: state.courses.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 300,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 1.8,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return CourseItem(model: state.courses[index]);
                      },
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 16)),
                  ],
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
