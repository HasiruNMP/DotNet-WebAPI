import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/model/complaintmodel.dart';
import 'package:slbfe_citizenapp/utilities/global.dart';
import '../api/apiservice.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({Key? key}) : super(key: key);

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  TextEditingController complaintController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  complaintModel complaint = complaintModel(
    complainId: 0,
    jsNic: 1,
    complain: '',
    feedback: '',
    addedDate: '',
  );

  Future<void> addDatabase() async {
    complaint.jsNic = Globals.nic;
    complaint.complain = complaintController.text;

    print(complaint.jsNic);
    print(complaint.complain);
    var saveResponse = await APIService.addComplaint(complaint);
    saveResponse == true
        ? showAlertDialog('Complaint added Successfully!', context)
        : showAlertDialog('Failed to add complaint!', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Complaint'),
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: complaintController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Type your complaint here",
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      maxLines: 50,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter the Complaint';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
              ),
/*              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      controller: feedbackController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.black,
                        ),
                        filled: false,
                        fillColor: Colors.white,
                        labelText: "Feedback",
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      maxLines: 50,
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Enter the Complaint';
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    ),
                  ),
                ),
              ),*/
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    addDatabase();
                  } else
                    return null;
                },
                child: const Text('Submit'),
              ),
              SizedBox(height: 50,),
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
