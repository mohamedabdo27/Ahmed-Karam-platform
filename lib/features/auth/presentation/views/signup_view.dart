import 'package:ahmed_karam/core/utils/adaptive_ui.dart';
import 'package:ahmed_karam/features/auth/presentation/views/widget/signup_form.dart';
import 'package:flutter/material.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: AdaptiveUi(
        mobileBuilder: (contxet) => SignupMobileView(),
        tabletBuilder: (contxet) => SignupWebView(),
        webBuilder: (contxet) => SignupWebView(),
      ),
    );
  }
}

class SignupMobileView extends StatelessWidget {
  const SignupMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: SignupForm(),
            ),
          ),
        ),
      ],
    );
  }
}

class SignupWebView extends StatelessWidget {
  const SignupWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: SizedBox(width: 400, child: SignupForm())),
        ),
      ],
    );
  }
}
