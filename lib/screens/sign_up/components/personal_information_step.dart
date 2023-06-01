import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:nfc_smart_attendance/constant.dart';

import 'package:nfc_smart_attendance/form_bloc/register_student_form_bloc.dart';

import 'package:nfc_smart_attendance/public_components/input_decoration.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:iconsax/iconsax.dart';

class PersonalInformationStep extends StatefulWidget {
  final RegisterStudentFormBloc formBloc;
  const PersonalInformationStep({Key? key, required this.formBloc})
      : super(key: key);

  @override
  State<PersonalInformationStep> createState() =>
      _PersonalInformationStepState();
}

class _PersonalInformationStepState extends State<PersonalInformationStep> {
  int delayAnimationDuration = 200;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Space(10),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: const Text(
              "Personal Information",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.name,
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: textFieldInputDecoration(
                "Name",
                hintText: "ex: Rolex Dilly",
                prefixIcon: Icon(
                  Iconsax.profile_circle,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.email,
              keyboardType: TextInputType.name,
              cursorColor: kPrimaryColor,
              decoration: textFieldInputDecoration(
                "Email",
                hintText: "ex: something@nurse.com",
                prefixIcon: const Icon(
                  Iconsax.sms,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              suffixButton: SuffixButton.obscureText,
              //jange letak obscureText: true, nnt icon mata dok tubik
              obscureTextFalseIcon: const Icon(
                Iconsax.eye,
                color: kGrey,
              ),
              obscureTextTrueIcon: const Icon(
                Iconsax.eye_slash,
                color: kGrey,
              ),
              textFieldBloc: widget.formBloc.password,
              cursorColor: kPrimaryColor,
              decoration: textFieldInputDecoration(
                "New Password",
                hintText: "Enter your new password",
                prefixIcon: const Icon(
                  Iconsax.lock,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.matrixId,
              cursorColor: kPrimaryColor,
              decoration: textFieldInputDecoration(
                "Matrix ID",
                hintText: "ex:0000000000",
                prefixIcon: const Icon(
                  Iconsax.personalcard,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          DelayedDisplay(
            delay: Duration(milliseconds: delayAnimationDuration),
            child: TextFieldBlocBuilder(
              textFieldBloc: widget.formBloc.phoneNo,
              keyboardType: TextInputType.number,
              cursorColor: kPrimaryColor,
              decoration: textFieldInputDecoration(
                "Phone Number",
                hintText: "ex:0123456789",
                prefixIcon: const Icon(
                  Iconsax.call,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ),
          Space(10),
        ],
      ),
    );
  }
}
