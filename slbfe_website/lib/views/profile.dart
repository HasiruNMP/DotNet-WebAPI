import 'dart:async';
import 'dart:convert';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';
import 'package:slbfe_website/views/location.dart';
import 'package:slbfe_website/views/map.dart';
import 'package:http/http.dart' as http;
import 'dart:js' as js;
import 'package:slbfe_website/global.dart';

int lastNic = 0;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  //bool searched = false;
  int nic = 0;
  final tecNIC = TextEditingController();

  void setNIC() {
    setState(() {
      var nicInt = int.parse(tecNIC.text);
      assert(nicInt is int);
      nic = nicInt;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (nic != 0)? ProfileWidget(nic) : Center(
        child: Column(
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
              onPressed: () {
                setNIC();
              },
              child: Text("SEARCH"),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileWidget extends StatefulWidget {
  int nic;
  ProfileWidget(this.nic);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    print('**********###################');
  }

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
                  child: PersonalInfo(widget.nic),
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
                              Qualifications(widget.nic),
                              Documents(widget.nic),
                              Location(widget.nic),
                              Contacts(widget.nic),
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
  int nic;
  PersonalInfo(this.nic);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool isLoaded = false;

  Future<List> getUserInfo() async {
    List userInfo = [];
    String url = "${Urls.apiUrl}/api/JsUser?nic=${widget.nic}";
    final response = await http.get(Uri.parse(url));
    var resJson = json.decode(response.body);
    if (response.statusCode == 200) {
      var a = resJson as List;
      userInfo = a.toList();
      print(userInfo);
      return userInfo;
      //setState(() => isLoaded = true);
    } else {
      return userInfo;
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    //getUserInfo();
  }

  TextStyle style1 = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const snackBar = SnackBar(
    content: Text('Marked the User as Validated!'),
  );
  static const snackBar2 = SnackBar(
    content: Text('Error Marking as Validated!'),
  );
  static const snackBar3 = SnackBar(
    content: Text('Deactivated the User!'),
  );
  static const snackBar4 = SnackBar(
    content: Text('Error Deactivating the User!'),
  );

  Future <void> validateUser()async{

    var request = http.Request('PUT', Uri.parse('${Urls.apiUrl}/api/JsUser/updateValidity?NIC=222222222'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    else {
      print(response.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.indigo,
            backgroundImage: NetworkImage(
                '${Urls.apiUrl}/documents/profilepic?NIC=${widget.nic}'),
          ),
          Expanded(
              child: FutureBuilder(
            future: getUserInfo(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                List? list = snapshot.data;
                //DateTime dob = list![0]['DOB'];
                return ListView(
                  children: [
                    ListTile(
                      title: Text("Name"),
                      subtitle: Text(
                        "${list![0]['FirstName']} ${list[0]['LastName']}",
                        style: style1,
                      ),
                    ),
                    ListTile(
                      title: Text("NIC"),
                      subtitle: Text(
                        list[0]['NIC'].toString(),
                        style: style1,
                      ),
                    ),
                    ListTile(
                      title: Text("Email"),
                      subtitle: Text(
                        list[0]['Email'],
                        style: style1,
                      ),
                    ),
                    ListTile(
                      title: Text("Phone"),
                      subtitle: Text(
                        list[0]['PrimaryPhone'],
                        style: style1,
                      ),
                    ),
                    ListTile(
                      title: Text("Date of Birth"),
                      subtitle: Text(
                        list[0]['DOB'].toString(),
                        style: style1,
                      ),
                    ),
                    ListTile(
                      title: Text("Address"),
                      subtitle: Text(
                        list[0]['Address'],
                        style: style1,
                      ),
                    ),
                    ListTile(
                      title: Text("Proffesion"),
                      subtitle: Text(
                        list[0]['Profession'],
                        style: style1,
                      ),
                    ),
                    ListTile(
                      title: Text("Gender"),
                      subtitle: Text(
                        list[0]['Gender'],
                        style: style1,
                      ),
                    ),
                    ListTile(
                      title: Text("Nationality"),
                      subtitle: Text(
                        list[0]['Nationality'],
                        style: style1,
                      ),
                    ),
                    ListTile(
                      title: Text("Marital Status"),
                      subtitle: Text(
                        list[0]['MaritalStatus'],
                        style: style1,
                      ),
                    ),
                  ],
                );
              }
              if (snapshot.hasError) {
                return Text("No Data");
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
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
                  onPressed: () {
                    validateUser();
                  },
                  child: Text('Mark As Validated'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    var request = http.Request(
                        'DELETE',
                        Uri.parse(
                            '${Urls.apiUrl}/api/JsUser/DeactivateUser?nic=${widget.nic}'));
                    http.StreamedResponse response = await request.send();
                    if (response.statusCode == 200) {
                      print(await response.stream.bytesToString());
                      ScaffoldMessenger.of(context).showSnackBar(snackBar3);
                    } else {
                      print(response.reasonPhrase);
                      ScaffoldMessenger.of(context).showSnackBar(snackBar4);
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
      ),
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

  Future<List> getQualifications() async {
    String url = "${Urls.apiUrl}/jobseekers/qualifications/ofuser?NIC=${widget.nic}";
    final response = await http.get(Uri.parse(url));
    var resJson = json.decode(response.body);
    if (response.statusCode == 200) {
      var a = resJson as List;
      qualifications = a.toList();
      print(qualifications);
      return qualifications;
      //setState(() => isLoaded = true);
    } else {
      return qualifications;
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    //getQualifications();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: getQualifications(),
        builder: (context, snapshot) {

          if(snapshot.hasData){
            List? qs = snapshot.data;

            return ListView(
              children: [
                ListTile(
                  title: Text(
                    "OL Science",
                    style: TextStyle(
                      //fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    qs![0]['OLScience'],
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
                    qs[0]['OLMaths'],
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
                    qs[0]['OLEnglish'],
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
                    qs[0]['ALStream'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  title: Text(
                    "AL Results",
                    style: TextStyle(
                      //fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    qs[0]['ALResults'],
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
                    qs[0]['ALEnglish'],
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
                    qs[0]['HigherEducation'],
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
                    qs[0]['HigherEducationField'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());

        }
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
                      downloadFile(docType: 'CV');
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
                    downloadFile(docType: 'OLCertificate');
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
                    downloadFile(docType: 'ALCertificate');
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
                    downloadFile(docType: 'DegreeCertificate');
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
                    downloadFile(docType: 'Vaccination');
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
                    downloadFile(docType: 'Passport');
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
                    downloadFile(docType: 'License');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> downloadFile({required String docType}) async {
    js.context.callMethod('open', [
      '${Urls.apiUrl}/documents/download?NIC=${widget.nic}&documentType=SampleDoc'
    ]);
  }
}

class Contacts extends StatefulWidget {
  int nic;
  Contacts(this.nic);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List res = [];
  bool isLoaded = false;

  Future<List> getContacts() async {
    String url = "${Urls.apiUrl}/api/JsUser/getContacts?nic=${widget.nic}";
    final response = await http.get(Uri.parse(url));
    var resJson = json.decode(response.body);
    if (response.statusCode == 200) {
      var a = resJson as List;
      res = a.toList();
      print(res);
      return res;
      //setState(() => isLoaded = true);
    } else {
      print(response.reasonPhrase);
      return res;
    }
  }

  @override
  void initState() {
    //getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: getContacts(),
        builder: (context, snapshot) {

          if(snapshot.hasData){
            List? contacts = snapshot.data;

            return ListView(
              children: [
                ListTile(
                  title: Text(
                    "Primary Contact",
                    style: TextStyle(
                      //fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    contacts![0]['Personal'],
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
            );
          }
          return Center(child: CircularProgressIndicator());

        }
    );
  }
}
