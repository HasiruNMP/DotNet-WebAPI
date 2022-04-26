import 'dart:convert';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:slbfe_website/views/profile.dart';
import 'package:http/http.dart' as http;

class Validate extends StatefulWidget {
  const Validate({Key? key}) : super(key: key);

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {

  int selected = 0;
  List users = [];
  bool loaded = false;

  Future fetchUsers() async {
    String url = "https://localhost:7018/api/JsUser/tobevalidated";
    final response = await http.get(Uri.parse(url));
    var resJson = json.decode(response.body);

    if (response.statusCode == 200) {
      var a = resJson as List;
      users = a.toList();
      setState(() => loaded = true);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blueGrey.shade50,
      //height: MediaQuery.of(context).size.height/1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text("Users to Validate"),
                  Expanded(
                    child: (loaded)? Container(
                      //color: Colors.deepPurple,
                      child: (users.length != 0)? Container(
                        child: ListView(
                          children: List.generate(users.length, (i) {
                            return ValidateCard(
                              nic: users[i]['NIC'],
                              email: users[i]['Email'],
                              name: users[i]['FirstName'] + ' ' + users[i]['LastName'],
                            );
                          },),
                        ),
                      ): Center(child: Text("No Users To Validate")),
                    ): Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
            ),
            VerticalDivider(),
            Expanded(
              flex: 4,
              child: (selected != 0)? Column(
                children: [
                  Expanded(child: ProfileWidget(selected),),
                ],
              ): Center(child: Text("Select A User")),
            ),
          ],
        ),
      ),
    );
  }

  Widget ValidateCard({required nic,required name,required email}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 8),
      child: Card(
        color: (nic != selected)? Colors.blueGrey.shade50 : Colors.blueGrey.shade200,
        child: InkWell(
          onTap: (){
            setState(() {
              selected = nic;
              print(nic);
            });
          },
          child: ListTile(
            title: Text("${nic} - ${name}"),
            subtitle: Text(email),
          ),
        ),
      ),
    );
  }

}

/*class ValidateCard extends StatelessWidget {

  String nic, name, email;

  ValidateCard({required this.nic,required this.name,required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 8),
      child: Card(
        color: Colors.blueGrey.shade200,
        child: InkWell(
          onTap: (){},
          child: ListTile(
            title: Text("${nic} - ${name}"),
            subtitle: Text(email),
          ),
        ),
      ),
    );
  }
}*/
