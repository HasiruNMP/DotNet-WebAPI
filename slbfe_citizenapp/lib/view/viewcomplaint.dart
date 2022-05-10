import 'package:flutter/material.dart';

class ViewComplaint extends StatefulWidget {
  String complaintID;
  String complaint;
  String feedback;
  String date;

  ViewComplaint(
      {required this.complaintID,
      required this.complaint,
      required this.feedback,
      required this.date});

  @override
  State<ViewComplaint> createState() => _ViewComplaintState();
}

class _ViewComplaintState extends State<ViewComplaint> {
  TextEditingController complaintController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    complaintController.text = widget.complaint;
    feedbackController.text = widget.feedback;

    return Scaffold(
      appBar: AppBar(
        title: Text('Complaint ID: ${widget.complaintID}'),
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    "Date: ${widget.date}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      controller: complaintController,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Your Complaint",
                      ),
                      maxLines: 50,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      enabled: false,
                      controller: feedbackController,
                      decoration: InputDecoration(
                        disabledBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(),
                        errorStyle: TextStyle(
                          color: Colors.black,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Feedback",
                      ),
                      maxLines: 50,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
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
