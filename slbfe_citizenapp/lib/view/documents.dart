import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:slbfe_citizenapp/global.dart';
import 'package:slbfe_citizenapp/global.dart' as global;
import 'package:url_launcher/url_launcher.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ListView(
            children: [
              DocCard(docType: "CV", icon: Icons.vaccines, lastUpdated: ""),
              DocCard(
                  docType: "OL Certificate",
                  icon: Icons.vaccines,
                  lastUpdated: ""),
              DocCard(
                  docType: "AL Certificate",
                  icon: Icons.vaccines,
                  lastUpdated: ""),
              DocCard(
                  docType: "Degree Certificate",
                  icon: Icons.vaccines,
                  lastUpdated: ""),
              DocCard(
                  docType: "Vaccination Card",
                  icon: Icons.vaccines,
                  lastUpdated: ""),
              DocCard(
                  docType: "Passport", icon: Icons.vaccines, lastUpdated: ""),
              DocCard(
                  docType: "License", icon: Icons.vaccines, lastUpdated: ""),
            ],
          ),
        ),
      ),
    );
  }
}

class DocCard extends StatelessWidget {
  String docType;
  IconData icon;
  String lastUpdated;

  DocCard(
      {required this.docType, required this.icon, required this.lastUpdated});

  @override
  Widget build(BuildContext context) {
    String docType2 = docType.replaceAll(RegExp(' +'), '');
    print(docType2);

    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(docType),
            subtitle: Text('Last Updated: 2022.02.13'),
            leading: CircleAvatar(
              child: Icon(icon),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: OutlinedButton(
                    onPressed: () {
                      _launchURL(
                          '${Urls.apiUrl}/documents/download?NIC=${global.nic}&documentType=$docType2');
                    },
                    child: Text('View'),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: OutlinedButton(
                    onPressed: () {
                      selectDocument(docType2);
                    },
                    child: Text('Update'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> selectDocument(String documentType) async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      String path = result.files.single.path!;
      updateDocument(documentType, path);
    }
  }

  Future<void> updateDocument(String documentType, String path) async {
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            '${Urls.apiUrl}/documents/upload?NIC=${global.nic}&documentType=$documentType'));
    request.files.add(await http.MultipartFile.fromPath('file', path));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> downloadDoc() async {
    var request = http.Request(
      'GET',
      Uri.parse(
          '${Urls.apiUrl}/documents/download?NIC=1&documentType=CV'),
    );
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }
}
