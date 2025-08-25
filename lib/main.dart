import 'package:ahmed_karam/core/constants.dart';
import 'package:ahmed_karam/core/utils/app_navigate.dart';
import 'package:ahmed_karam/features/auth/data/models/user_model.dart';
import 'package:ahmed_karam/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<UserModel>(kUserBox);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp.router(
        routerConfig: AppNavigate.router,
        debugShowCheckedModeBanner: false,
        title: 'Ahmed Karam',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            brightness: Brightness.dark,
            seedColor: const Color.fromARGB(255, 54, 61, 61),
          ),
        ),
      ),
    );
  }
}
