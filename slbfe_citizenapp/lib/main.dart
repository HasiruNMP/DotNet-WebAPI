import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/view/accountSetting.dart';
import 'package:slbfe_citizenapp/view/bottomnavigation.dart';
import 'package:slbfe_citizenapp/view/home.dart';
import 'package:slbfe_citizenapp/view/login.dart';
import 'package:slbfe_citizenapp/view/profile.dart';
import 'package:slbfe_citizenapp/view/resetPassword.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigation(),
    );
  }
}
