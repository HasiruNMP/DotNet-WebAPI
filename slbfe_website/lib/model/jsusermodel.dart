class jsUserModel {
  late String email;
  late String password;
  late String name;
  late String companyName;

  jsUserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.companyName,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email,
      'password': password,
      'name': name,
      'companyName': companyName,
    };
    return map;
  }
}
