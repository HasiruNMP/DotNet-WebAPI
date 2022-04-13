
class complaintModel {
   int complainId;
   int jsNic;
   String complain;
   String feedback;

  complaintModel(
      {required this.complainId,
        required this.jsNic,
        required this.complain,
        required this.feedback});

  factory complaintModel.fromJson(Map<String, dynamic> json) {
    return complaintModel(
      complainId: json['ComplaintID'],
      jsNic: json['JS_NIC'],
      complain: json['Complain'],
      feedback: json['Feedback'],
    );
  }
}