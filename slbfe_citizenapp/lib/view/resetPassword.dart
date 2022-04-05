import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/utilities//global.dart' as global;

import '../api/apiservice.dart';

class resetPassword extends StatefulWidget {
  const resetPassword({Key? key}) : super(key: key);

  @override
  _resetPasswordState createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  late int nic;
  bool loading = false;
  var contact;
  TextEditingController mobileController = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(global.nic);
    nic = global.nic;
    CallApi();
  }

  Future<void> CallApi() async {
    contact = await APIService.getContacts(nic);
    updateUi(contact);
  }

  void updateUi(dynamic contact) {
    setState(() {
      mobileController.text = contact[0]["Personal"];
      loading = true;
    });
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: mobileController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter phone no';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 200,
                    child: FlatButton(
                      color: Colors.deepPurple[200],
                      textColor: Colors.black, // foreground
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                        } else
                          return null;
                      },
                      child: Text('Send OTP'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Type OTP',
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'New Password',
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: 200,
                    child: FlatButton(
                      color: Colors.deepPurple[200],
                      textColor: Colors.black, // foreground
                      onPressed: () {},
                      child: Text('Send OTP'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
