import 'package:flutter/material.dart';

class Qualifications extends StatefulWidget {

  const Qualifications({Key? key}) : super(key: key);

  @override
  State<Qualifications> createState() => _QualificationsState();
}

class _QualificationsState extends State<Qualifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Qualifications"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(
              "OL Science",
              style: TextStyle(
                //fontSize: 16,
              ),
            ),
            subtitle: Text(
              "A",
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
              "A",
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
              "A",
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
              "Arts",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "AL Results",
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
              "A",
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
              "Bachelor",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Higher Education Field",
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
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){}, child: Text("UPDATE")),
          )
        ],
      ),
    );
  }
}


class EditQualifications extends StatefulWidget {
  const EditQualifications({Key? key}) : super(key: key);

  @override
  State<EditQualifications> createState() => _EditQualificationsState();
}

class _EditQualificationsState extends State<EditQualifications> {
  List<String> alStreamList = ["Any", "Art", "Biological Science", "Commerce", "Physical Science",];
  List<String> gradesList = ["Any", "A", "B", "C", "S",];
  List<String> alGradesList = ["Any", "3 Passes", "2 Passes", "1 Pass",];
  List<String> hEduList = ["Any", "Certificate", "Diploma", "Bachelor","Master","Doctor"];
  List<String> hEduFieldList = ["Any", "Science", "Engineering", "Computer Science",];

  String selOLScience = "Any";
  String selOLMaths = "Any";
  String selOLEnglish = "Any";
  String selAlStream = "Any";
  String selAlResults = "Any";
  String selAlEnglish = "Any";
  String selHighEdStage = "Any";
  String selHighEdField = "Any";

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
                    },
                  ),
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
          ],
        ),
      ),
    );
  }
}
