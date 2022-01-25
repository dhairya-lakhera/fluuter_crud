import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<User>> fetchUser() async {
  final response =
      await http.get(Uri.parse('http://demoapi.reedius.com/api/users/'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> usersList = jsonDecode(response.body);

    List<User> userObject = usersList.map((e) {
      return User.fromJson(e);
    }).toList();

    return userObject;

    //return User.fromJson();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load user');
  }
}

class User {
  final int id;
  final String name;
  final String email;

  const User({
    required this.id,
    required this.name,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

void main() => runApp(const MyHomePage());

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<User>> futureUser = fetchUser();
  //futureUser = fetchUser();

  @override
  void initState() {
    super.initState();
    //futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fetch Data Example'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add-user').then((_) {
                setState(() {
                  futureUser = fetchUser();
                });
              });
              //Navigator.pushNamed(context, '/add-user');
            },
            icon: Icon(Icons.add),
            padding: EdgeInsets.only(right: 20),
            iconSize: 30,
          )
        ],
      ),
      body: Column(
        children: [
          FutureBuilder<List<User>>(
            future: futureUser,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(snapshot.data![index].name),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                  size: 16,
                                ),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 16,
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                        );
                        // return ListTile(
                        //   title: Text(snapshot.data![index].name),
                        //   trailing: ,
                        // );
                      }),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
