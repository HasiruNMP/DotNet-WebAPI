import 'package:flutter/material.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({Key? key}) : super(key: key);

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  TextEditingController complaintController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complaint'),
      ),
      body: SafeArea(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              Center(
                child: Text('New Complaint'),
              ),
              // TextFormField(
              //   decoration: InputDecoration(
              //     labelText: "New Complaint",
              //   ),
              //   maxLines: 5,
              // )
              const SizedBox(
                height: 30,
              ),
              Container(
                // width:250,
                // height: 50,
                // margin: const EdgeInsets.all(15.0),
                // padding: const EdgeInsets.all(3.0),
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.black,width: 1),
                //   borderRadius: BorderRadius.all(
                //       Radius.circular(13.0) //                 <--- border radius here
                //   ),
                // ),
                // child: TextFormField(
                //     decoration: InputDecoration(
                //        labelText: "New Complaint",
                //       border: InputBorder.none,
                //
                //      ),
                //      maxLines: 5,
                // ),

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
                      labelText: "Enter your complaint",
                      labelStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    maxLines: 5,
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
              ElevatedButton(
                onPressed: () {},
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
