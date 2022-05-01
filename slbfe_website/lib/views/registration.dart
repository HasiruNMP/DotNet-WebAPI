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
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: CnameController,
                  cursorColor: Colors.green,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Company Name',
                    border: OutlineInputBorder(),
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
                  cursorColor: Colors.green,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Email',
                    border: OutlineInputBorder(),
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
                  cursorColor: Colors.green,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Name',
                    border: OutlineInputBorder(),
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
                  cursorColor: Colors.green,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter profession';
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
                  cursorColor: Colors.green,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'Password',
                    border: OutlineInputBorder(),
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
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      SaveValues();
                    } else
                      return null;
                  },
                  child: Text('Submit'),
                )
              ],
            ),
          ),
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
