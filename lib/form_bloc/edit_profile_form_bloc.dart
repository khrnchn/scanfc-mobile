import 'dart:async';

import 'package:image_picker/image_picker.dart';
import 'package:nfc_smart_attendance/bloc/user_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/validators.dart';

import 'package:nfc_smart_attendance/models/default_response_model.dart';

import 'package:nfc_smart_attendance/models/user/edit_profile_request_model.dart';

import 'package:nfc_smart_attendance/models/user/update_user_request_model.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/models/user/user_response_model.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:image_pickers/image_pickers.dart';

class EditProfileFormBloc extends FormBloc<UserModel, UserResponseModel> {
  UserBloc userBloc = new UserBloc();
  XFile? newProfilePhoto;
  XFile? newFormalPhoto1;
  XFile? newFormalPhoto2;
  XFile? newPassportPhoto;
  XFile? nurseAssistanceCertificate;
  XFile? resumePDF;

  // Name
  final newName = TextFieldBloc(
    validators: [
      InputValidator.nameChar,
    ],
  );

  // Emergency Name
  final emergencyName = TextFieldBloc(
    validators: [
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
      InputValidator.phoneNo,
    ],
  );

  // Emergency relation
  final emergencyRelation = TextFieldBloc(
    validators: [],
  );

  //TODO: buat validator for nursing license
// nursing license
  final nursingLicense = TextFieldBloc(
    validators: [],
  );

  final collegeNursingSchool = TextFieldBloc(
    validators: [],
  );

  final workingYears = TextFieldBloc(
    validators: [],
  );

 


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

  final icNo = TextFieldBloc();

  // Group
  final group = TextFieldBloc();

  // Address
  final newAddress = TextFieldBloc(
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

  EditProfileFormBloc(UserModel userModel) {
    // newName.updateInitialValue(userModel.name!);
    // newAddress.updateInitialValue(userModel.address!);
    // phoneNo.updateInitialValue(userModel.phoneNo!);
    // collegeNursingSchool.updateInitialValue(userModel.collegeNursingSchool!);
    // nursingLicense.updateInitialValue(userModel.nursingLicense!);
    // workingYears.updateInitialValue(userModel.workingYears!);
    // emergencyName.updateInitialValue(userModel.emergencyName!);
    // emergencyPhoneNo.updateInitialValue(userModel.emergencyPhoneNo!);
    // emergencyRelation.updateInitialValue(userModel.emergencyRelation!);

    addFieldBlocs(fieldBlocs: [
      newName,
   
     
      phoneNo,
     
 
   
    
    ]);

 

   

    


    // // Update Bank Items
    // bank.updateItems(listBankModel);
    // // Update the selected value
    // for (BankModel bankModel in listBankModel) {
    //   if (bankModel.id == userModel.bankModel!.id) {
    //     bank.updateInitialValue(bankModel);
    //   }
    // }
  }

  @override
  Future<void> onSubmitting() async {
    try {
      //TODO: edit EditProfileRequestModel ikut formbloc
      EditProfileRequestModel requestModel = new EditProfileRequestModel();

    
      requestModel.name = newName.value;
  
    
   
      requestModel.phoneNo = phoneNo.value;
   

      UserResponseModel responseModel =
          await userBloc.editProfile(requestModel);

      if (responseModel.isSuccess) {
        emitSuccess(successResponse: responseModel.data!);
      } else {
        emitFailure(failureResponse: responseModel.errors);
      }
    } catch (e) {
      emitFailure(failureResponse: null);
    }
  }
}
