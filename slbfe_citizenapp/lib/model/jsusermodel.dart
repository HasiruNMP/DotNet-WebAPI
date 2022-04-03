class jsUserModel {
  late int nic;
  late String email;
  late String password;
  late String firstname;
  late String lastname;
  late String dob;
  late String address;
  late double latitude;
  late double longitude;
  late String profession;
  late String affiliation;
  late String gender;
  late String nationality;
  late String maritalstatus;
  late bool validity = false;
  late String primaryphone;

  jsUserModel(
      {required this.nic,
      required this.email,
      required this.password,
      required this.firstname,
      required this.lastname,
      required this.dob,
      required this.address,
      required this.latitude,
      required this.longitude,
      required this.profession,
      required this.affiliation,
      required this.gender,
      required this.nationality,
      required this.maritalstatus,
      required this.validity,
      required this.primaryphone});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'nic': nic,
      'email': email,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
      'dob': dob,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'profession': profession,
      'affiliation': affiliation,
      'gender': gender,
      'nationality': nationality,
      'maritalstatus': maritalstatus,
      'validity': validity,
      'primaryphoneno': primaryphone,
    };
    return map;
  }
}
