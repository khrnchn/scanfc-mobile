import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/bloc/user_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/public_components/theme_spinner.dart';

import '../../../helpers/general_method.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/public_components/theme_snack_bar.dart';

class VerifyEmailScreen extends StatefulWidget {
  final int activeStepper;
  final UserModel userModel;
  final ValueSetter<int> callBackSetActiveStepper;

  const VerifyEmailScreen({
    super.key,
    required this.activeStepper,
    required this.userModel,
    required this.callBackSetActiveStepper,
  });

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  int delayAnimationDuration = 200;
  final UserBloc userBloc = new UserBloc();

  // ignore: close_sinks
  late StreamController<ErrorAnimationType> errorController;
  bool isLoading = false;
  bool hasError = false;
  String loadingText = "";

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Space(30),
            DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: const Icon(
                Iconsax.security_safe,
                size: 60,
                color: kPrimaryColor,
              ),
            ),
            Space(30),
            DelayedDisplay(
                delay: Duration(milliseconds: delayAnimationDuration),
                child: const AutoSizeText(
                  "Verify Your Email",
                  style: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins"),
                  maxFontSize: 20,
                  minFontSize: 18,
                  maxLines: 1,
                )),
            Space(10),
            DelayedDisplay(
                delay: Duration(milliseconds: delayAnimationDuration),
                child: AutoSizeText.rich(
                  TextSpan(
                      text: "Enter the OTP sent to ",
                      style: TextStyle(
                          color: kGrey.shade500,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                      children: [
                        TextSpan(
                          text: secureEmail(widget.userModel.email!),
                          style: const TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        )
                      ]),
                  maxFontSize: 14,
                  minFontSize: 12,
                  maxLines: 1,
                )),
            Space(30),
            DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                obscuringCharacter: '*',
                animationType: AnimationType.scale,
                validator: (v) {
                  if (!RegExp(r'^[0-9]+$').hasMatch(v?.trim() ?? "")) {
                    return "Invalid OTP";
                  } else {
                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  borderWidth: 1,
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  inactiveColor: kDisabledText,
                  selectedFillColor: Colors.white,
                ),
                cursorColor: Colors.black,
                animationDuration: Duration(milliseconds: 300),
                textStyle: TextStyle(fontSize: 20, height: 1.6),
                backgroundColor: Colors.white,
                enableActiveFill: true,
                errorAnimationController: errorController,
                keyboardType: TextInputType.number,
                boxShadows: [],
                onCompleted: (otp) => processOTP(otp),
                onChanged: (String value) {},
              ),
            ),
            DelayedDisplay(
              delay: Duration(milliseconds: delayAnimationDuration),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "Didn't receive an OTP?",
                    style: TextStyle(
                        color: kGrey.shade500,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                    maxFontSize: 14,
                    minFontSize: 12,
                    maxLines: 1,
                  ),
                  TextButton(
                    onPressed: () {
                      processResend();
                    },
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll<Color>(kGrey.shade300)),
                    child: const AutoSizeText(
                      "RESEND",
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                      maxFontSize: 14,
                      minFontSize: 12,
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
            isLoading
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ThemeSpinner.spinner(),
                        SizedBox(height: 15),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: loadingText,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  void processOTP(String otp) async {
    // TODO: panggil API
    // Check is it number or not
    if (!RegExp(r'^[0-9]+$').hasMatch(otp)) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
    } else {
      setState(() {
        loadingText = " Verifying...";
        isLoading = true;
        hasError = false;
      });
      // Call API
      DefaultResponseModel responseModel =
          await userBloc.verifyEmail(widget.userModel.email!, otp);
      if (responseModel.isSuccess) {
        //Successfully verified
        if (mounted) {
          ThemeSnackBar.showSnackBar(
              context, "Thank you! Your email has been verified.");

          Navigator.of(context).pop();
        }
      } else {
        //Failed to verified
        setState(() {
          isLoading = false;
          hasError = true;
        });
        //set error
        errorController.add(ErrorAnimationType.shake);
      }
    }
  }

  void processResend() async {
    setState(() {
      loadingText = " Resending code to your email...";
      isLoading = true;
    });
    // Call API
    DefaultResponseModel responseModel =
        await userBloc.resendEmail(widget.userModel.email!);

    setState(() {
      isLoading = false;
    });

    if (responseModel.isSuccess) {
      //Successfully get response from API
      ThemeSnackBar.showSnackBar(
          context,
          responseModel.message == ""
              ? "Failed to fetch data from server, please try again later"
              : responseModel.message);
    }
  }
}
