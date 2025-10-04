import 'package:hive/hive.dart';
part 'user_model.g.dart'; // generated file

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? email;
  @HiveField(2)
  String? id;
  @HiveField(3)
  String? image;

  UserModel({this.name, this.email, this.id});
}
