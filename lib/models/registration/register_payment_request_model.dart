class RegisterPaymentRequestModel {
  String? discountCode;
  String? email;

  RegisterPaymentRequestModel({this.discountCode, this.email});

  RegisterPaymentRequestModel.fromJson(Map<String, dynamic> json) {
    discountCode = json['discount_code'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount_code'] = this.discountCode;
    data['email'] = this.email;
    return data;
  }
}
