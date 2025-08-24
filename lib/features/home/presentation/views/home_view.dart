import 'package:ahmed_karam/core/utils/adaptive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset('assets/images/logo.svg'),
        actions: [
          CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage("assets/images/profile_image.jpeg"),
          ),
        ],
      ),
      body: AdaptiveUi(
        mobileBuilder: (context) => HomeViewMobile(),
        tabletBuilder: (context) => HomeViewWeb(),
        webBuilder: (context) => HomeViewWeb(),
      ),
    );
  }
}

class HomeViewMobile extends StatelessWidget {
  const HomeViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class HomeViewWeb extends StatelessWidget {
  const HomeViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
