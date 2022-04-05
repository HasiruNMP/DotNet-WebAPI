class LoginRequestModel {
  String email;
  String password;
  LoginRequestModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'Email': email.trim(),
      'Password': password.trim(),
    };
    return map;
  }
}
