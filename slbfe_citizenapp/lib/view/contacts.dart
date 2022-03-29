import 'package:flutter/material.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final formKey = GlobalKey<FormState>();
  TextEditingController primaryNumberController = TextEditingController();
  TextEditingController workNumberController = TextEditingController();
  TextEditingController EmergencyNumberController = TextEditingController();
  bool enableTextbox = false;
  @override
  Widget build(BuildContext context) {
    primaryNumberController.text = '0766807668';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contacts'),
      ),
      body: SafeArea(
        child: Form(
            key: formKey,
            child: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: TextFormField(
                    enabled: enableTextbox,
                    controller: primaryNumberController,
                    cursorColor: Colors.green,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Primary Number',
                      border: InputBorder.none,
                      // border: InputBorder.none,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: TextFormField(
                    enabled: enableTextbox,
                    controller: workNumberController,
                    cursorColor: Colors.green,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Work Number',
                      border: InputBorder.none,
                      // border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: TextFormField(
                    enabled: enableTextbox,
                    controller: EmergencyNumberController,
                    cursorColor: Colors.green,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Emergency Number',
                      border: InputBorder.none,
                      // border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                enableTextbox == false
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            enableTextbox = true;
                          });
                          if (formKey.currentState!.validate()) {
                          } else
                            return null;
                        },
                        child: Text('Edit'),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            setState(() {
                              enableTextbox = false;
                            });
                          } else
                            return null;
                        },
                        child: Text('Save'),
                      ),
              ],
            )),
      ),
    );
  }
}
