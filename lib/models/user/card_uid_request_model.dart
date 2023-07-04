class CardUIDRequestModel {
  int? studentId;
  String? cardUid;

  CardUIDRequestModel({this.studentId, this.cardUid});

  CardUIDRequestModel.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    cardUid = json['card_uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['card_uid'] = this.cardUid;
    return data;
  }
}
