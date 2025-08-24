import 'package:ahmed_karam/features/auth/data/models/user_model.dart';
import 'package:hive/hive.dart';

Future<void> cachUserModel({required UserModel userModel}) async {
  final userBox = Hive.box<UserModel>('userBox');

  await userBox.put('currentUser', userModel);
}
