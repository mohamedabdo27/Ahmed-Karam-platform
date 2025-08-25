import 'dart:async';
import 'dart:developer';

import 'package:ahmed_karam/core/constants.dart';
import 'package:ahmed_karam/features/auth/data/models/user_model.dart';
import 'package:ahmed_karam/features/auth/data/services/auth_service.dart';
import 'package:ahmed_karam/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:ahmed_karam/features/auth/presentation/views/login_view.dart';
import 'package:ahmed_karam/features/auth/presentation/views/signup_view.dart';
import 'package:ahmed_karam/features/home/presentation/views/course_view.dart';
import 'package:ahmed_karam/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
// import 'package:hive/hive.dart';

class AppNavigate {
  static const String kLoginView = '/login';
  static const String kSignupView = '/kSignupView';
  static const String kHomeView = '/home';
  static const String kCourseView = '/kCourseView';

  // GoRouter configuration
  static final router = GoRouter(
    // refreshListenable: GoRouterRefreshStream(
    //   FirebaseAuth.instance.authStateChanges(),
    // ),
    initialLocation: kHomeView,
    redirect: (context, state) async {
      UserModel? user;
      if (userModel == null) {
        final userBox = Hive.box<UserModel>(kUserBox);
        user = userBox.get(kCurrentUserModelKey);
      } else {
        user = userModel;
      }
      log("current state: ${state.fullPath.toString()}");
      if (user == null) {
        log("null user");
      }
      if (user == null &&
          state.uri.toString() != kLoginView &&
          state.fullPath != kSignupView) {
        log("null and not login");

        return kLoginView;
      } else if (user != null &&
          (state.fullPath == kSignupView || state.fullPath == kLoginView)) {
        return kHomeView;
      }
      // if (user != null) {
      //   return kHomeView;
      // }
      return null;

      // if (user == null) {
      //   log("nullllll");
      // } // If not logged in → always go to login
      // if (user == null && state.fullPath != kloginView) {
      //   log("null user");
      //   return kloginView;
      // }

      // // If logged in → prevent going back to login
      // if (user != null) {
      //   UserModel? myUsererModel;
      //   CollectionReference users = FirebaseFirestore.instance.collection(
      //     'users',
      //   );
      //   final doc = await users.doc(user.uid).get();
      //   var data = doc.data() as Map<String, dynamic>;
      //   if (doc.exists) {
      //     myUsererModel = UserModel();
      //     myUsererModel.email = data['email'];
      //     myUsererModel.id = data['id'];
      //     myUsererModel.name = data['name'];
      //   }
      //   userModel = myUsererModel;
      //   log(userModel!.name.toString());

      //   return kHomeView;
      // }

      // return null;
    },
    routes: [
      GoRoute(
        path: kLoginView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => LoginCubit(AuthService()),
              child: LoginView(),
            ),
      ),
      GoRoute(
        path: kSignupView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => LoginCubit(AuthService()),
              child: SignupView(),
            ),
      ),
      GoRoute(path: kHomeView, builder: (context, state) => HomeView()),
      GoRoute(path: kCourseView, builder: (context, state) => CourseView()),
    ],
  );
}

/// Helper to connect a Stream to GoRouter
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }
  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
