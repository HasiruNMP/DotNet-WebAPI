import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/model/contactsmodel.dart';
import 'package:slbfe_citizenapp/utilities/global.dart' as global;

import '../api/apiservice.dart';

class Contacts extends StatefulWidget {
  int nic;
  Contacts(this.nic);

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final formKey = GlobalKey<FormState>();
  TextEditingController primaryNumberController = TextEditingController();
  TextEditingController workNumberController = TextEditingController();
  TextEditingController EmergencyNumberController = TextEditingController();
  bool enableTextbox = false;
  bool loading = false;
  var contact;
  @override
  void initState() {
    super.initState();
    CallApi();
  }

  Future<void> CallApi() async {
    contact = await APIService.getContacts(widget.nic);
    updateUi(contact);
  }

  void updateUi(dynamic contact) {
    setState(() {
      primaryNumberController.text = contact[0]["Personal"];
      workNumberController.text = contact[0]["Work"];
      EmergencyNumberController.text = contact[0]["Emmergency"];
      loading = true;
    });
  }

  Future<void> updateUserDetails() async {
    contactModel userContact = contactModel(
      js_nic: widget.nic,
      emmergency: EmergencyNumberController.text,
      personal: primaryNumberController.text,
      work: workNumberController.text,
    );
    var status = await APIService.updateContactDetails(userContact);
    print(status);
    status == true
        ? showAlertDialog('Updated Successfully!', context)
        : showAlertDialog('Something went wrong!', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contacts'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            loading == true
                ? Form(
                    key: formKey,
                    child: Column(
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
                                    updateUserDetails();
                                  } else
                                    return null;
                                },
                                child: Text('Save'),
                              ),
                      ],
                    ))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Center(
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
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
