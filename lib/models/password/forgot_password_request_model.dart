class ForgotPasswordRequestModel {
  String? passwordConfirmation;
  String? password;
  String? email;
  String? otp;

  ForgotPasswordRequestModel(
      {this.passwordConfirmation, this.password, this.email, this.otp});

  ForgotPasswordRequestModel.fromJson(Map<String, dynamic> json) {
    passwordConfirmation = json['password_confirmation'];
    password = json['password'];
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password_confirmation'] = this.passwordConfirmation;
    data['password'] = this.password;
    data['email'] = this.email;
    data['otp'] = this.otp;
    return data;
  }
}
