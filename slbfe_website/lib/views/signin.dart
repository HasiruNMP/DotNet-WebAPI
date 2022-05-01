import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:slbfe_website/views/registration.dart';

import '../api/apiservice.dart';
import '../model/loginmodel.dart';
import 'home_screen.dart';
// import 'package:slbfe_citizenapp/api/apiservice.dart';
// import 'package:slbfe_citizenapp/model/loginmodel.dart';
// import 'package:slbfe_citizenapp/view/registration.dart';
// import 'package:slbfe_citizenapp/utilities//global.dart' as global;
// import 'bottomnavigation.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPassworController = TextEditingController();
  LoginRequestModel requestModel = LoginRequestModel(email: '', password: '');
  bool loading = false;
  String _selectedUserType = 'Buro Officer';
  String loginTitle = 'Buro Officer Login';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Sign In'),
          ),
        ),
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Text(
                  loginTitle,
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: ListTile(
                          leading: Radio<String>(
                            value: 'Buro Officer',
                            groupValue: _selectedUserType,
                            onChanged: (value) {
                              setState(() {
                                _selectedUserType = value!;
                                loginTitle = '$value Login';
                              });
                            },
                          ),
                          title: Text(
                            'Buro Officer',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListTile(
                          leading: Radio<String>(
                            value: 'Company',
                            groupValue: _selectedUserType,
                            onChanged: (value) {
                              setState(() {
                                _selectedUserType = value!;
                                loginTitle = '$value Login';
                              });
                            },
                          ),
                          title: Text(
                            'Company',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _userEmailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _userPassworController,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Please enter a long password';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      requestModel.email = _userEmailController.text;
                      requestModel.password = _userPassworController.text;
                      //  print(requestModel.toJson());
                      if (_selectedUserType == 'Buro Officer') {
                        int login = await APIService().boLogin(requestModel);
                        //  print("status: $login");
                        if (login == 0) {
                          showAlertDialog(
                              'Wrong password or email provided', context);
                        } else if (login == -1) {
                          showAlertDialog('Something went Wrong', context);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen('BO'),
                            ),
                          );
                        }
                      } else {
                        int login = await APIService().fcLogin(requestModel);
                        //  print("status: $login");
                        if (login == 0) {
                          showAlertDialog(
                              'Wrong password or email provided', context);
                        } else if (login == -1) {
                          showAlertDialog('Something went Wrong', context);
                        } else {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen('FC'),
                            ),
                          );
                        }
                      }
                    } else {
                      return null;
                    }
                  },
                  child: loading == false
                      ? Text('Sign In')
                      : const CircularProgressIndicator(
                          backgroundColor: Colors.black38,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\t have an account'),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Registration(),
                          ),
                        );
                      },
                      child: Text('Sign up'),
                    ),
                  ],
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
