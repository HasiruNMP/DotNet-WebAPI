import 'dart:async';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:slbfe_website/views/map.dart';
import 'package:http/http.dart' as http;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'NIC',
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: (){},
                    child: Text("SEARCH"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.teal.shade50,
              width: MediaQuery.of(context).size.width/1.5,
              child: ProfileWidget(),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: PersonalInfo(),
        ),
        VerticalDivider(),
        Expanded(
          flex: 5,
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: <Widget>[
                ButtonsTabBar(
                  backgroundColor: Colors.indigo,
                  unselectedBackgroundColor: Colors.grey[300],
                  unselectedLabelStyle: TextStyle(color: Colors.black),
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(
                      //icon: Icon(Icons.directions_transit),
                      text: "   Qualifications   ",
                    ),
                    Tab(
                      //icon: Icon(Icons.directions_transit),
                      text: "   Documents   ",
                    ),
                    Tab(
                      //icon: Icon(Icons.directions_transit),
                      text: "   Location   ",
                    ),
                    Tab(
                      //icon: Icon(Icons.directions_transit),
                      text: "   Contacts   ",
                    ),
                  ],
                ),
                Divider(),
                Expanded(
                  child: TabBarView(
                    children: <Widget>[
                      Qualifications(),
                      Documents(),
                      MyHomePage(),
                      Contacts(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 12,
        ),
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.indigo,
        ),
        ListTile(
          title: Text("Name"),
          subtitle: Text("Hasiru Navodya"),
        ),
        ListTile(
          title: Text("NIC"),
          subtitle: Text("983274938"),
        ),
        ListTile(
          title: Text("Email"),
          subtitle: Text("hasirunmp@gmail.com"),
        ),
        ListTile(
          title: Text("Phone"),
          subtitle: Text("0702435206"),
        ),
        ListTile(
          title: Text("Date of Birth"),
          subtitle: Text("1998.11.09"),
        ),
        ListTile(
          title: Text("Address"),
          subtitle: Text("Ratnapura"),
        ),
        ListTile(
          title: Text("Proffesion"),
          subtitle: Text("Student"),
        ),
        ListTile(
          title: Text("Gender"),
          subtitle: Text("Male"),
        ),
        ListTile(
          title: Text("Nationality"),
          subtitle: Text("Sri Lankan"),
        ),
        ListTile(
          title: Text("Marital Status"),
          subtitle: Text("Single"),
        ),
      ],
    );
  }
}

class Qualifications extends StatelessWidget {
  const Qualifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Ordinary Level"),
              ),
              Wrap(
                spacing: 2,
                children: [
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: const Text('A'),
                    ),
                    label: const Text('Mathematics'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: const Text('B'),
                    ),
                    label: const Text('Science'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: const Text('C'),
                    ),
                    label: const Text('English'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: const Text('C'),
                    ),
                    label: const Text('ICT'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Advanced Level"),
              ),
              Wrap(
                spacing: 2,
                children: [
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: const Text('A'),
                    ),
                    label: const Text('Physics'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: const Text('B'),
                    ),
                    label: const Text('Chemistry'),
                  ),
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: const Text('B'),
                    ),
                    label: const Text('Mathematics'),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Higher Education"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Degree Type - BSc"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Degree Field - Computer Science"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ordinary Level Exam Certificate"),
                OutlinedButton(
                  child: Text("Download"),
                  onPressed: (){
                    downloadFile();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ordinary Level Exam Certificate"),
                OutlinedButton(
                  child: Text("Download"),
                  onPressed: (){
                    downloadFile();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> downloadFile() async {
    var request = http.Request('GET', Uri.parse('https://localhost:7018/documents/download?NIC=1&documentType=CV'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }
}

class Contacts extends StatelessWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          ListTile(
            title: Text("Personal"),
            subtitle: Text("237492839"),
          ),
          ListTile(
            title: Text("Work"),
            subtitle: Text("237492839"),
          ),
          ListTile(
            title: Text("Emergency"),
            subtitle: Text("237492839"),
          )
        ],
      ),
    );
  }
}

