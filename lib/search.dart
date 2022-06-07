import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myapp/db/db_function.dart';
import 'package:myapp/db/user_model.dart';

class nameSearch extends SearchDelegate<String> {
  @override
  List<String> names = [];

  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchFinder(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SearchFinder(query: query);
  }
}

class SearchFinder extends StatelessWidget {
  final String query;
  const SearchFinder({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: userlistnotifier,
        builder:
            (BuildContext context, List<UserModel> usrlist, Widget? child) {
          var results = query.isEmpty
              ? usrlist.toList()
              : usrlist
                  .where((c) => c.name.toLowerCase().startsWith(query))
                  .toList();
          return results.isEmpty
              ? Center(
                  child: Text('No Results Found'),
                )
              : ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final UserModel nameslist = results[index];
                    return ListTile(
                      title: Text(nameslist.name),
                      leading: CircleAvatar(
                        backgroundImage: FileImage(File(nameslist.image)),
                      ),
                    );
                  });
        });
  }
}
