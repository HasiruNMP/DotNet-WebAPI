import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
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
      var reponseStream = response.stream;
      if (reponseStream != null) {
        print(await response.stream.bytesToString());
      } else {
        print(await response.stream.bytesToString());
        print('Invalid user email or password');
      }
    } else {
      print(response.reasonPhrase);
    }
  }
}
