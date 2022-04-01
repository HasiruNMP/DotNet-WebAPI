import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Documents extends StatefulWidget {
  const Documents({Key? key}) : super(key: key);

  @override
  _DocumentsState createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Documents'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              child: const Text(
                'Vaccine Card',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('vaccine.jpg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                            height: 20,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              onPressed: () {},
                              child: Text('Choose a file'),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('Update'))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              child: const Text(
                'Licensce',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('drivinglicensce.jpg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                            height: 20,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              onPressed: () {},
                              child: Text('Choose a file'),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Update'),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              child: const Text(
                'CV',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('NAR Dilshan.docs'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                            height: 20,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              onPressed: () {},
                              child: Text('Choose a file'),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('Update'))
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              child: const Text(
                'Passport',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              elevation: 3,
              child: Container(
                margin: EdgeInsets.only(left: 10),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('Mahinda Hora'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 30, right: 30),
                            height: 20,
                            width: MediaQuery.of(context).size.width / 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey,
                              ),
                              onPressed: () {},
                              child: Text('Choose a file'),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(onPressed: () {}, child: Text('Update'))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateLocation() async{

    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    String vPath = result.files.single.path!;
    File file = File(vPath);

    var request = http.MultipartRequest('PUT', Uri.parse('https://localhost:7018/documents/save'));
    request.files.add(await http.MultipartFile.fromPath('file', vPath));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

}
