class PasswordModel {
  int nic;
  String password;
  PasswordModel({required this.nic, required this.password});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'NIC': nic,
      'Password': password.trim(),
    };
    return map;
  }
}
