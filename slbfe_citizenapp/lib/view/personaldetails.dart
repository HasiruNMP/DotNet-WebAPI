import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/api/apiservice.dart';
import 'package:slbfe_citizenapp/model/jsusermodel.dart';
import 'package:slbfe_citizenapp/global.dart' as global;
class PersonaInfo extends StatefulWidget {
  static String id = 'personalinfo';
  int nic;
  PersonaInfo(this.nic);

  @override
  _PersonaInfoState createState() => _PersonaInfoState();
}

class _PersonaInfoState extends State<PersonaInfo> {
  var user;

  bool enableTextbox = false;
  bool loading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nicController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController affilicationController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController nationalityController = TextEditingController();
  TextEditingController marriedStatusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    CallApi();
  }

  Future<void> CallApi() async {
    print(global.nic);
    user = await APIService.getUserDetails(widget.nic);
    updateUi(user);
  }

  void updateUi(dynamic user) {
    emailController.text = user[0]["Email"];
    nicController.text = user[0]["NIC"].toString();
    fnameController.text = user[0]["FirstName"];
    lnameController.text = user[0]["LastName"];
    dobController.text = user[0]["DOB"];
    addressController.text = user[0]["Address"];
    professionController.text = user[0]["Profession"];
    genderController.text = user[0]["Gender"];
    nationalityController.text = user[0]["Nationality"];
    marriedStatusController.text = user[0]["MaritalStatus"];
    affilicationController.text = user[0]["Affiliation"];
    setState(() {
      loading = true;
    });
  }

  Future<void> updateUserDetails() async {
    jsUserModel userModel = jsUserModel(
        nic: 1,
        email: emailController.text,
        password: '',
        firstname: fnameController.text,
        lastname: lnameController.text,
        dob: dobController.text,
        address: addressController.text,
        latitude: 0,
        longitude: 0,
        profession: professionController.text,
        affiliation: affilicationController.text,
        gender: genderController.text,
        nationality: nationalityController.text,
        maritalstatus: marriedStatusController.text,
        validity: false,
        primaryphone: '');
    var status = await APIService.updateUserDetails(userModel);
    print(status);
    status == true
        ? showAlertDialog('Updated Successfully!', context)
        : showAlertDialog('Something went wrong!', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: SafeArea(
        child: loading == true
            ? ListView(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: TextFormField(
                            enabled: false,
                            controller: emailController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: TextFormField(
                            enabled: false,
                            controller: nicController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'NIC',
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
                            controller: fnameController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'First Name',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
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
                            controller: lnameController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Last Name',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your first name';
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
                            enabled: false,
                            controller: dobController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Date of Birth',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Card(
                          child: TextFormField(
                            enabled: enableTextbox,
                            controller: addressController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Address',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your address';
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
                            controller: professionController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Profession',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter profession';
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
                            controller: affilicationController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Affilication',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter profession';
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
                            controller: genderController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Gender',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter profession';
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
                            controller: nationalityController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Nationality',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter profession';
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
                            controller: marriedStatusController,
                            cursorColor: Colors.green,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              labelText: 'Married Status',
                              border: InputBorder.none,
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
                                onPressed: () async {
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
                    ),
                  ),
                ],
              )
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
