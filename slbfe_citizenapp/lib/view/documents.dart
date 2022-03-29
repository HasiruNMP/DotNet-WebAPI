import 'package:flutter/material.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text('vaccine.jpg'),
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
                    Text('drivinglicence.jpg'),
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
                    Text('NAR Dilshan CV.docs'),
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
                    Text('mahinda hora'),
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
}
