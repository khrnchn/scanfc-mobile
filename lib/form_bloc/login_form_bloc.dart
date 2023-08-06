import 'package:nfc_smart_attendance/bloc/user_bloc.dart';
import 'package:nfc_smart_attendance/helpers/secure_storage_api.dart';

import 'package:nfc_smart_attendance/models/login/login_request_model.dart';

import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/models/user/user_response_model.dart';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

class LoginFormBloc extends FormBloc<UserModel, UserResponseModel> {
  // Initialize Bloc
  final UserBloc userBloc = UserBloc();

  // For email field
  final email = TextFieldBloc(
    initialValue: "izzham@student.uitm.com",
    validators: [
      FieldBlocValidators.required,
    ],
  );

  // For password field
  final password = TextFieldBloc(
    initialValue: "password",
    validators: [
      FieldBlocValidators.required,
    ],
  );

  // Constructor, to add the field variable to the form
  LoginFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
      ],
    );
  }

  // Handle what happen on submit
  @override
  void onSubmitting() async {
    try {
      // Call API to Login
      UserResponseModel userResponseModel = await userBloc.login(
          LoginRequestModel(email: email.value, password: password.value));

      // Handle API response
      if (userResponseModel.isSuccess &&
          userResponseModel.data!.accessToken != null) {
        emitSuccess(successResponse: userResponseModel.data!);
      } else {
        // Trigger fail event
        emitFailure(failureResponse: userResponseModel);
      }
    } catch (e) {
      // Trigger fail event
      emitFailure();
    }
  }
}
