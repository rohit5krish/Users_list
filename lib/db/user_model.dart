import 'dart:io';

import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String age;

  @HiveField(2)
  final String place;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final image;

  UserModel({
    required this.name,
    required this.age,
    required this.place,
    required this.phone,
    required this.image,
  });
}
