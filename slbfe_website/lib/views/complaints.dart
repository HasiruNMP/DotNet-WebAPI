import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slbfe_website/global.dart';

class Data {
  final int complainId;
  final int jsNic;
  final String complain;
  final String feedback;

  Data(
      {required this.complainId,
      required this.jsNic,
      required this.complain,
      required this.feedback});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      complainId: json['ComplaintID'],
      jsNic: json['JS_NIC'],
      complain: json['Complain'],
      feedback: json['Feedback'],
    );
  }
}

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  Future<List<Data>> fetchData() async {
    final response = await http.get(
        Uri.parse('${Urls.apiUrl}/complaints/getnewcomplaintlist'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => new Data.fromJson(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future<List<Data>> fetchOldData() async {
    final response = await http.get(
        Uri.parse('${Urls.apiUrl}/complaints/getoldcomplaintlist'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((olddata) => new Data.fromJson(olddata)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  Future updateFeedback(int complaintId, String feedback) async {
    final response = await http.put(
        Uri.parse(
            '${Urls.apiUrl}/complaints/sendfeedback?complaintId=$complaintId&feedback=$feedback'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      //return Data.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to update feedback.');
    }
  }
  //late TabController _controller;

  late Future<List<Data>> futureData;
  late Future<List<Data>> futureOldData;

  bool tab = false;

  TextEditingController complainController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  int complainId = 0;
  int nic = 0;

  setValues(complain, feedback, complainId, nic) {
    setState(() {
      complainController.text = complain;
      feedbackController.text = feedback;
      this.complainId = complainId;
      this.nic = nic;
    });
  }

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
    futureOldData = fetchOldData();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            //color: Colors.blueGrey.shade50,
            //height: MediaQuery.of(context).size.height/1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      //color: Colors.deepPurple,
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: <Widget>[
                            ButtonsTabBar(
                              backgroundColor: Colors.indigo,
                              unselectedBackgroundColor: Colors.grey[300],
                              unselectedLabelStyle:
                                  TextStyle(color: Colors.black),
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              tabs: [
                                Tab(
                                  //icon: Icon(Icons.directions_car),
                                  text: "   New Complaints   ",
                                ),
                                Tab(
                                  //icon: Icon(Icons.directions_transit),
                                  text: "   Complaint History   ",
                                ),
                              ],
                            ),
                            Divider(),
                            Expanded(
                              child: TabBarView(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FutureBuilder<List<Data>>(
                                          future: futureData,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<Data>? data = snapshot.data;
                                              return ListView.builder(
                                                  itemCount: data!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setValues(
                                                          data[index].complain,
                                                          data[index].feedback,
                                                          data[index]
                                                              .complainId,
                                                          data[index].jsNic,
                                                        );
                                                      },
                                                      child: Card(
                                                        color: Colors.blueGrey.shade50,
                                                          child: ListTile(
                                                        title: Text("ID: ${data[index].complainId.toString()} | NIC: ${data[index].jsNic.toString()}"),
                                                        subtitle: Text(data[index].complain,overflow: TextOverflow.ellipsis,),
                                                      )),
                                                    );
                                                  });
                                            } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
                                            }
                                            // By default show a loading spinner.
                                            return Center(child: CircularProgressIndicator());
                                          },
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          //color: Colors.green,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(nic.toString()),
                                                subtitle: Text("date"),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller:
                                                        complainController,
                                                    enabled: false,
                                                    minLines: 20,
                                                    maxLines: 20,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Complaint',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller:
                                                        feedbackController,
                                                    minLines: 20,
                                                    maxLines: 20,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Response',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(),
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          updateFeedback(
                                                            complainId,
                                                            feedbackController
                                                                .text,
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text("SUBMIT"),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: FutureBuilder<List<Data>>(
                                          future: futureOldData,
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<Data>? olddata =
                                                  snapshot.data;
                                              return ListView.builder(
                                                  itemCount: olddata!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setValues(
                                                          olddata[index]
                                                              .complain,
                                                          olddata[index]
                                                              .feedback,
                                                          olddata[index]
                                                              .complainId,
                                                          olddata[index].jsNic,
                                                        );
                                                      },
                                                      child: Card(
                                                          child: ListTile(
                                                        title: Text(
                                                            olddata[index]
                                                                .complainId
                                                                .toString()),
                                                        subtitle: Text(
                                                            olddata[index]
                                                                .jsNic
                                                                .toString()),
                                                      )),
                                                    );
                                                  });
                                            } else if (snapshot.hasError) {
                                              return Text("${snapshot.error}");
                                            }
                                            // By default show a loading spinner.
                                            return Center(child: CircularProgressIndicator());
                                          },
                                        ),
                                      ),
                                      VerticalDivider(),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          //color: Colors.green,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                title: Text(nic.toString()),
                                                subtitle: Text("date"),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    controller:
                                                        complainController,
                                                    enabled: false,
                                                    minLines: 20,
                                                    maxLines: 20,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Complaint',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextField(
                                                    enabled: false,
                                                    controller:
                                                        feedbackController,
                                                    minLines: 20,
                                                    maxLines: 20,
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: 'Response',
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
