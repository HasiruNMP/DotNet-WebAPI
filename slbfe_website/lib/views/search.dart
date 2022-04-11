import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search>{

  List<String> alStreamList = ["Any", "Art", "Biological Science", "Commerce", "Physical Science",];
  List<String> gradesList = ["Any", "A", "B", "C", "S",];
  List<String> alGradesList = ["Any", "3 Passes", "2 Passes", "1 Pass",];
  List<String> hEduList = ["Any", "Certificate", "Diploma", "Baccalaureat","Masterate","Doctorate"];
  List<String> hEduFieldList = ["Any", "Science", "Engineering", "Computer Science",];

  String _selectedStream = "Any";

  var jobSeekers = [];
  bool searched = false;

  Future fetchUsers() async {
    final response = await http.get(Uri.parse('https://localhost:7018/searchbyqualifications?hEdu=Bachelor&filterOn=true'));
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
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                Text("Ordinary Level"),
                Text("Science"),
                Wrap(
                  children: List<Widget>.generate(gradesList.length, (int idx) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FilterChip(
                          label: Text(gradesList[idx]),
                          selected: _selectedStream == gradesList[idx],
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedStream = gradesList[idx];
                            });
                          }),
                    );
                  },
                  ).toList(),
                ),
                Text("Mathematics"),
                Wrap(
                  children: List<Widget>.generate(gradesList.length, (int idx) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FilterChip(
                          label: Text(gradesList[idx]),
                          selected: _selectedStream == gradesList[idx],
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedStream = gradesList[idx];
                            });
                          }),
                    );
                  },
                  ).toList(),
                ),
                Text("English"),
                Wrap(
                  children: List<Widget>.generate(gradesList.length, (int idx) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FilterChip(
                          label: Text(gradesList[idx]),
                          selected: _selectedStream == gradesList[idx],
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedStream = gradesList[idx];
                            });
                          }),
                    );
                  },
                  ).toList(),
                ),
                Text("Advanced Level"),
                Text("Sream"),
                Wrap(
                  children: List<Widget>.generate(alStreamList.length, (int idx) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: FilterChip(
                            label: Text(alStreamList[idx]),
                            selected: _selectedStream == alStreamList[idx],
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedStream = alStreamList[idx];
                              });
                            }),
                      );
                    },
                  ).toList(),
                ),
                Text("Main Subject Results"),
                Wrap(
                  children: List<Widget>.generate(alGradesList.length, (int idx) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FilterChip(
                          label: Text(alGradesList[idx]),
                          selected: _selectedStream == alGradesList[idx],
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedStream = alGradesList[idx];
                            });
                          }),
                    );
                  },
                  ).toList(),
                ),
                Text("English Result"),
                Wrap(
                  children: List<Widget>.generate(gradesList.length, (int idx) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FilterChip(
                          label: Text(gradesList[idx]),
                          selected: _selectedStream == gradesList[idx],
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedStream = gradesList[idx];
                            });
                          }),
                    );
                  },
                  ).toList(),
                ),
                Text("Higher Education"),
                Wrap(
                  children: List<Widget>.generate(hEduList.length, (int idx) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FilterChip(
                          label: Text(hEduList[idx]),
                          selected: _selectedStream == hEduList[idx],
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedStream = hEduList[idx];
                            });
                          }),
                    );
                  },
                  ).toList(),
                ),
                Text("Field"),
                Wrap(
                  children: List<Widget>.generate(hEduFieldList.length, (int idx) {
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: FilterChip(
                          label: Text(hEduFieldList[idx]),
                          selected: _selectedStream == hEduFieldList[idx],
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedStream = hEduFieldList[idx];
                            });
                          }),
                    );
                  },
                  ).toList(),
                ),
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
          Expanded(
            flex: 3,
            child: (searched)?
            ListView(
                children: List.generate(jobSeekers.length, (index) => JobSeekerCard())
            ):
            Center(child: Text("Press Search"),)
          ),
        ],
      ),
    );
  }
}

class JobSeekerCard extends StatelessWidget {
  const JobSeekerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
      child: Card(
        color: Colors.teal.shade100,
        child: InkWell(
          onTap: () {},
          child: Container(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.teal,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name, Age, Gender, Profession,"),
                    Text("Email: hasirunmp@gmail.com, Phone: 0712345678"),
                  ],
                ),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(onPressed: (){}, child: Text("Email"),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(onPressed: (){}, child: Text("View CV"),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
