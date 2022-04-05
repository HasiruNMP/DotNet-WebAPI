import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/view/resetPassword.dart';
import 'package:slbfe_citizenapp/utilities//global.dart' as global;
import 'package:slbfe_citizenapp/view/signin.dart';

import '../api/apiservice.dart';

class accountSetting extends StatefulWidget {
  const accountSetting({Key? key}) : super(key: key);

  @override
  _accountSettingState createState() => _accountSettingState();
}

class _accountSettingState extends State<accountSetting> {
  late int nic;
  @override
  void initState() {
    super.initState();
    print(global.nic);
    nic = global.nic;
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Account Setting'),
      ),
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    // color: Colors.deepPurple[200],
                    // textColor: Colors.black, // foreground
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const resetPassword()),
                      );
                    },
                    child: Text('Reset Password'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    // color: Colors.deepPurple[200],
                    // textColor: Colors.black, // foreground
                    child: Text("Delete Account"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              scrollable: true,
                              title: Text('Sure?'),
                              content: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          labelText: 'Confirm Password',
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Please enter your current password';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                RaisedButton(
                                  child: Text("Yes"),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      print(nic);
                                      print(passwordController.text);
                                      int login =
                                          await APIService.checkPassword(
                                              nic, passwordController.text);
                                      //  print("status: $login");
                                      if (login == 0) {
                                        showAlertDialog(
                                            'Wrong password provided', context);
                                      } else if (login == -1) {
                                        showAlertDialog(
                                            'Something went Wrong', context);
                                      } else {
                                        showAlertDialogTwo(
                                            'Account Deleted Succesfully',
                                            context);
                                      }
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                RaisedButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
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

showAlertDialog(message, BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert Box"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialogTwo(message, BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamedAndRemoveUntil(context, SignIn.id, (route) => false);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert Box"),
    content: Text(message),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
