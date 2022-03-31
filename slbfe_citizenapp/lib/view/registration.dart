import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Registration'),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'NIC',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'DOB',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Address',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Profession',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Nationality',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Marital Status',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: null,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
