import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  static String id = 'changepassword';
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  bool _obscureText = true;
  String _currentPassword = '';
  String _newPassword = '';
  bool status = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void dispose() {
    newPassword.dispose();
    currentPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Change Password'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30, bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: currentPassword,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.blue.withOpacity(0.6),
                      errorStyle: const TextStyle(color: Colors.red),
                      labelText: 'Current Password',
                      labelStyle: TextStyle(
                          fontSize: 15, color: Colors.white.withOpacity(0.9)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: const Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the current password';
                      } else if (value.length < 7) {
                        return 'should be at least 8 characters long';
                      }
                      return null;
                    },
                    onSaved: (val) => _currentPassword = val!,
                    obscureText: _obscureText,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: newPassword,
                    cursorColor: Colors.white,
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                    decoration: InputDecoration(
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Colors.blue.withOpacity(0.6),
                      errorStyle: const TextStyle(color: Colors.red),
                      labelText: 'Enter New Password',
                      labelStyle: TextStyle(
                          fontSize: 15, color: Colors.white.withOpacity(0.9)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide:
                            const BorderSide(width: 0, style: BorderStyle.none),
                      ),
                      suffixIcon: IconButton(
                        onPressed: _toggle,
                        icon: const Icon(
                          Icons.remove_red_eye_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a new password';
                      } else if (value.length < 7) {
                        return 'should be at least 8 characters long';
                      }
                      return null;
                    },
                    onSaved: (val) => _newPassword = val!,
                    obscureText: _obscureText,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.withOpacity(0.9),
                    ),
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        showAlertDialog(
                            context, 'Are you sure you want to change it?');
                      }
                    },
                    child: status == true
                        ? const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          )
                        : const CircularProgressIndicator(
                            backgroundColor: Colors.black38,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, message) {
    // set up the buttons
    Widget continueButton = TextButton(
      child: const Text(
        "Yes",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.red,
        ),
      ),
      onPressed: () {},
    );
    Widget cancelButton = TextButton(
      child: const Text(
        "No",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    AlertDialog alert = AlertDialog(
      // title: Text("Confirm"),
      content: Text('$message'),
      actions: [
        continueButton,
        cancelButton,
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
}
