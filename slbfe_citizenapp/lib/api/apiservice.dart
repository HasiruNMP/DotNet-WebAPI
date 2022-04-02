import 'package:http/http.dart' as http;
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
}
