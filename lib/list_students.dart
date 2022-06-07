import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/db/db_function.dart';
import 'package:myapp/db/user_model.dart';
import 'package:myapp/user_details.dart';

class listStudents extends StatelessWidget {
  listStudents({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: userlistnotifier,
      builder: (BuildContext context, List<UserModel> userlist, Widget? child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final data = userlist[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return userDetails(idx: index);
                  }));
                },
                leading: CircleAvatar(
                  backgroundImage: FileImage(File(data.image)),
                ),
                title: Text(
                  data.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                trailing: IconButton(
                    onPressed: () {
                      dltbtnpressed(context, index);
                    },
                    icon: Icon(Icons.delete)),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: userlist.length);
      },
    );
  }

  dltbtnpressed(BuildContext context, index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete User'),
            content: Text('Are You sure to want to delete the user?'),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteStudents(index);
                    Navigator.of(context).pop();
                  },
                  child: Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }
}
