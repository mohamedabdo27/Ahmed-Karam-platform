import 'package:ahmed_karam/core/utils/adaptive_ui.dart';
import 'package:ahmed_karam/features/auth/presentation/views/widget/login_form.dart';

import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: AdaptiveUi(
          mobileBuilder: (context) => LoginViewMobile(),
          tabletBuilder: (context) => LoginViewWeb(),
          webBuilder: (context) => LoginViewWeb(),
        ),
      ),
    );
  }
}

class LoginViewMobile extends StatelessWidget {
  const LoginViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: LoginForm(),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginViewWeb extends StatelessWidget {
  const LoginViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: SizedBox(width: 400, child: LoginForm())),
        ),
      ],
    );
  }
}

class LoginViewTablet extends StatelessWidget {
  const LoginViewTablet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
