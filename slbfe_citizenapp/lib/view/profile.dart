import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slbfe_citizenapp/view/documents.dart';
import 'package:slbfe_citizenapp/view/personaldetails.dart';
import 'package:slbfe_citizenapp/view/signin.dart';
import 'package:slbfe_citizenapp/view/updatelocation.dart';

import '../api/apiservice.dart';
import 'accountSetting.dart';
import 'contacts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user;
  String fname = '';
  String lname = '';
  String email = '';
  String phoneNo = '';
  String nic = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    CallApi();
  }

  Future<void> CallApi() async {
    user = await APIService.getUserDetails('a@gmail.com');
    updateUi(user);
  }

  void updateUi(dynamic user) {
    setState(() {
      email = user[0]["Email"];
      nic = user[0]["NIC"].toString();
      fname = user[0]["FirstName"];
      lname = user[0]["LastName"];
      phoneNo = user[0]["PrimaryPhone"];
      loading = true;
    });
  }

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
            const Center(
              child: InkWell(
                child: ImageIcon(
                  AssetImage("assets/profile.png"),
                  color: Colors.black26,
                  size: 110,
                ),
              ),
            ),
            loading == true
                ? Container(
                    height: 200,
                    width: 360,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.black26,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(29, 32, 20, 0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person),
                              const SizedBox(
                                width: 10,
                              ),
                              Text('${fname} ${lname}'),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(Icons.mail),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(email)
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(Icons.phone),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(phoneNo)
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Icon(Icons.perm_identity),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(nic)
                            ],
                          ),
                        ],
                      ),
                    ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
            const SizedBox(
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
            const SizedBox(
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
            const SizedBox(
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
            const SizedBox(
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
                              side: const BorderSide(color: Colors.blue))))),
            ),
            const SizedBox(
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
                              side: const BorderSide(color: Colors.blue))))),
            ),
          ],
        ),
      ),
    );
  }
}
