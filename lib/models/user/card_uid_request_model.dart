class RegisterCardUIDRequestModel {
  
  String? cardUid;

  RegisterCardUIDRequestModel({ this.cardUid});

  RegisterCardUIDRequestModel.fromJson(Map<String, dynamic> json) {
   
    cardUid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
  
    data['uuid'] = this.cardUid;
    return data;
  }
}
