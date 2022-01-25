import 'package:flutter/material.dart';
import 'package:flutter_crud/add_user.dart';
import 'package:flutter_crud/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        //'/': (context) => const MyHomePage(),
        '/add-user': (context) => const AddUser(),
        //'/edit-users': (context) => const MyHomePage(),
      },
    );
  }
}
