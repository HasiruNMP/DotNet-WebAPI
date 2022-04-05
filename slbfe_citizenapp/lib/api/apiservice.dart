import 'package:http/http.dart' as http;
import 'package:slbfe_citizenapp/model/contactsmodel.dart';
import 'package:slbfe_citizenapp/model/jsusermodel.dart';
import 'dart:convert';
import 'dart:async';
import 'package:slbfe_citizenapp/model/loginmodel.dart';
import 'package:slbfe_citizenapp/utilities/global.dart' as global;

import '../model/complaintmodel.dart';

class APIService {
  static Future login(LoginRequestModel requestModel) async {
    String email = '';
    String password = '';
    int nic;
    http.Response response = await http.get(Uri.parse(
        'https://10.0.2.2:7018/api/JsUser/login?email=${requestModel.email}&password=${requestModel.password}'));

    if (response.statusCode == 200) {
      print(response.statusCode);
      String data = response.body;
      print('data:$data');
      if (data == '[]') {
        print("Wrong password or email provided");
        print('0');
        return 0;
      } else {
        nic = jsonDecode(data)[0]["NIC"];
        email = jsonDecode(data)[0]["Email"];
        password = jsonDecode(data)[0]["Password"];
        print(email);
        print(password);
      }

      if (email == requestModel.email && password == requestModel.password) {
        // global.nic = nic;
        print('Login Successfull!');
        print('Nic: $nic');
        return nic;
      }
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print('Something went wrong');
      print('-1');
      return -1;
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

  static Future getUserDetails(int nic) async {
    http.Response response =
        await http.get(Uri.parse('https://10.0.2.2:7018/api/JsUser?nic=$nic'));

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

  static Future addComplaint(complaintModel complain) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('https://10.0.2.2:7018/complaints/addcomplaint'));
    request.body = json.encode({
      "jsNic": complain.jsnic,
      "complain": complain.complain,
      "feedback": '',
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
