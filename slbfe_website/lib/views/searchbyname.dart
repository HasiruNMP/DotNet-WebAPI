import 'dart:convert';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:slbfe_website/views/profile.dart';
import 'package:http/http.dart' as http;
import 'package:slbfe_website/global.dart';

class SearchByName extends StatefulWidget {
  const SearchByName({Key? key}) : super(key: key);

  @override
  State<SearchByName> createState() => _SearchByNameState();
}

class _SearchByNameState extends State<SearchByName> {
  int selected = 0;
  List users = [];
  bool loaded = false;

  Future fetchUsers() async {
    String url = "${Urls.apiUrl}/api/jobseekers/search?keyword=${tec.text}";
    final response = await http.get(Uri.parse(url));
    var resJson = json.decode(response.body);

    if (response.statusCode == 200) {
      print(await response.body);
      var a = resJson as List;
      users = a.toList();
      print(users);
      setState(() => loaded = true);
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {}

  final tec = TextEditingController();

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
                  Text("Search Users By Name"),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 8,
                          child: TextFormField(
                            controller: tec,
                            decoration: InputDecoration(
                              labelText: 'Type Name Here',
                              //errorText: 'Error message',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            color: Colors.indigo,
                            onPressed: () {
                              print('searching');
                              fetchUsers();
                            },
                            icon: Icon(Icons.search),
                            //child: Icon(Icons.search),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: (loaded)
                        ? Container(
                            //color: Colors.deepPurple,
                            child: (users.length != 0)
                                ? Container(
                                    child: ListView(
                                      children: List.generate(
                                        users.length,
                                        (i) {
                                          return ValidateCard(
                                            nic: users[i]['NIC'],
                                            email: users[i]['Email'],
                                            name: users[i]['FirstName'] +
                                                ' ' +
                                                users[i]['LastName'],
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : Center(child: Text("No Users By That Name")),
                          )
                        : Center(
                            child: Text("Type A Name and Press Search Icon")),
                  ),
                ],
              ),
            ),
            VerticalDivider(),
            Expanded(
              flex: 4,
              child: (selected != 0)
                  ? Column(
                      children: [
                        Expanded(
                          child: ProfileWidget(selected),
                        ),
                      ],
                    )
                  : Center(child: Text("Select A User")),
            ),
          ],
        ),
      ),
    );
  }

  Widget ValidateCard({required nic, required name, required email}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      child: Card(
        color: (nic != selected)
            ? Colors.blueGrey.shade50
            : Colors.blueGrey.shade200,
        child: InkWell(
          onTap: () {
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
