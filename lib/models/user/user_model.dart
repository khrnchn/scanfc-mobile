class UserModel {
  int? id;
  String? name;
  String? email;
  int? facultyId;
  String? phoneNo;
  String? matrixId;
  String? uuid;
  String? accessToken;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.facultyId,
      this.phoneNo,
      this.matrixId,
      this.uuid,
      this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    facultyId = json['faculty_id'];
    phoneNo = json['phone_no'];
    matrixId = json['matrix_id'];
    uuid = json['uuid'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['faculty_id'] = this.facultyId;
    data['phone_no'] = this.phoneNo;
    data['matrix_id'] = this.matrixId;
    data['uuid'] = this.uuid;
    data['access_token'] = this.accessToken;
    return data;
  }
}
