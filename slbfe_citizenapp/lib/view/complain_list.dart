import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/api/apiservice.dart';
import 'package:slbfe_citizenapp/model/complaintmodel.dart';
import 'package:slbfe_citizenapp/utilities/global.dart';
import 'package:slbfe_citizenapp/view/addcomplaint.dart';
import 'package:slbfe_citizenapp/view/viewcomplaint.dart';

class ComplainList extends StatefulWidget {
  const ComplainList({Key? key}) : super(key: key);

  @override
  State<ComplainList> createState() => _ComplainListState();
}

class _ComplainListState extends State<ComplainList> {
  late Future<List<complaintModel>> futureData;
  @override
  void initState() {
    super.initState();
    futureData =  APIService.getComplaintsOfUser(Globals.nic);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddComplaint()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Your Complaints"),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              child:  FutureBuilder<List<complaintModel>>(
              future: futureData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<complaintModel>? data = snapshot.data;
                  return ListView.builder(
                      itemCount: data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ViewComplaint(
                                  complaintID: data[index].complainId.toString(),
                                  complaint: data[index].complain.toString(),
                                  feedback: data[index].feedback.toString(),
                                  date: data[index].addedDate.toString(),
                                ),),
                              );
                            },
                            child: ListTile(
                                title: Text(
                                    data[index].complain.toString(),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text("Complaint ID: "+data[index].complainId.toString()+" | "+data[index].addedDate.toString()),
                              ),
                          ),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return Center(child: CircularProgressIndicator());
              },
            ),),
          ],
        ),
      ),
    );
  }
}
