import 'package:ahmed_karam/core/utils/adaptive_ui.dart';
import 'package:ahmed_karam/core/utils/app_navigate.dart';
import 'package:ahmed_karam/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/home_view_mobile.dart';
import 'package:ahmed_karam/features/home/presentation/views/widgets/home_view_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          context.go(AppNavigate.kLoginView);
        }
      },
      builder: (context, state) {
        return AdaptiveUi(
          mobileBuilder: (context) => HomeViewMobile(),
          tabletBuilder: (context) => HomeViewWeb(),
          webBuilder: (context) => HomeViewWeb(),
        );
      },
    ); //
  }
}
