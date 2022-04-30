import 'dart:convert';
import 'package:slbfe_citizenapp/global.dart' as global;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Qualifications extends StatefulWidget {

  const Qualifications({Key? key}) : super(key: key);

  @override
  State<Qualifications> createState() => _QualificationsState();
}

class _QualificationsState extends State<Qualifications> {

  List qualifications = [];
  bool isLoaded = false;

  Future<void> getQualifications() async {
    String url = "https://10.0.2.2:7018/jobseekers/qualifications/ofuser?NIC=${global.nic}";
    final response = await http.get(Uri.parse(url));
    var resJson = json.decode(response.body);
    if (response.statusCode == 200) {
      var a = resJson as List;
      qualifications = a.toList();
      print(qualifications);
      setState(() => isLoaded = true);
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  void initState() {
    getQualifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Qualifications"),
      ),
      body: (isLoaded)? ListView(
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
              qualifications[0]['HigherEducationField'],
              style: TextStyle(
                //fontSize: 16,
              ),
            ),
            subtitle: Text(
              "Computer Science",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditQualifications()),
                );
              },
              child: Text("UPDATE"),
            ),
          )
        ],
      ) : Center(child: CircularProgressIndicator(),),
    );
  }
}


class EditQualifications extends StatefulWidget {
  const EditQualifications({Key? key}) : super(key: key);

  @override
  State<EditQualifications> createState() => _EditQualificationsState();
}

class _EditQualificationsState extends State<EditQualifications> {
  List<String> alStreamList = ["Art", "Biological Science", "Commerce", "Physical Science","Technology","None"];
  List<String> gradesList = ["A", "B", "C", "S","F"];
  List<String> alGradesList = ["3 Passes", "2 Passes", "1 Pass","0 Passes"];
  List<String> hEduList = ["Certificate", "Diploma", "Bachelor","Master","Doctor","None"];
  List<String> hEduFieldList = ["Science", "Engineering", "Computer Science",];

  String selOLScience = "Any";
  String selOLMaths = "Any";
  String selOLEnglish = "Any";
  String selAlStream = "Any";
  String selAlResults = "Any";
  String selAlEnglish = "Any";
  String selHighEdStage = "Any";
  String selHighEdField = "Any";

  Future<void> updateQualifications() async {
    var request = http.Request('PUT', Uri.parse('https://10.0.2.2:7018/jobseekers/qualifications/update?nic=${global.nic}&olEnglish=$selOLEnglish&olScience=$selOLScience&olMaths=$selOLMaths&alStream=$selAlStream&alResults=$selAlResults&alEnglish=$selAlEnglish&hEdu=$selHighEdStage&hEduField=$selHighEdField'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Qualifications"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(height: 10,),
            Container(child: Text("Ordinary Level",style: TextStyle(fontWeight: FontWeight.bold),),alignment: Alignment.center,),
            //SizedBox(height: 10,),
            Text("Science"),
            Wrap(
              children: List<Widget>.generate(gradesList.length, (int idx) {
                return FilterChip(
                  label: Text(gradesList[idx]),
                  selected: selOLScience == gradesList[idx],
                  onSelected: (bool selected) {
                    setState(() {
                      selOLScience = gradesList[idx];
                    });
                  },
                );
              },
              ).toList(),
            ),
            SizedBox(height: 10,),
            Text("Mathematics"),
            Wrap(
              children: List<Widget>.generate(gradesList.length, (int idx) {
                return FilterChip(
                    label: Text(gradesList[idx]),
                    selected: selOLMaths == gradesList[idx],
                    onSelected: (bool selected) {
                      setState(() {
                        selOLMaths = gradesList[idx];
                      });
                    });
              },
              ).toList(),
            ),
            SizedBox(height: 10,),
            Text("English"),
            Wrap(
              children: List<Widget>.generate(gradesList.length, (int idx) {
                return FilterChip(
                    label: Text(gradesList[idx]),
                    selected: selOLEnglish == gradesList[idx],
                    onSelected: (bool selected) {
                      setState(() {
                        selOLEnglish = gradesList[idx];
                      });
                    });
              },
              ).toList(),
            ),
            SizedBox(height: 20,),
            Container(child: Text("Advanced Level",style: TextStyle(fontWeight: FontWeight.bold),),alignment: Alignment.center,),
            Text("Stream"),
            Wrap(
              spacing: 5,
              children: List<Widget>.generate(alStreamList.length, (int idx) {
                return FilterChip(
                    label: Text(alStreamList[idx]),
                    selected: selAlStream == alStreamList[idx],
                    onSelected: (bool selected) {
                      setState(() {
                        selAlStream = alStreamList[idx];
                      });
                    });
              },
              ).toList(),
            ),
            SizedBox(height: 10,),
            Text("Results"),
            Wrap(
              spacing: 5,
              children: List<Widget>.generate(alGradesList.length, (int idx) {
                return FilterChip(
                    label: Text(alGradesList[idx]),
                    selected: selAlResults == alGradesList[idx],
                    onSelected: (bool selected) {
                      setState(() {
                        selAlResults = alGradesList[idx];
                      });
                    });
              },
              ).toList(),
            ),
            SizedBox(height: 10,),
            Text("English Result"),
            Wrap(
              children: List<Widget>.generate(gradesList.length, (int idx) {
                return FilterChip(
                    label: Text(gradesList[idx]),
                    selected: selAlEnglish == gradesList[idx],
                    onSelected: (bool selected) {
                      setState(() {
                        selAlEnglish = gradesList[idx];
                      });
                    });
              },
              ).toList(),
            ),
            SizedBox(height: 20,),
            Container(child: Text("Higher Education",style: TextStyle(fontWeight: FontWeight.bold),),alignment: Alignment.center,),
            Text("Stage"),
            Wrap(
              spacing: 5,
              children: List<Widget>.generate(hEduList.length, (int idx) {
                return FilterChip(
                    label: Text(hEduList[idx]),
                    selected: selHighEdStage == hEduList[idx],
                    onSelected: (bool selected) {
                      setState(() {
                        selHighEdStage = hEduList[idx];
                      });
                    });
              },
              ).toList(),
            ),
            SizedBox(height: 10,),
            Text("Field"),
            Wrap(
              spacing: 5,
              children: List<Widget>.generate(hEduFieldList.length, (int idx) {
                return FilterChip(
                    label: Text(hEduFieldList[idx]),
                    selected: selHighEdField == hEduFieldList[idx],
                    onSelected: (bool selected) {
                      setState(() {
                        selHighEdField = hEduFieldList[idx];
                      });
                    });
              },
              ).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: ElevatedButton(
                onPressed: (){
                  updateQualifications();
                },
                child: Text("SAVE"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
