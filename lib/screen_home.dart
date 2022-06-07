// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/db/db_function.dart';
import 'package:myapp/db/user_model.dart';
import 'package:myapp/list_students.dart';
import 'package:myapp/search.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final _namecontroller = TextEditingController();

  final _agecontroller = TextEditingController();

  final _placecontroller = TextEditingController();

  final _phonecontroller = TextEditingController();

  var _image;
  @override
  Widget build(BuildContext context) {
    getAllUsers();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: nameSearch());
              },
              icon: Icon(Icons.search))
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color.fromARGB(255, 40, 238, 123),
          child: listStudents(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showbottom(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showbottom(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: (ctx),
        builder: (ctx) {
          return Container(
              width: double.infinity,
              height: 500,
              color: Color.fromARGB(255, 223, 199, 207),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Text(
                      'Add Users',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(height: 30),
                    TextFormField(
                      controller: _namecontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Name'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _agecontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Age'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _placecontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Place'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _phonecontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Phone number'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          var image = await pickImage();
                          setState(() {
                            _image = image;
                          });
                        },
                        child: Icon(Icons.image_outlined)),
                    ElevatedButton(
                        onPressed: () {
                          btnclicked();
                          Navigator.of(context).pop();
                          _namecontroller.clear();
                          _agecontroller.clear();
                          _placecontroller.clear();
                          _phonecontroller.clear();
                        },
                        child: Text('Add'))
                  ],
                ),
              ));
        });
  }

  Future pickImage() async {
    // final image = await ImagePicker().getImage(source: ImageSource.gallery);
    // if (image == null) return;
    // final imgtemp = File(image.path);
    // this.image = imgtemp;

    XFile? img = await ImagePicker().pickImage(source: ImageSource.gallery);
    return img!.path;
  }

  Future<void> btnclicked() async {
    final _name = _namecontroller.text.trim();
    final _age = _agecontroller.text.trim();
    final _place = _placecontroller.text.trim();
    final _phone = _phonecontroller.text.trim();

    if (_name.isEmpty || _age.isEmpty || _place.isEmpty || _phone.isEmpty) {
      return;
    } else {
      final _add = UserModel(
          name: _name, age: _age, place: _place, phone: _phone, image: _image);
      adduser(_add);
    }
  }

  // Widget searchfield() {
  //   return Container(
  //     width: 300,
  //     height: 50,
  //     decoration: BoxDecoration(
  //         color: Colors.white60, borderRadius: BorderRadius.circular(15)),
  //     child: TextField(
  //       decoration: InputDecoration(
  //           hintText: 'Search for Users',
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.only(left: 15)),
  //       onChanged: (value) {
  //         userlistnotifier.value = userlistnotifier.value
  //             .where((user) =>
  //                 user.name.toLowerCase().contains(value.toLowerCase()))
  //             .toList();
  //         userlistnotifier.notifyListeners();

  //         if (value == '') {
  //           getAllUsers();
  //         } else if (userlistnotifier.value.isEmpty) {
  //           getAllUsers();
  //         }
  //       },
  //     ),
  //   );
  // }
}
