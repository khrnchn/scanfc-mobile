import '../user/user_model.dart';

class RegisterStudentRequestModel {
  UserModel? userModel;

  RegisterStudentRequestModel({this.userModel});

  RegisterStudentRequestModel.fromJson(Map<String, dynamic> json) {
    userModel = json['user_model'] != null
        ? new UserModel.fromJson(json['user_model'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userModel != null) {
      data['user_model'] = this.userModel!.toJson();
    }
    return data;
  }
}


