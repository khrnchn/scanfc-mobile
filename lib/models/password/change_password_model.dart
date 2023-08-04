class ChangePasswordRequestModel {
   
  String? newPassword;
  String? currentPassword;

  ChangePasswordRequestModel({  this.newPassword, this.currentPassword});

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    
    newPassword = json['password'];
    currentPassword = json['current_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     
    data['password'] = this.newPassword;
    data['current_password'] = this.currentPassword;
    return data;
  }
}
