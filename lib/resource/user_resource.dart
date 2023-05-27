import 'dart:convert';

import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/models/login/login_request_model.dart';
import 'package:nfc_smart_attendance/models/registration/register_student_request_model.dart';
import 'package:nfc_smart_attendance/models/registration/register_payment_request_model.dart';
import 'package:nfc_smart_attendance/models/user/edit_profile_request_model.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/models/user/user_response_model.dart';
import 'package:nfc_smart_attendance/services/resource.dart';
import 'package:get_it/get_it.dart';

class UserResource {
  // To get the latest user data for current user
  static Resource me() {
    return Resource(
        url: 'me',
        parse: (response) {
          return UserResponseModel(json.decode(response.body));
        });
  }

  // Save user model to GetIt to retrieve the model faster and easier when needed
  static setGetIt(UserModel user) {
    if (!GetIt.instance.isRegistered<UserModel>()) {
      GetIt.instance.registerSingleton<UserModel>(user);
    } else {
      GetIt.instance.unregister<UserModel>();
      GetIt.instance.registerSingleton<UserModel>(user);
    }
  }

  // Call Logout API to revoke the token
  static Resource logout() {
    return Resource(
        url: 'logout',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  // Call Login API
  static Resource login(LoginRequestModel loginModel) {
    return Resource(
        url: 'login',
        data: loginModel.toJson(),
        parse: (response) {
          return UserResponseModel(json.decode(response.body));
        });
  }

  // Call Register API
  static Resource register(RegisterStudentRequestModel requestModel) {
    return Resource(
        url: 'students/register',
        data: requestModel.toJson(),
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  // To check IC Number exist or not
  static Resource checkMatrixId(String matrixId) {
    return Resource(
        url: 'matrix-id/' + matrixId,
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  // Call Pay Registration Fee API
  static Resource payRegistrationFee(RegisterPaymentRequestModel requestModel) {
    return Resource(
        url: 'registration-payment',
        data: requestModel.toJson(),
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  // To check Email exist or not
  static Resource checkEmail(String email) {
    return Resource(
        url: 'check-email/' + email,
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  // To check Phone Number exist or not
  static Resource checkPhoneNumber(String phoneNo) {
    return Resource(
        url: 'check-phone-number/' + phoneNo,
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  // To edit profile details
  static Resource editProfile(EditProfileRequestModel editProfileRequestModel) {
    return Resource(
        url: 'heroes/update-profile',
        data: editProfileRequestModel.toJson(),
        parse: (response) {
          return UserResponseModel(json.decode(response.body));
        });
  }

  // To check Hero Code exist or not
  static Resource checkHeroCode(String heroCode) {
    return Resource(
        url: 'check-hero-code/' + heroCode,
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  // Call verify Email API
  static Resource verifyEmail(String email, String otp) {
    return Resource(
        url: 'email/verify',
        data: {'email': email, 'otp': otp},
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  // Call Resend email verification
  static Resource resendEmail(String email) {
    return Resource(
        url: 'email/resend',
        data: {'email': email},
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  // static Resource userUpdate(UpdateUserRequestModel requestModel) {
  //   return Resource(
  //       url: 'user/update',
  //       data: {
  //         'name': requestModel.name,
  //         'username': requestModel.username,
  //         'bio': requestModel.bio,
  //         'photo': requestModel.photoPath
  //       },
  //       parse: (response) {
  //         return UserResponseModel(json.decode(response.body));
  //       });
  // }
}
