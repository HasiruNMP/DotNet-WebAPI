import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slbfe_citizenapp/global.dart';
import 'package:slbfe_citizenapp/model/contactsmodel.dart';
import 'package:slbfe_citizenapp/model/jsusermodel.dart';
import 'dart:convert';
import 'dart:async';
import 'package:slbfe_citizenapp/model/loginmodel.dart';
import 'package:slbfe_citizenapp/global.dart' as global;
import 'package:slbfe_citizenapp/view/resetPassword.dart';
import '../model/complaintmodel.dart';

class APIService {
  Future login(LoginRequestModel requestModel) async {
    print(requestModel);

    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('${Urls.apiUrl}/api/Auth/login'));
    request.body = json.encode({
      "userID": requestModel.email,
      "password": requestModel.password,
      "userType": "JS",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String res = await response.stream.bytesToString();
      print(res);
      int nic1 = int.parse(requestModel.email);
      //global.email = requestModel.email;
      Auth.apiToken = res;
      return nic1;
    }
    else {
      print(response.reasonPhrase);
      return -1;
    }
  }

  static Future getNic(String email) async {
    http.Response response = await http.get(
        Uri.parse('${Urls.apiUrl}/api/JsUser/getNic?email=${email}'));

    if (response.statusCode == 200) {
      print(response.statusCode);

      String data = response.body;
      int nic = jsonDecode(data)[0]["NIC"];
      return nic;
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
    }
  }

  static Future adduser(jsUserModel user) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('${Urls.apiUrl}/api/JsUser/registerUser'));
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
        await http.get(Uri.parse('${Urls.apiUrl}/api/JsUser?nic=$nic'));

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
      Uri.parse('${Urls.apiUrl}/api/JsUser/UpdateUserDetails'),
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
        'POST', Uri.parse('${Urls.apiUrl}/complaints/addcomplaint'));
    request.body = json.encode({
      "jsNic": complain.jsNic,
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
        Uri.parse('${Urls.apiUrl}/api/JsUser/getContacts?nic=$nic'));

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
      Uri.parse('${Urls.apiUrl}/api/JsUser/UpdateUserContacts'),
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

  static Future checkPassword(int NIC, String Password) async {
    String password = '';
    int nic;
    http.Response response = await http.get(Uri.parse(
        '${Urls.apiUrl}/api/JsUser/checkPassword?nic=$NIC&password=$Password'));

    if (response.statusCode == 200) {
      print(response.statusCode);
      String data = response.body;
      print('data:$data');
      if (data == '[]') {
        print("Password Incorrect");
        print('0');
        return 0;
      } else {
        nic = jsonDecode(data)[0]["NIC"];
        password = jsonDecode(data)[0]["Password"];
        print(nic);
        print(password);
      }

      if (nic == NIC && password == Password) {
        print('Password Matched!');
        print('Nic: $nic');
        //return 1;
        var result = deleteAccount(NIC, Password);
        return result;
      }
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print('Something went wrong');
      print('-1');
      return -1;
    }
  }

  static Future deleteAccount(int nic, String password) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            '${Urls.apiUrl}/api/JsUser?nic=$nic&password=$password'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('deleted');
      return 1;
    } else {
      print(response.reasonPhrase);
      return -1;
    }
  }

  static Future updatePassword(String userID, String password) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
      'PUT',
      Uri.parse(
          '${Urls.apiUrl}/api/JsUser/updatePassword?userId=$userID&password=$password'),
    );
    request.body = json.encode({
      "UserID": userID,
      "Password": password,
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

  static Future<List<complaintModel>> getComplaintsOfUser(int nic) async {
    final response = await http.get(Uri.parse(
        '${Urls.apiUrl}/complaints/getcomplaintlistapp?NIC=$nic'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => new complaintModel.fromJson(data))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<void> updateLocation(
    int nic,
    double lat,
    double lng,
  ) async {
    var request = http.Request(
        'PUT',
        Uri.parse(
            '${Urls.apiUrl}/api/JsUser/updatelocation?NIC=2000&lat=$lat&lng=$lng'));
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
