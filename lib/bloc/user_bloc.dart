import 'package:nfc_smart_attendance/helpers/http_response.dart';
import 'package:nfc_smart_attendance/helpers/secure_storage_api.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/models/login/login_request_model.dart';
import 'package:nfc_smart_attendance/models/registration/register_student_request_model.dart';
import 'package:nfc_smart_attendance/models/registration/register_payment_request_model.dart';
import 'package:nfc_smart_attendance/models/user/card_uid_request_model.dart';
import 'package:nfc_smart_attendance/models/user/edit_profile_request_model.dart';
import 'package:nfc_smart_attendance/models/user/user_response_model.dart';
import 'package:nfc_smart_attendance/public_components/theme_snack_bar.dart';
import 'package:nfc_smart_attendance/resource/user_resource.dart';
import 'package:nfc_smart_attendance/screens/sign_in/sign_in_screen.dart';
import 'package:nfc_smart_attendance/services/web_services.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserBloc {
  Future<bool> checkEmail(String email) async {
    final DefaultResponseModel response =
        await Webservice.get(UserResource.checkEmail(email));

    //if true then exist, or else
    return response.isSuccess;
  }

  Future<bool> checkPhoneNumber(String phoneNo) async {
    final DefaultResponseModel response =
        await Webservice.get(UserResource.checkPhoneNumber(phoneNo));

    //if true then exist, or else
    return response.isSuccess;
  }

  Future<bool> checkHeroCode(String heroCode) async {
    final DefaultResponseModel response =
        await Webservice.get(UserResource.checkHeroCode(heroCode));

    //if true then exist, or else
    return response.isSuccess;
  }

  Future<bool> checkMatrixId(String matrixId) async {
    final DefaultResponseModel response =
        await Webservice.get(UserResource.checkMatrixId(matrixId));

    //if true then exist, or else
    return response.isSuccess;
  }

  // Registration user
  Future<DefaultResponseModel> register(
      RegisterStudentRequestModel requestModel) async {
    // Call the API to register
    return await Webservice.post(UserResource.register(requestModel));
  }


   // set Card UID
  Future<DefaultResponseModel> setCardUID(
      CardUIDRequestModel requestModel) async {
    // Call the API to register
    return await Webservice.post(UserResource.setCardUID(requestModel));
  }

  // payment Registration
  Future<DefaultResponseModel> payRegistrationFee(
      RegisterPaymentRequestModel requestModel) async {
    // Call the API to register
    return await Webservice.post(UserResource.payRegistrationFee(requestModel));
  }

  // Verify OTP number and marked user email as verified
  Future<DefaultResponseModel> verifyEmail(String email, String otp) async {
    // Call the API to register
    return await Webservice.post(UserResource.verifyEmail(email, otp));
  }

  // Edit Profile
  // Future<UserResponseModel> editProfile(EditProfileRequestModel editProfileRequestModel) async {
  //   // Call the API to edit profile
  //   return await Webservice.put(UserResource.editProfile(editProfileRequestModel));
  // }

  // Resent OTP number to marked email as verified
  Future<DefaultResponseModel> resendEmail(
    String email,
  ) async {
    // Call the API to register
    return await Webservice.post(UserResource.resendEmail(email));
  }

// Sign out
  Future<DefaultResponseModel> signOut(context) async {
    // Revoked User Token
    DefaultResponseModel defaultResponseModel =
        await Webservice.get(UserResource.logout());

    // If success or already unauthorized clear data in storage
    if (defaultResponseModel.isSuccess ||
        defaultResponseModel.statusCode == HttpResponse.HTTP_UNAUTHORIZED) {
      await GetIt.instance.reset();
      await SecureStorageApi.delete(key: "access_token");

      // Navigate to Sign In Screen
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (Route<dynamic> route) => false);

      ThemeSnackBar.showSnackBar(context, "You're logged out.");
    }

    return defaultResponseModel;
  }

  // Login
  Future<UserResponseModel> login(LoginRequestModel loginModel) async {
    // Call the API to login
    final UserResponseModel response =
        await Webservice.post(UserResource.login(loginModel));
    if (response.statusCode == HttpResponse.HTTP_OK) {
      if (response.data != null && response.data!.accessToken != null) {
        //save in secured storage
        await SecureStorageApi.write(
            key: "access_token", value: response.data!.accessToken!);
        //save in secured storage
        await SecureStorageApi.saveObject("user", response.data);
        //save in GetIt
        UserResource.setGetIt(response.data!);
      }
    }
    return response;
  }

// edit profile
  Future<UserResponseModel> editProfile(
      EditProfileRequestModel requestModel) async {
    // Call the API to edit profile
    try {
      final UserResponseModel response = await Webservice.post(
        UserResource.editProfile(requestModel),
      );
      if (response.statusCode == HttpResponse.HTTP_OK) {
        //save in secured storage
        await SecureStorageApi.saveObject("user", response.data);
        //save in GetIt
        UserResource.setGetIt(response.data!);
      }
      return response;
    } catch (e) {
      print(e);
    }
    return UserResponseModel(null);
  }

  // Get latest user data
  Future<UserResponseModel> me(BuildContext context) async {
    // Call the API to register
    UserResponseModel responseModel = await Webservice.get(UserResource.me());
    // Means token already invalid
    if (responseModel.statusCode == HttpResponse.HTTP_UNAUTHORIZED) {
      // Logout user
      signOut(context);
    } else if (responseModel.isSuccess) {
      //save in secured storage
      await SecureStorageApi.saveObject("user", responseModel.data);
      //save in GetIt
      UserResource.setGetIt(responseModel.data!);
    }
    return responseModel;
  }
}
