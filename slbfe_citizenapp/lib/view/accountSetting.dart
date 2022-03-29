import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class accountSetting extends StatefulWidget {
  const accountSetting({Key? key}) : super(key: key);

  @override
  _accountSettingState createState() => _accountSettingState();
}

class _accountSettingState extends State<accountSetting> {
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
                    onPressed: () {},
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
                                  child: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              actions: [
                                RaisedButton(
                                  child: Text("Yes"),
                                  onPressed: () {
                                    // your code
                                  },
                                ),
                                RaisedButton(
                                  child: Text("No"),
                                  onPressed: () {
                                    // your code
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
