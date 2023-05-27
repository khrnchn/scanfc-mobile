import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/bloc/forgot_password_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/h1.dart';
import 'package:nfc_smart_attendance/public_components/input_decoration.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/public_components/theme_app_bar.dart';
import 'package:nfc_smart_attendance/public_components/theme_snack_bar.dart';
import 'package:nfc_smart_attendance/screens/forgot_password/forgot_password2_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  bool isEmailRegistered = true;
  TextEditingController emailEditingController = new TextEditingController();
  final ForgotPasswordBloc forgotPassword = ForgotPasswordBloc();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showCancelForgotPasswordPopup(context);
      },
      child: Scaffold(
        backgroundColor: kWhite,
        key: scaffoldKey,
        appBar: ThemeAppBar(
          "Reset Password",
          onBackPressed: () async {
            //callback function when back button is pressed
            if (await showCancelForgotPasswordPopup(context)) {
              Navigator.of(context).pop();
            }
          },
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            height: double.infinity,
            padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(),
                    child: Center(
                      child: Icon(
                        Iconsax.security_safe,
                        size: 70,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  Space(20),
                  H1(title: "Forgot Password?"),
                  Space(20),
                  Text(
                    "Don't worry, we will send you OTP PIN to your registered email address to reset your password.",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailEditingController,
                          cursorColor: kPrimaryColor,
                          validator: (email) {
                            if (email!.trim().length < 4 ||
                                email.trim().length > 40 ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(email.trim())) {
                              return "Invalid Email";
                            }

                            if (email.isEmpty) {
                              return "Please enter registered email";
                            }
                            return null;
                          },
                          textCapitalization: TextCapitalization.none,
                          inputFormatters: [
                            LowerCaseTextFormatter(),
                          ],
                          decoration: textFieldInputDecoration(
                            "Email",
                            hintText: "ex: example@aufmbz.com",
                            prefixIcon: const Icon(
                              Iconsax.sms,
                              color: kPrimaryColor,
                            ),
                          ),
                        ),
                        SizedBox(height: 30),

                        ButtonPrimary("SendCode", onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword2Screen(
                                  email: emailEditingController.text),
                            ),
                          );
                        })
                        // ButtonPrimary(
                        //   "Send Code",
                        //   loadingText: "Checking email...",
                        //   isLoading: isLoading,
                        //   onPressed: () async {
                        //     setState(() {
                        //       isEmailRegistered = true;
                        //       isLoading = true;
                        //     });
                        //     //call api to verify email either exist or not
                        //     DefaultResponseModel responseModel =
                        //         await forgotPassword
                        //             .verifyEmail(emailEditingController.text);

                        //     setState(() {
                        //       isLoading = false;
                        //     });

                        //     if (responseModel.isSuccess) {
                        //       Navigator.pop(context);
                        //       // Navigate to forgot password 2 screen
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => ForgotPassword2Screen(
                        //               email: emailEditingController.text),
                        //         ),
                        //       );
                        //     } else {
                        //       ThemeSnackBar.showSnackBar(
                        //           context, responseModel.message);

                        //       setState(() {
                        //         isEmailRegistered = false;
                        //       });
                        //     }
                        //   },
                        // ),
                        // Space(30),
                        // Text(
                        //   !isEmailRegistered ? "Email is not yet registered!" : "",
                        //   style: TextStyle(
                        //     fontSize: 12,
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
