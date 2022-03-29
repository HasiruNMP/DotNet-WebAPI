import 'package:flutter/material.dart';

class ViewComplaint extends StatefulWidget {
  const ViewComplaint({Key? key}) : super(key: key);

  @override
  State<ViewComplaint> createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('Complaints'),),
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text('Title'),
                subtitle: Text(
                    'Subtitle'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

