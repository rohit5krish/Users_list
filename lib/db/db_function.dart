import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:myapp/db/user_model.dart';

ValueNotifier<List<UserModel>> userlistnotifier = ValueNotifier([]);

Future<void> adduser(UserModel value) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userDB.add(value);
  userlistnotifier.value.add(value);
  userlistnotifier.notifyListeners();
}

Future<void> getAllUsers() async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  userlistnotifier.value.clear();
  userlistnotifier.value.addAll(userDB.values);
  userlistnotifier.notifyListeners();
}

Future<void> deleteStudents(int id) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  final Key = userDB.keys;
  final saved_key = Key.elementAt(id);
  await userDB.delete(saved_key);

  getAllUsers();
}
