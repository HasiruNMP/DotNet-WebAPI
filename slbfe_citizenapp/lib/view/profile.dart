import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slbfe_citizenapp/view/documents.dart';
import 'package:slbfe_citizenapp/view/personaldetails.dart';
import 'package:slbfe_citizenapp/view/signin.dart';
import 'package:slbfe_citizenapp/view/updatelocation.dart';

import 'accountSetting.dart';
import 'contacts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Center(
              child: InkWell(
                child: ImageIcon(
                  AssetImage("assets/profile.png"),
                  color: Colors.black26,
                  size: 110,
                ),
              ),
            ),
            Container(
                height: 200,
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black26,
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(29, 32, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Ravindu Arsakulasooriya")
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(Icons.mail),
                          SizedBox(
                            width: 10,
                          ),
                          Text("12volt@gmail.com")
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone),
                          SizedBox(
                            width: 10,
                          ),
                          Text("0778888998")
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Icon(Icons.perm_identity),
                          SizedBox(
                            width: 10,
                          ),
                          Text("987006556")
                        ],
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PersonaInfo()),
                    );
                  },
                  child: const Text('More Details'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue))))),
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Documents()),
                    );
                  },
                  child: const Text('Documents'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue))))),
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateLocation()),
                    );
                  },
                  child: const Text('Location'),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.blue)),
                    ),
                  )),
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Contacts()),
                    );
                  },
                  child: const Text('Contacts'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue))))),
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              width: 360,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const accountSetting()),
                    );
                  },
                  child: const Text('Account'),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.blue))))),
            ),
          ],
        ),
      ),
    );
  }
}
