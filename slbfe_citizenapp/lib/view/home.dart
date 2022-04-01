import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/view/addcomplaint.dart';
import 'package:slbfe_citizenapp/view/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        child: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
