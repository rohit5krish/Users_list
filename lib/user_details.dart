import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/db/db_function.dart';
import 'package:myapp/db/user_model.dart';
import 'package:myapp/update.dart';

class userDetails extends StatelessWidget {
  late int idx;
  userDetails({required idx, Key? key}) : super(key: key) {
    this.idx = idx;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
      backgroundColor: Colors.green,
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: userlistnotifier,
              builder: (BuildContext context, List<UserModel> usrlist,
                  Widget? child) {
                final img = usrlist[idx];
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: FileImage(File(img.image)),
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 200,
                        width: 320,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 125, 204, 235),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Name : ${img.name}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Age : ${img.age}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Place : ${img.place}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Phone Number : ${img.phone}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            updateUser(context, idx, img);
                          },
                          child: Text('Edit Details'))
                    ],
                  ),
                );
              })),
    );
  }
}
