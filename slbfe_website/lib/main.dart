import 'package:flutter/material.dart';
import 'package:slbfe_website/views/complaints.dart';
import 'package:slbfe_website/views/home_screen.dart';
import 'package:slbfe_website/views/map.dart';
import 'package:slbfe_website/views/search.dart';
import 'package:slbfe_website/views/signin.dart';
import 'package:slbfe_website/views/test.dart';

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
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: SignIn(),
    );
  }
}
