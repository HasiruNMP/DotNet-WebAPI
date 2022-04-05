import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'dart:convert';

import 'package:slbfe_website/views/complaints.dart';
import 'package:slbfe_website/views/registration.dart';
import 'package:slbfe_website/views/signin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('SLBFE Dashboard'),
        centerTitle: true,
      ),
      sideBar: SideBar(
        items: const [
          MenuItem(
            title: 'PROFILES',
            route: '0',
            icon: Icons.dashboard,
          ),
          MenuItem(
            title: 'COMPLAINTS',
            route: '1',
            icon: Icons.dashboard,
          ),
          MenuItem(
            title: 'VALIDATE',
            route: '2',
            icon: Icons.dashboard,
          ),
          MenuItem(
            title: 'QUALIFICATIONS',
            route: '3',
            icon: Icons.dashboard,
          ),
          MenuItem(
            title: 'SIGN IN',
            route: '4',
            icon: Icons.dashboard,
          ),
          MenuItem(
            title: 'REGISTRATION',
            route: '5',
            icon: Icons.dashboard,
          ),
        ],
        selectedRoute: '/',
        onSelected: (item) {
          if (item.route != null) {
            controller.jumpToPage(int. parse(item.route!));
          }
        },
        /*header: Container(
          height: 50,
          width: double.infinity,
          color: const Color(0xff444444),
          child: const Center(
            child: Text(
              'header',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),*/
        footer: Container(
          height: 50,
          width: double.infinity,
          color: Colors.blueGrey,
          child: const Center(
            child: Text(
              'footer',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: controller,
        children: const <Widget>[
          Center(
            child: Text('First Page'),
          ),
          Center(
            child: Complaints(),
          ),
          Center(
            child: Text('Third Page'),
          ),
          Center(
            child: Text('Forth Page'),
          ),
          Center(
            child: SignIn(),
          ),
          Center(
            child: Registration(),
          )
        ],
      ),
    );
  }
}
