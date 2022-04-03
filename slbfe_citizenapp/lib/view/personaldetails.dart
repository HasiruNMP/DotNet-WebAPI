import 'package:flutter/material.dart';
import 'package:slbfe_citizenapp/api/apiservice.dart';

class PersonaInfo extends StatefulWidget {
  const PersonaInfo({Key? key}) : super(key: key);

  @override
  _PersonaInfoState createState() => _PersonaInfoState();
}

class _PersonaInfoState extends State<PersonaInfo> {
  var user;
  @override
  void initState() {
    super.initState();
    CallApi();
  }

  Future<void> CallApi() async {
    user = await APIService.getUserDetails('a@gmail.com');
    updateUi(user);
  }

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
  bool enableTextbox = false;
  final formKey = GlobalKey<FormState>();

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
          child: ListView(
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
                  enabled: false,
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
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            enableTextbox = false;
                          });
                        } else
                          return null;
                      },
                      child: Text('Save'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
