import 'dart:async';
import 'dart:developer';

import 'package:ahmed_karam/features/auth/data/models/user_model.dart';
import 'package:ahmed_karam/features/auth/data/services/auth_service.dart';
import 'package:ahmed_karam/features/auth/presentation/manager/login_cubit/login_cubit.dart';
import 'package:ahmed_karam/features/auth/presentation/views/login_view.dart';
import 'package:ahmed_karam/features/auth/presentation/views/signup_view.dart';
import 'package:ahmed_karam/features/home/presentation/views/home_view.dart';
import 'package:ahmed_karam/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

class AppNavigate {
  static const String kLoginView = '/login';
  static const String kSignupView = '/kSignupView';
  static const String kHomeView = '/home';

  // GoRouter configuration
  static final router = GoRouter(
    // refreshListenable: GoRouterRefreshStream(
    //   FirebaseAuth.instance.authStateChanges(),
    // ),
    initialLocation: kHomeView,
    redirect: (context, state) async {
      UserModel? user;
      if (userModel == null) {
        final userBox = Hive.box<UserModel>('userBox');
        user = userBox.get('currentUser');
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
