
class complaintModel {
   int complainId;
   int jsNic;
   String complain;
   String feedback;
   String addedDate;

  complaintModel(
      {required this.complainId,
        required this.jsNic,
        required this.complain,
        required this.feedback,
        required this.addedDate,
      });

  factory complaintModel.fromJson(Map<String, dynamic> json) {
    return complaintModel(
      complainId: json['ComplaintID'],
      jsNic: json['JS_NIC'],
      complain: json['Complain'],
      feedback: json['Feedback'],
      addedDate: json['AddedDate'],
    );
  }
}