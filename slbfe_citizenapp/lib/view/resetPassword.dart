import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twilio_phone_verify/twilio_phone_verify.dart';
import 'package:slbfe_citizenapp/global.dart' as global;
import '../api/apiservice.dart';

class resetPassword extends StatefulWidget {
  late int nic;

  resetPassword(this.nic);

  @override
  _resetPasswordState createState() => _resetPasswordState();
}

class _resetPasswordState extends State<resetPassword> {
  bool loading = false;
  bool showPasswordField = false;
  bool buttonloading = false;
  bool showcontainer = true;
  var contact;
  TextEditingController mobileController = TextEditingController();
  TextEditingController smsCodeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    CallApi();
    otpVerification();
  }

  Future<void> CallApi() async {
    contact = await APIService.getContacts(widget.nic);
    updateUi(contact);
  }

  void updateUi(dynamic contact) {
    setState(() {
      mobileController.text = contact[0]["Personal"];
      loading = true;
    });
  }

  final _formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  late TwilioPhoneVerify _twilioPhoneVerify;

  void otpVerification() {
    _twilioPhoneVerify = new TwilioPhoneVerify(
        accountSid:
            'AC0af284e07dd78c2b827ec036ba464315', // replace with Account SID
        authToken:
            '388f87fc7fc687da4f6cd9653ba7ab7b', // replace with Auth Token
        serviceSid:
            'VA29c290f4dea236b23784ee851f40183b' // replace with Service SID
        );
  }

  Future<void> sendCode(String phone) async {
    var twilioResponse = await _twilioPhoneVerify.sendSmsCode('+94$phone');

    if (twilioResponse.successful!) {
      print('Code sent');
      setState(() {
        buttonloading = false;
      });
    } else {
      print(twilioResponse.errorMessage);
      setState(() {
        buttonloading = false;
      });
      showAlertDialog("Something went wrong", context);
    }
  }

  Future<void> verifySmsCode(String phone, String code) async {
    var twilioResponse =
        await _twilioPhoneVerify.verifySmsCode(phone: '+94$phone', code: code);

    if (twilioResponse.successful!) {
      if (twilioResponse.verification!.status == VerificationStatus.approved) {
        print('Phone number is approved');
        showAlertDialog('Phone Number Verified Successfully!', context);
        setState(() {
          showPasswordField = true;
          showcontainer = false;
        });
      } else {
        showAlertDialog('Invalid Code!', context);
        print('Invalid code');
      }
    } else {
      showAlertDialog('Something went wrong!', context);
      print(twilioResponse.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Password'),
      ),
      body: ListView(
        children: [
          showcontainer == true
              ? Column(
                  children: [
                    loading == true
                        ? Form(
                            key: _formKey,
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(20, 50, 20, 0),
                                child: Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: mobileController,
                                      decoration: const InputDecoration(
                                        labelText: 'Phone Number',
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter phone no';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 200,
                                      child: ElevatedButton(
                                        // foreground
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              buttonloading = true;
                                            });
                                            sendCode(mobileController.text);
                                          } else
                                            return null;
                                        },
                                        child: buttonloading == false
                                            ? Text('Send OTP')
                                            : CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const Center(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                    Form(
                      key: formKey1,
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 150, right: 150),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              maxLength: 6,
                              controller: smsCodeController,
                              decoration: const InputDecoration(
                                label: Center(child: Text('Type OTP')),
                                alignLabelWithHint: true,
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter OTP';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            width: 200,
                            child: ElevatedButton(
                              // foreground
                              onPressed: () {
                                if (formKey1.currentState!.validate()) {
                                  verifySmsCode(mobileController.text,
                                      smsCodeController.text);
                                } else
                                  return null;
                              },
                              child: Text('Verify'),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
          showPasswordField == true
              ? Form(
                  key: formKey2,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: newPasswordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: 'New Password',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter new password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: 200,
                        child: ElevatedButton(
                          // foreground
                          onPressed: () async {
                            if (formKey2.currentState!.validate()) {
                              var status = await APIService.updatePassword(
                                  global.nic, newPasswordController.text);
                              print(status);
                              status == true
                                  ? showAlertDialog(
                                      'Password Updated Successfully!', context)
                                  : showAlertDialog(
                                      'Something went wrong!', context);
                            } else
                              return null;
                          },
                          child: Text('Update'),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
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
