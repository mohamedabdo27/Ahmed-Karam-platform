import 'package:ahmed_karam/features/home/data/models/course.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/course_item.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/profile_image.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/menu_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeViewWeb extends StatelessWidget {
  const HomeViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Color(0xff192628),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/images/logo.svg", height: 38),
                  SizedBox(height: 30),
                  MenuListTile(
                    title: "Home",
                    icon: Icons.home_outlined,
                    onTap: () {},
                  ),
                  SizedBox(height: 16),
                  MenuListTile(
                    title: "My Courses",
                    icon: Icons.book_outlined,
                    onTap: () {},
                  ),
                  SizedBox(height: 16),
                  MenuListTile(
                    title: "Profile",
                    icon: Icons.person_outlined,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Row(children: [Spacer(), ProfileImage()]),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            "Welcome to Ahmed Karam Platform",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
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
                    itemCount: 3,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 1.8,
                      maxCrossAxisExtent: 400,
                      mainAxisExtent: 400,
                    ),
                    itemBuilder: (context, index) {
                      return CourseItem(
                        model: Course(
                          image: "image",
                          title: "title",
                          des: "des",
                          id: "",
                        ),
                        // title: "Course 1",
                        // des: "This should be a short description of the course",
                      );
                    },
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
