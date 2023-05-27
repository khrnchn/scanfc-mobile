import 'package:image_picker/image_picker.dart';

import 'package:nfc_smart_attendance/bloc/user_bloc.dart';
import 'package:nfc_smart_attendance/helpers/validators.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';

import 'package:nfc_smart_attendance/models/registration/register_student_request_model.dart';

import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class RegisterStudentFormBloc extends FormBloc<String, String> {
  // Initialize Bloc
  final UserBloc userBloc = UserBloc();
  XFile? newProfilePhoto;
  XFile? newFormalPhoto1;
  XFile? newFormalPhoto2;
  XFile? newPassportPhoto;
  XFile? nurseAssistanceCertificate;
  XFile? resumePDF;

  // Name
  final name = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.nameChar,
    ],
  );

  // Emergency Name
  final emergencyName = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.nameChar,
    ],
  );

  // Phone Number
  final phoneNo = TextFieldBloc(
    validators: [
      // InputValidator.required,
      InputValidator.phoneNo,
    ],
  );

  // Emergency Phone Number
  final emergencyPhoneNo = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.phoneNo,
    ],
  );

  // Emergency relation
  final emergencyRelation = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  //TODO: buat validator for nursing license
  // nursing license
  final nursingLicense = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  final collegeNursingSchool = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  final workingYears = TextFieldBloc(
    validators: [
      InputValidator.required,
    ],
  );

  // Title



  // gender
  final gender = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
    items: ["Male", "Female"],
  );

  //race

  final race = SelectFieldBloc(
    validators: [FieldBlocValidators.required],
    items: ["Malay", "Chinese", "Indian", "Others"],
  );

  // Email
  final email = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.emailChar,
    ],
  );

  final matrixId = TextFieldBloc();

  // Group
  final group = TextFieldBloc();

  // Address
  final address = TextFieldBloc(
      // validators: [
      //   InputValidator.required,
      // ],
      );

  // Bank account
  final accountNo = TextFieldBloc(
      // validators: [
      //   InputValidator.required,
      // ],
      );

  // Password
  final password = TextFieldBloc(
    validators: [
      InputValidator.required,
      InputValidator.passwordChar,
    ],
  );

  // Confirm Password
  final confirmPassword = TextFieldBloc(
      // validators: [InputValidator.required],
      );

  // Check Email
  Future<String?> _checkEmail(String email) async {
    bool isExist = await userBloc.checkEmail(email);
    if (isExist) {
      return "This email is already registered";
    }
    return null;
  }

   // Check matrix id
  Future<String?> _checkMatrixId(String matrixId) async {
    bool isExist = await userBloc.checkMatrixId(matrixId);
    if (isExist) {
      return "This IC number is already registered";
    }
    return null;
  }

  // Check phone
  Future<String?> _checkPhoneNo(String phoneNo) async {
    bool isExist = await userBloc.checkPhoneNumber(phoneNo);
    if (isExist) {
      return "This phone number is already registered";
    }
    return null;
  }

  Validator<String> _confirmPassword(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String confirmPassword) {
      if (confirmPassword == passwordTextFieldBloc.value) {
        return null;
      }
      return "Your password does not match";
    };
  }

  RegisterStudentFormBloc() {
    addFieldBlocs(fieldBlocs: [
      phoneNo,
      name,
      email,
      password,
      confirmPassword,
    
    ]);



    confirmPassword
      ..addValidators([_confirmPassword(password)])
      ..subscribeToFieldBlocs([password]);

    email.addAsyncValidators(
      [_checkEmail],
    );

    phoneNo.addAsyncValidators(
      [_checkPhoneNo],
    );

    matrixId.addAsyncValidators(
      [_checkMatrixId],
    );
  }

  @override
  void onSubmitting() async {
    try {
      RegisterStudentRequestModel requestModel =
          RegisterStudentRequestModel(userModel: UserModel());
      // Account details

      requestModel.userModel!.matrixId = matrixId.value.trim();
      requestModel.userModel!.email = email.value.trim();
      requestModel.userModel!.phoneNo = phoneNo.value.trim();
      requestModel.userModel!.password = password.value.trim();
    

      // User details
  
      requestModel.userModel!.name = name.value.trim();
  
      // Call API
      DefaultResponseModel responseModel =
          await userBloc.register(requestModel);

      // Handle response
      if (responseModel.isSuccess) {
        emitSuccess(successResponse: email.value.trim());
      } else {
        emitFailure(failureResponse: responseModel.message);
      }
    } catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
