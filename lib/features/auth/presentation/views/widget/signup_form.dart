import 'package:ahmed_karam/core/utils/app_navigate.dart';
import 'package:ahmed_karam/core/utils/function/show_error_snack_bar.dart';
import 'package:ahmed_karam/core/utils/function/validate_text_form_field.dart';
import 'package:ahmed_karam/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:ahmed_karam/features/auth/presentation/views/widget/login_button.dart';
import 'package:ahmed_karam/features/auth/presentation/views/widget/login_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<SignupForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final FocusNode focusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    return KeyboardListener(
      focusNode: focusNode,
      autofocus: true,
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          signup(context);
        }
      },
      child: Form(
        key: formKey,
        child: Column(
          spacing: 20,
          children: [
            SizedBox(height: 50),
            LoginTextFormField(
              controller: nameController,
              name: "Name",
              hintText: "Enter your Name",
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "Name mustn.t be empty";
                }
                return null;
              },
            ),
            LoginTextFormField(
              controller: emailController,
              name: "Email",
              hintText: "Enter your email",
              keyboardType: TextInputType.emailAddress,
              validator: (value) => validateEmail(value: value),
            ),
            LoginTextFormField(
              controller: passwordController,
              obscureText: false,
              // suffixIcon: IconButton(
              //   padding: EdgeInsets.zero,
              //   onPressed: () {
              //     // passwordCubit.changePasswordVisibilty();
              //   },
              // //   icon:
              // //       // passwordCubit.isPasswordVisible
              // //       //     ? const Icon(Icons.visibility, size: 17)
              // //       //     : const Icon(Icons.visibility_off, size: 17),
              // // ),
              name: "Password",
              hintText: "Enter your password",
              keyboardType: TextInputType.visiblePassword,
              validator: (value) => validatePassword(value: value),
            ),

            Expanded(child: SizedBox(height: 20)),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is SignupLoadingState) {
                  isLoading = true;
                } else if (state is SignupSuccessState) {
                  isLoading = false;
                  GoRouter.of(context).go(AppNavigate.kHomeView);

                  showSuccessSnackBar(context, msg: "Signup success");
                } else if (state is SignupFailureState) {
                  isLoading = false;
                  showErrorSnackBar(context, msg: state.error);
                } else {
                  isLoading = false;
                }
              },
              builder: (context, state) {
                return LoginButton(
                  isLoading: isLoading,
                  text: "Signup",
                  onTap: () {
                    signup(context);
                  },
                );
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void signup(BuildContext context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<LoginCubit>(context).signup(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
      );
    }
  }
}
