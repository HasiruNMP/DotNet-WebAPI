import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/api/apiservice.dart';
import 'package:slbfe_citizenapp/model/complaintmodel.dart';

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
    futureData =  APIService.getComplaintsOfUser(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        return GestureDetector(
                          onTap: () {

                          },
                          child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].complainId.toString()),
                                  ListTile(
                                    title: Text(data[index].complain.toString()),
                                    subtitle: Text(data[index].feedback.toString()),
                                  ),
                                ],
                              )),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                // By default show a loading spinner.
                return CircularProgressIndicator();
              },
            ),),
          ],
        ),
      ),
    );
  }
}
