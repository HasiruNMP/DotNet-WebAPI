import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/api/apiservice.dart';
import 'package:slbfe_citizenapp/model/loginmodel.dart';
import 'package:slbfe_citizenapp/view/registration.dart';
import 'package:slbfe_citizenapp/global.dart' as global;
import '../global.dart';
import 'bottomnavigation.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);
  static String id = "signin";

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPassworController = TextEditingController();
  LoginRequestModel requestModel = LoginRequestModel(email: '', password: '');
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Sign In'),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Image.network(
                '${Urls.apiUrl}/documents/logo',
                height: 300,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userEmailController,
                  decoration: const InputDecoration(
                    hintText: 'NIC',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter NIC';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userPassworController,
                  obscureText: true,
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
              Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          requestModel.email = _userEmailController.text;
                          requestModel.password = _userPassworController.text;
                          //  print(requestModel.toJson());

                          int login = await APIService().login(requestModel);
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
                                builder: (context) => BottomNavigation(login),
                              ),
                            );
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
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\t have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Registration(),
                        ),
                      );
                    },
                    child: Text('Sign Up'),
                  ),
                ],
              ),
            ],
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
