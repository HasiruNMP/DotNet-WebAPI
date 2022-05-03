import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:http/http.dart' as http;
import 'dart:js' as js;
import 'package:url_launcher/url_launcher.dart';

void launchURL(String _email) async {
  if (!await launch('mailto:$_email?subject=<subject>&body=<body>')) throw 'Could not email $_email';
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search>{

  List<String> alStreamList = ["Any", "Art", "Biological Science", "Commerce", "Physical Science","Technology",];
  List<String> gradesList = ["Any", "A", "B", "C", "S",];
  List<String> alGradesList = ["Any", "3 Passes", "2 Passes", "1 Pass",];
  List<String> hEduList = ["Any", "Certificate", "Diploma", "Bachelor","Master","Doctor"];
  List<String> hEduFieldList = ["Any", "Science", "Engineering", "Computer Science","Medical","Agriculture","Economics","Finance","Business",];

  String selOLScience = "Any";
  String selOLMaths = "Any";
  String selOLEnglish = "Any";
  String selAlStream = "Any";
  String selAlResults = "Any";
  String selAlEnglish = "Any";
  String selHighEdStage = "Any";
  String selHighEdField = "Any";

  var jobSeekers = [];
  bool searched = false;

  Future fetchUsers() async {
    String url = "https://localhost:7018/jobseekers/search?filterOn=true&olEnglish=$selOLEnglish&olScience=$selOLScience&olMaths=$selOLMaths&alStream=$selAlStream&alResults=$selAlResults&hEdu=$selHighEdStage&hEduField=$selHighEdField";
    //print(url);
    String urlF = url.replaceAll(RegExp(' +'), '%20');
    print(urlF);
    final response = await http.get(Uri.parse(urlF));
    var resJson = json.decode(response.body);

    if (response.statusCode == 200) {
      var a = resJson as List;
      jobSeekers = a.toList();
      setState(() => searched = true);
    }
    else {
      print(response.reasonPhrase);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    Container(child: Text("Filter",style: TextStyle(fontWeight: FontWeight.bold),),alignment: Alignment.center,),
                    Divider(),
                    SizedBox(height: 10,),
                    Container(child: Text("Ordinary Level"),alignment: Alignment.center,),
                    SizedBox(height: 10,),
                    Text("Science"),
                    Wrap(
                      children: List<Widget>.generate(gradesList.length, (int idx) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FilterChip(
                              label: Text(gradesList[idx]),
                              selected: selOLScience == gradesList[idx],
                              onSelected: (bool selected) {
                                setState(() {
                                  selOLScience = gradesList[idx];
                                });
                              }),
                        );
                      },
                      ).toList(),
                    ),
                    SizedBox(height: 10,),
                    Text("Mathematics"),
                    Wrap(
                      children: List<Widget>.generate(gradesList.length, (int idx) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FilterChip(
                              label: Text(gradesList[idx]),
                              selected: selOLMaths == gradesList[idx],
                              onSelected: (bool selected) {
                                setState(() {
                                  selOLMaths = gradesList[idx];
                                });
                              }),
                        );
                      },
                      ).toList(),
                    ),
                    SizedBox(height: 10,),
                    Text("English"),
                    Wrap(
                      children: List<Widget>.generate(gradesList.length, (int idx) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FilterChip(
                              label: Text(gradesList[idx]),
                              selected: selOLEnglish == gradesList[idx],
                              onSelected: (bool selected) {
                                setState(() {
                                  selOLEnglish = gradesList[idx];
                                });
                              }),
                        );
                      },
                      ).toList(),
                    ),
                    SizedBox(height: 20,),
                    Container(child: Text("Advanced Level"),alignment: Alignment.center,),
                    Text("Stream"),
                    Wrap(
                      children: List<Widget>.generate(alStreamList.length, (int idx) {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: FilterChip(
                                label: Text(alStreamList[idx]),
                                selected: selAlStream == alStreamList[idx],
                                onSelected: (bool selected) {
                                  setState(() {
                                    selAlStream = alStreamList[idx];
                                  });
                                }),
                          );
                        },
                      ).toList(),
                    ),
                    SizedBox(height: 10,),
                    Text("Results"),
                    Wrap(
                      children: List<Widget>.generate(alGradesList.length, (int idx) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FilterChip(
                              label: Text(alGradesList[idx]),
                              selected: selAlResults == alGradesList[idx],
                              onSelected: (bool selected) {
                                setState(() {
                                  selAlResults = alGradesList[idx];
                                });
                              }),
                        );
                      },
                      ).toList(),
                    ),
                    SizedBox(height: 10,),
                    Text("English Result"),
                    Wrap(
                      children: List<Widget>.generate(gradesList.length, (int idx) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FilterChip(
                              label: Text(gradesList[idx]),
                              selected: selAlEnglish == gradesList[idx],
                              onSelected: (bool selected) {
                                setState(() {
                                  selAlEnglish = gradesList[idx];
                                });
                              }),
                        );
                      },
                      ).toList(),
                    ),
                    SizedBox(height: 20,),
                    Container(child: Text("Higher Education"),alignment: Alignment.center,),
                    Text("Stage"),
                    Wrap(
                      children: List<Widget>.generate(hEduList.length, (int idx) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FilterChip(
                              label: Text(hEduList[idx]),
                              selected: selHighEdStage == hEduList[idx],
                              onSelected: (bool selected) {
                                setState(() {
                                  selHighEdStage = hEduList[idx];
                                });
                              }),
                        );
                      },
                      ).toList(),
                    ),
                    SizedBox(height: 10,),
                    Text("Field"),
                    Wrap(
                      children: List<Widget>.generate(hEduFieldList.length, (int idx) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FilterChip(
                              label: Text(hEduFieldList[idx]),
                              selected: selHighEdField == hEduFieldList[idx],
                              onSelected: (bool selected) {
                                setState(() {
                                  selHighEdField = hEduFieldList[idx];
                                });
                              }),
                        );
                      },
                      ).toList(),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                        child: ElevatedButton(
                          onPressed: (){
                            fetchUsers();
                          },
                          child: Text("SEARCH"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            VerticalDivider(),
            Expanded(
              flex: 3,
              child: (searched)?
              Container(
                child: (jobSeekers.length != 0)?
                ListView(
                    children: List.generate(jobSeekers.length, (index) {
                      return JobSeekerCard(
                        nic: jobSeekers[index]['NIC'].toString(),
                        name: jobSeekers[index]['FirstName']+ ' ' +jobSeekers[index]['LastName'],
                        dob: jobSeekers[index]['DOB'],
                        gender: jobSeekers[index]['Gender'],
                        profession: jobSeekers[index]['Profession'],
                        phone: jobSeekers[index]['PrimaryPhone'],
                        email: jobSeekers[index]['Email'],
                        cvUrl: jobSeekers[index]['Email'],
                      );
                    })
                ):
                Center(child: Text("No Results"),),
              ):
              Center(child: Text("Press Search"),),
            ),
          ],
        ),
      ),
    );
  }
}

class JobSeekerCard extends StatelessWidget {

  String nic, name, dob, gender, profession, email, phone, cvUrl;

  JobSeekerCard({required this.nic,required this.name,required this.dob,required this.gender,required this.profession,required this.email,required this.phone,required this.cvUrl});

  int calAge(String dob){
    DateTime d1 = DateTime.parse(dob);
    int age = ((DateTime.now().difference(d1).inDays)/365).round();
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      child: Card(
        color: Colors.indigo.shade50,
        child: InkWell(
          onTap: () {},
          child: Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.blueGrey.shade50,
                    backgroundImage: NetworkImage('https://localhost:7018/documents/profilepic?NIC=${nic}'),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name, ${calAge(dob)}, $gender, $profession,",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Email: $email, Phone: $phone"),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: (){
                      launchURL(email);
                    },
                    child: Text("Send Email"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: (){
                      js.context.callMethod('open', ['https://localhost:7018/documents/download?NIC=$nic&documentType=CV']);
                    },
                    child: Text("Download CV"),
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
