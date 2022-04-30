import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slbfe_citizenapp/api/userAuth.dart';
import 'package:slbfe_citizenapp/view/addcomplaint.dart';
import 'package:slbfe_citizenapp/view/bottomnavigation.dart';
import 'package:slbfe_citizenapp/view/complain_list.dart';
import 'package:slbfe_citizenapp/view/home.dart';
import 'package:slbfe_citizenapp/view/personaldetails.dart';
import 'package:slbfe_citizenapp/view/registration.dart';
import 'package:slbfe_citizenapp/view/signin.dart';
import 'package:slbfe_citizenapp/view/statecontroller.dart';

import 'package:slbfe_citizenapp/global.dart' as global;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAuth()),
      ],
      child: const MyApp(),
    ),
  );
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
      routes: {
        SignIn.id: (context) => SignIn(),
      },
      home: BottomNavigation(global.nic),
    );
  }
}
