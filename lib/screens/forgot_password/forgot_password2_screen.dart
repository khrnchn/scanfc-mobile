import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/bloc/forgot_password_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/theme_app_bar.dart';
import 'package:nfc_smart_attendance/public_components/theme_snack_bar.dart';
import 'package:nfc_smart_attendance/public_components/theme_spinner.dart';
import 'package:nfc_smart_attendance/screens/forgot_password/forgot_password3_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/public_components/h1.dart';

class ForgotPassword2Screen extends StatefulWidget {
  final String email;
  const ForgotPassword2Screen({super.key, required this.email});

  @override
  State<ForgotPassword2Screen> createState() => _ForgotPassword2ScreenState();
}

class _ForgotPassword2ScreenState extends State<ForgotPassword2Screen> {
  final ForgotPasswordBloc forgotPassword = new ForgotPasswordBloc();

  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  bool isLoading = false;
  bool hasError = false;
  String loadingText = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showCancelForgotPasswordPopup(context);
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: ThemeAppBar(
          'Reset Password',
          onBackPressed: () async {
            //callback function when back button is pressed
            if (await showCancelForgotPasswordPopup(context)) {
              Navigator.of(context).pop();
            }
          },
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Icon(
                        Iconsax.security_safe,
                        color: kTextSuccess,
                        size: 70,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  H1(title: "OTP Verification"),
                  Column(
                    children: [
                      SizedBox(height: 10),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: "OTP has been sent to\n",
                            style: TextStyle(color: kTextGray),
                            children: [
                              TextSpan(
                                  text: secureEmail(),
                                  //recognizer: onTapRecognizer,
                                  style: TextStyle(
                                      color: kTextGray,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16))
                            ]),
                      ),
                      SizedBox(height: 50),
                    ],
                  ),
                  PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    errorAnimationController: errorController,
                    length: 6,
                    obscureText: false,
                    obscuringCharacter: '*',
                    animationType: AnimationType.scale,
                    // validator: (v) {
                    //   if (!RegExp(r'^[0-9]+$').hasMatch(v.trim())) {
                    //     return translations
                    //         .text("pages.register.validator.otp_invalid");
                    //   } else {
                    //     return null;
                    //   }
                    // },
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
                    // errorAnimationController: errorController,
                    // controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      // BoxShadow(
                      //   offset: Offset(0, 0),
                      //   blurRadius: 2,
                      //   spreadRadius: 0,
                      //   color: Colors.black.withOpacity(0.1),
                      // )
                    ],
                    onCompleted: (otp) async {
                      // Check is it number or not
                      if (!RegExp(r'^[0-9]+$').hasMatch(otp)) {
                        setState(() {
                          isLoading = false;
                          hasError = true;
                        });
                      } else {
                        setState(() {
                          loadingText = "Verifying...";
                          isLoading = true;
                          hasError = false;
                        });
                        // Call API to verify OTP
                        DefaultResponseModel responseModel =
                            await forgotPassword.verifyOTP(widget.email, otp);

                        if (responseModel.isSuccess) {
                          setState(() {
                            isLoading = false;
                          });
                          //Successfully verified
                          // ThemeSnackBar.showSnackBar(context, "OTP Verified");
                          Navigator.pop(context);
                          // Navigate to forgot password 2 screen
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => ForgotPassword3Screen(
                          //         email: widget.email, otp: otp),
                          //   ),
                          // );
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
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      setState(() {
                        hasError = false;
                      });
                      //print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      if (text != null &&
                          text.trim().length == 6 &&
                          isNumeric(text)) {
                        return true;
                      }
                      return false;
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      hasError ? "Invalid OTP" : "",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "Still not receiving your OTP ?\n",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  setState(() {
                                    loadingText = "Sending...";
                                    isLoading = true;
                                  });

                                  //call api to verify email
                                  DefaultResponseModel responseModel =
                                      await forgotPassword
                                          .verifyEmail(widget.email);

                                  setState(() {
                                    isLoading = false;
                                  });

                                  if (responseModel.isSuccess) {
                                    //Successfully get response from API
                                    ThemeSnackBar.showSnackBar(
                                        context, "OTP sent!");
                                  } else {
                                    if (responseModel.message != "") {
                                      ThemeSnackBar.showSnackBar(
                                          context, "Something went wrong");
                                    }
                                  }
                                },
                              text: "Resend",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))
                        ]),
                  ),
                ],
              ),
            ),
            isLoading
                ? Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ThemeSpinner.spinner(),
                          SizedBox(height: 15),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: loadingText,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  String secureEmail() {
    // half left
    int middle = (widget.email.length / 2).ceil();
    int midHalf = (middle / 2).ceil();
    int start = midHalf;
    //half right
    int end = middle + midHalf;
    int space = end - start;

    String secure = widget.email.replaceRange(start, end, "*" * space);

    return secure;
  }
}
