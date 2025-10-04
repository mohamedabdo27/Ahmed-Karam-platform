import 'package:ahmed_karam/features/course/presentation/manager/add_course_cubit/add_course_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCourseImage extends StatefulWidget {
  const AddCourseImage({super.key});

  @override
  State<AddCourseImage> createState() => AddCourseImageState();
}

class AddCourseImageState extends State<AddCourseImage> {
  bool isSelected = true;
  bool validate() {
    AddCourseCubit cubit = BlocProvider.of<AddCourseCubit>(context);

    if (cubit.courseImage == null) {
      setState(() {
        isSelected = false;
      });
      return false;
    } else {
      setState(() {
        isSelected = true;
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    AddCourseCubit cubit = BlocProvider.of<AddCourseCubit>(context);

    return GestureDetector(
      onTap: () {
        cubit.pickImage();
      },
      child: Container(
        height: 250,
        decoration: BoxDecoration(
          image:
              cubit.courseImage == null
                  ? null
                  : DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(cubit.courseImage!),
                  ),
          border: Border.all(
            color:
                isSelected == true || cubit.courseImage != null
                    ? Theme.of(context).colorScheme.onSecondaryContainer
                    : Colors.red,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child:
            cubit.courseImage != null
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
    );
  }
}
