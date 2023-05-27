class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phoneNo;
  String? matrixId;
  String? accessToken;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phoneNo,
      this.matrixId,
      this.accessToken});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNo = json['phone_no'];
    matrixId = json['matrix_id'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone_no'] = this.phoneNo;
    data['matrix_id'] = this.matrixId;
    data['access_token'] = this.accessToken;
    return data;
  }
}