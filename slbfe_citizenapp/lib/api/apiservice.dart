import 'package:http/http.dart' as http;
<<<<<<< HEAD
import 'package:slbfe_citizenapp/model/complaintmodel.dart';
=======
import 'package:slbfe_citizenapp/model/contactsmodel.dart';
>>>>>>> bb2a1bf2af87af974226ccf94f5864ebe7dd61fc
import 'package:slbfe_citizenapp/model/jsusermodel.dart';
import 'dart:convert';
import 'dart:async';
import 'package:slbfe_citizenapp/model/loginmodel.dart';

class APIService {
  static Future login(LoginRequestModel requestModel) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://10.0.2.2:7018/api/JsUser/login?email=${requestModel.email}&password=${requestModel.password}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  static Future adduser(jsUserModel user) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://10.0.2.2:7018/api/JsUser/registerUser'));
    request.body = json.encode({
      "NIC": user.nic,
      "Email": user.email,
      "Password": user.password,
      "FirstName": user.firstname,
      "LastName": user.lastname,
      "DOB": user.dob,
      "Address": user.address,
      "Latitude": user.latitude,
      "Longitude": user.longitude,
      "Profession": user.profession,
      "Affiliation": user.affiliation,
      "Gender": user.gender,
      "Nationality": user.nationality,
      "MaritalStatus": user.maritalstatus,
      "Validity": user.validity,
      "PrimaryPhone": user.primaryphone,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future getUserDetails(String email) async {
    http.Response response = await http
        .get(Uri.parse('https://10.0.2.2:7018/api/JsUser?email=$email'));

    if (response.statusCode == 200) {
      print(response.statusCode);
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

<<<<<<< HEAD



  static Future addComplaint(complaintModel complain) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://10.0.2.2:7018/complaints/addcomplaint'));
    request.body = json.encode({
      "jsNic": complain.jsnic,
      "complain": complain.complain,
      "feedback": '',
=======
  static Future updateUserDetails(jsUserModel user) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'PUT',
      Uri.parse('https://10.0.2.2:7018/api/JsUser/UpdateUserDetails'),
    );
    request.body = json.encode({
      "Email": "",
      "Password": "",
      "PrimaryPhone": "",
      "NIC": user.nic,
      "Gender": user.gender,
      "FirstName": user.firstname,
      "LastName": user.lastname,
      "DOB": user.dob,
      "Address": user.address,
      "Profession": user.profession,
      "Affiliation": user.affiliation,
      "Nationality": user.nationality,
      "MaritalStatus": user.maritalstatus
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      return false;
    }
  }

  static Future getContacts(int nic) async {
    http.Response response = await http.get(
        Uri.parse('https://10.0.2.2:7018/api/JsUser/getContacts?nic=$nic'));

    if (response.statusCode == 200) {
      print(response.statusCode);
      String data = response.body;
      print(data);
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  static Future updateContactDetails(contactModel contact) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'PUT',
      Uri.parse('https://10.0.2.2:7018/api/JsUser/UpdateUserContacts'),
    );
    request.body = json.encode({
      "jsNic": contact.js_nic,
      "personal": contact.personal,
      "work": contact.work,
      "emmergency": contact.emmergency,
>>>>>>> bb2a1bf2af87af974226ccf94f5864ebe7dd61fc
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      return false;
    }
  }
}

