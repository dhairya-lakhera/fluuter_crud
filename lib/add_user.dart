import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  Future<void> sendPostRequest() async {
    print('button pressed');
    final response = await http.post(
      Uri.parse('http://demoapi.reedius.com/api/users/add-user'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': nameController.text,
        'age': ageController.text,
        'gender': genderController.text,
        'email': emailController.text,
        'phone': phoneController.text,
      }),
    );
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add user'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(hintText: 'age'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: genderController,
              decoration: InputDecoration(hintText: 'gender'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'email'),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(hintText: 'phone'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                sendPostRequest();
              },
              child: Text('Add user'),
            ),
          ],
        ),
      ),
    );
  }
}
