import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slbfe_website/model/jsusermodel.dart';
import 'package:slbfe_website/views/home_screen.dart';

import '../api/apiservice.dart';
// import 'package:intl/intl.dart';
// import 'package:slbfe_citizenapp/api/apiservice.dart';
// import 'package:slbfe_citizenapp/model/jsusermodel.dart';
// import 'package:slbfe_citizenapp/utilities//global.dart' as global;
// import 'bottomnavigation.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController CnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController rpassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  jsUserModel user =
      jsUserModel(email: '', password: '', name: '', companyName: '');

  Future<void> SaveValues() async {
    user.companyName = CnameController.text;
    user.email = emailController.text;
    user.password = rpassController.text;
    user.name = nameController.text;
    print(user.email);
    bool saveResponse = await APIService.addJsUser(user);
    saveResponse == true
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen('FC'),
            ),
          )
        : showAlertDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Row(
          children: [
            Expanded(child: Container()),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 8,
                  bottom: MediaQuery.of(context).size.height / 10,
                ),
                child: Card(
                  elevation: 5,
                  child: Form(
                    key: formKey,
                    child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: ListView(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 5.5,
                            width: double.maxFinite,
                            color: Colors.indigo,
                            child: Center(
                              child: Text(
                                'Registration',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 100.0,
                          ),
                          TextFormField(
                            controller: CnameController,
                            cursorColor: Colors.indigo,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.3),
                              labelText: 'Company Name',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your company name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: emailController,
                            cursorColor: Colors.indigo,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.3),
                              labelText: 'Email',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: nameController,
                            cursorColor: Colors.indigo,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.3),
                              labelText: 'Name',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: passController,
                            cursorColor: Colors.indigo,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.3),
                              labelText: 'Password',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: rpassController,
                            cursorColor: Colors.indigo,
                            decoration: InputDecoration(
                              errorStyle: const TextStyle(
                                color: Colors.black,
                              ),
                              filled: true,
                              fillColor: Colors.grey.withOpacity(0.3),
                              labelText: 'Re-type password',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please re-type the password';
                              } else if (passController.text != value) {
                                return 'Password not matching';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Column(
                            children: [
                              Container(
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      SaveValues();
                                    } else
                                      return null;
                                  },
                                  child: Text('Submit'),
                                ),
                                height: 40,
                                width: 100,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
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
    content: Text('Something Wrong'),
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
