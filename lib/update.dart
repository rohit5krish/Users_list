import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/db/db_function.dart';
import 'package:myapp/db/user_model.dart';

final _upnamecontroller = TextEditingController();
final _upagecontroller = TextEditingController();
final _upplacecontroller = TextEditingController();
final _upphonecontroller = TextEditingController();
var image1;

Future<void> updateUser(BuildContext context, int index, UserModel data) async {
  return showDialog(
      context: context,
      builder: (context) {
        _upnamecontroller.text = data.name;
        _upagecontroller.text = data.age;
        _upplacecontroller.text = data.place;
        _upphonecontroller.text = data.phone;
        return AlertDialog(
          title: Text('UPDATE FORM'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {},
                controller: _upnamecontroller,
                decoration: InputDecoration(hintText: 'Edit Name'),
              ),
              TextField(
                onChanged: (value) {},
                controller: _upagecontroller,
                decoration: InputDecoration(hintText: 'Edit Age'),
              ),
              TextField(
                onChanged: (value) {},
                controller: _upplacecontroller,
                decoration: InputDecoration(hintText: 'Change Branch'),
              ),
              TextField(
                onChanged: (value) {},
                controller: _upphonecontroller,
                decoration: InputDecoration(hintText: 'Edit Mark'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    image1 = await onimgclicked(index);
                  },
                  child: Icon(Icons.image)),
              ElevatedButton(
                  onPressed: () {
                    onupdatebtnclicked(index);
                    Navigator.of(context).pop();
                  },
                  child: Text('Update')),
            ],
          ),
        );
      });
}

Future onimgclicked(index) async {
  XFile? img2 = await ImagePicker().pickImage(source: ImageSource.gallery);
  return img2!.path;
}

Future<void> onupdatebtnclicked(int index) async {
  final _newName = _upnamecontroller.text.trim();
  final _newAge = _upagecontroller.text.trim();
  final _newplace = _upplacecontroller.text.trim();
  final _newphone = _upphonecontroller.text.trim();

  if (_newName.isEmpty ||
      _newAge.isEmpty ||
      _newplace.isEmpty ||
      _newphone.isEmpty) {
    return;
  } else {
    final _updateStudent = UserModel(
        name: _newName,
        age: _newAge,
        place: _newplace,
        phone: _newphone,
        image: image1);
    UpdateAddStudent(_updateStudent, index);
  }
}

Future<void> UpdateAddStudent(UserModel _updateStdt, int idx) async {
  final userDB = await Hive.openBox<UserModel>('user_db');
  final Key = userDB.keys;
  final saved_key = Key.elementAt(idx);
  await userDB.put(saved_key, _updateStdt);
  getAllUsers();
}
