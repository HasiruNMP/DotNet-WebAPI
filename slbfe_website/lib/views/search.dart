import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              children: [
                Text("OL"),
                Text("Science"),
                Wrap(
                  children: [

                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                  child: Card(
                    color: Colors.teal.shade100,
                    child: InkWell(
                      onTap: () {},
                      child: ListTile(
                        title: Text("Name, Age, Gender, Profession,"),
                        subtitle: Text("..."),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
