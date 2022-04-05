import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  //late TabController _controller;

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
                        unselectedLabelStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                            ListView(
                              children: [
                                ComplaintCard(),
                              ],
                            ),
                            ListView(
                              children: [
                                ComplaintCard(),
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
            VerticalDivider(),
            Expanded(
              flex: 5,
              child: Container(
                //color: Colors.green,
                child: Column(
                  children: [
                    ListTile(
                      title: Text("NIC"),
                      subtitle: Text("date"),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          enabled: false,
                          minLines: 20,
                          maxLines: 20,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Complaint',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          minLines: 20,
                          maxLines: 20,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Response',
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: Container(),),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("SEND"),
                              ),
                            ),
                          ),
                        ),
                        Expanded(child: Container(),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ComplaintCard extends StatelessWidget {
  const ComplaintCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1,horizontal: 8),
      child: Card(
        color: Colors.teal.shade100,
        child: InkWell(
          onTap: (){},
          child: ListTile(
            title: Text("NIC, Date Time"),
            subtitle: Text("preview"),
          ),
        ),
      ),
    );
  }
}
