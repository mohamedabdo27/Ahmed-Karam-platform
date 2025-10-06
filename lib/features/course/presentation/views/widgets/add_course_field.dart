import 'package:flutter/material.dart';

class AddCourseField extends StatelessWidget {
  const AddCourseField({
    super.key,
    required this.title,
    this.maxLines,
    required this.controller,
    this.validator,
  });
  final String title;
  final int? maxLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 5),
        TextFormField(
          validator: validator,
          controller: controller,
          maxLines: 1,

          decoration: InputDecoration(
            hintText: "Enter the text..",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
