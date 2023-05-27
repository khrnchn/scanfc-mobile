class ChangePasswordRequestModel {
  String? passwordConfirmation;
  String? newPassword;
  String? currentPassword;

  ChangePasswordRequestModel({this.passwordConfirmation, this.newPassword, this.currentPassword});

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    passwordConfirmation = json['password_confirmation'];
    newPassword = json['new_password'];
    currentPassword = json['current_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password_confirmation'] = this.passwordConfirmation;
    data['new_password'] = this.newPassword;
    data['current_password'] = this.currentPassword;
    return data;
  }
}
