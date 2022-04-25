import 'dart:async';
import 'dart:convert';
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
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("SEARCH"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ProfileWidget(1001),
          ),
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  int nic;
  ProfileWidget(this.nic);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.indigo.shade50,
          //width: MediaQuery.of(context).size.width/1.5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
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
                              Qualifications(nic),
                              Documents(nic),
                              Location(nic),
                              Contacts(nic),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  Future<void> getProfileInfo() async {}

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        CircleAvatar(
          radius: 70,
          backgroundColor: Colors.indigo,
          backgroundImage: NetworkImage(
              'https://10.0.2.2:7018/documents/profilepic?NIC=1001'),
        ),
        Expanded(
            child: ListView(
          children: [
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
        )),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {},
                child: Text('Mark As Validated'),
              ),
              OutlinedButton(
                onPressed: () async {
                  var request = http.Request('DELETE', Uri.parse('https://localhost:7018/api/JsUser/DeactivateUser?nic=76'));
                  http.StreamedResponse response = await request.send();
                  if (response.statusCode == 200) {
                    print(await response.stream.bytesToString());
                  } else {
                    print(response.reasonPhrase);
                  }
                },
                child: Text('Deactivate Accoount'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }
}

class Qualifications extends StatefulWidget {
  int nic;
  Qualifications(this.nic);

  @override
  State<Qualifications> createState() => _QualificationsState();
}

class _QualificationsState extends State<Qualifications> {
  List qualifications = [];
  bool isLoaded = false;

  Future<void> getQualifications() async {
    String url =
        "https://localhost:7018/jobseekers/qualifications/ofuser?NIC=${widget.nic}";
    final response = await http.get(Uri.parse(url));
    var resJson = json.decode(response.body);
    if (response.statusCode == 200) {
      var a = resJson as List;
      qualifications = a.toList();
      print(qualifications);
      setState(() => isLoaded = true);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    getQualifications();
  }

  @override
  Widget build(BuildContext context) {
    return (isLoaded)
        ? ListView(
            children: [
              ListTile(
                title: Text(
                  "OL Science",
                  style: TextStyle(
                      //fontSize: 16,
                      ),
                ),
                subtitle: Text(
                  qualifications[0]['OLScience'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "OL Maths",
                  style: TextStyle(
                      //fontSize: 16,
                      ),
                ),
                subtitle: Text(
                  qualifications[0]['OLMaths'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "OL English",
                  style: TextStyle(
                      //fontSize: 16,
                      ),
                ),
                subtitle: Text(
                  qualifications[0]['OLEnglish'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "AL Stream",
                  style: TextStyle(
                      //fontSize: 16,
                      ),
                ),
                subtitle: Text(
                  qualifications[0]['ALStream'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  qualifications[0]['ALResults'],
                  style: TextStyle(
                      //fontSize: 16,
                      ),
                ),
                subtitle: Text(
                  "3 Passes",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "AL English",
                  style: TextStyle(
                      //fontSize: 16,
                      ),
                ),
                subtitle: Text(
                  qualifications[0]['ALEnglish'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Higher Education Level",
                  style: TextStyle(
                      //fontSize: 16,
                      ),
                ),
                subtitle: Text(
                  qualifications[0]['HigherEducation'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  "Higher Education Field",
                  style: TextStyle(
                      //fontSize: 16,
                      ),
                ),
                subtitle: Text(
                  qualifications[0]['HigherEducationField'],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

class Documents extends StatefulWidget {
  int nic;
  Documents(this.nic);

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
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("CV"),
                  OutlinedButton(
                    child: Text("Download"),
                    onPressed: () {
                      downloadFile();
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("OL Exam Certificate"),
                OutlinedButton(
                  child: Text("Download"),
                  onPressed: () {
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
                Text("AL Exam Certificate"),
                OutlinedButton(
                  child: Text("Download"),
                  onPressed: () {
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
                Text("Higher Education Cetificate"),
                OutlinedButton(
                  child: Text("Download"),
                  onPressed: () {
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
                Text("Vaccination Card"),
                OutlinedButton(
                  child: Text("Download"),
                  onPressed: () {
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
                Text("Passport"),
                OutlinedButton(
                  child: Text("Download"),
                  onPressed: () {
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
                Text("License"),
                OutlinedButton(
                  child: Text("Download"),
                  onPressed: () {
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
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://localhost:7018/documents/download?NIC=1&documentType=CV'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

class Contacts extends StatefulWidget {
  int nic;
  Contacts(this.nic);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List contacts = [];
  bool isLoaded = false;

  Future<void> getContacts() async {
    String url = "https://localhost:7018/api/JsUser/getContacts?nic=1001";
    final response = await http.get(Uri.parse(url));
    var resJson = json.decode(response.body);
    if (response.statusCode == 200) {
      var a = resJson as List;
      contacts = a.toList();
      print(contacts);
      setState(() => isLoaded = true);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (isLoaded)
          ? ListView(
              children: [
                ListTile(
                  title: Text(
                    "Primary Contact",
                    style: TextStyle(
                        //fontSize: 16,
                        ),
                  ),
                  subtitle: Text(
                    contacts[0]['Personal'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Work Contact",
                    style: TextStyle(
                        //fontSize: 16,
                        ),
                  ),
                  subtitle: Text(
                    contacts[0]['Work'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Emergency Contact",
                    style: TextStyle(
                        //fontSize: 16,
                        ),
                  ),
                  subtitle: Text(
                    contacts[0]['Emmergency'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
