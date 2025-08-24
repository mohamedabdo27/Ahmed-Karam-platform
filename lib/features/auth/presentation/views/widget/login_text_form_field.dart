import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  const LoginTextFormField({
    super.key,
    required this.name,
    required this.hintText,
    this.validator,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });
  final String name, hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          // style: Theme.of(context).textTheme.labelLarge,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          obscureText: obscureText,
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          maxLines: 1,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.labelLarge,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
