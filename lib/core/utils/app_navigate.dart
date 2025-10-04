import 'dart:async';

import 'package:ahmed_karam/core/constants.dart';
import 'package:ahmed_karam/features/auth/data/models/user_model.dart';
import 'package:ahmed_karam/features/auth/data/services/auth_service.dart';
import 'package:ahmed_karam/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:ahmed_karam/features/auth/presentation/views/login_view.dart';
import 'package:ahmed_karam/features/auth/presentation/views/signup_view.dart';
import 'package:ahmed_karam/features/course/data/model/quiz.dart';
import 'package:ahmed_karam/features/course/presentation/manager/add_course_cubit/add_course_cubit.dart';
import 'package:ahmed_karam/features/course/presentation/manager/quiz_cubit/quiz_cubit.dart';
import 'package:ahmed_karam/features/course/presentation/views/add_course_view.dart';
import 'package:ahmed_karam/features/course/presentation/views/course_view.dart';
import 'package:ahmed_karam/features/home/data/models/course.dart';
import 'package:ahmed_karam/features/home/presentation/views/home_view.dart';
import 'package:ahmed_karam/features/quiz/presentation/manager/add_quiz_cubit/add_quiz_cubit.dart';
import 'package:ahmed_karam/features/quiz/presentation/views/add_quiz_view.dart';
import 'package:ahmed_karam/features/quiz/presentation/views/question_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
// import 'package:hive/hive.dart';

class AppNavigate {
  static const String kLoginView = '/login';
  static const String kSignupView = '/kSignupView';
  static const String kHomeView = '/home';
  static const String kAddCourseView = '/kAddCourseView';
  static const String kCourseView = '/kCourseView';
  static const String kAddQuizView = '/kAddQuizView';
  static const String kQuestionView = '/kQuestionView';

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
      // log("current state: ${state.fullPath.toString()}");
      // if (user == null) {
      //   log("null user");
      // }
      if (user == null &&
          state.uri.toString() != kLoginView &&
          state.fullPath != kSignupView) {
        // log("null and not login");

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
      GoRoute(
        path: kAddCourseView,
        builder:
            (context, state) => BlocProvider(
              create: (context) => AddCourseCubit(),
              child: AddCourseView(),
            ),
      ),
      GoRoute(
        path: kCourseView,
        builder: (context, state) {
          Course course = state.extra as Course;

          return BlocProvider(
            create: (context) => QuizCubit()..getQuizzes(id: course.id!),
            child: CourseView(model: course),
          );
        },
      ),
      GoRoute(
        path: kAddQuizView,
        builder: (context, state) {
          final String id = state.extra as String;
          return BlocProvider(
            create: (context) => AddQuizCubit(),
            child: AddQuizView(courseId: id),
          );
        },
      ),
      GoRoute(
        path: kQuestionView,
        builder: (context, state) {
          Quiz model = state.extra as Quiz;
          return BlocProvider(
            create: (context) => AddQuizCubit(),
            child: QuestionView(quiz: model),
          );
        },
      ),
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
