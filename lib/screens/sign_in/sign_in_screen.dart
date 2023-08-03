import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/form_bloc/login_form_bloc.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/helpers/http_response.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/models/user/user_response_model.dart';
import 'package:nfc_smart_attendance/providers/user_data_notifier.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/custom_dialog.dart';
import 'package:nfc_smart_attendance/public_components/input_decoration.dart';
import 'package:nfc_smart_attendance/public_components/theme_snack_bar.dart';
import 'package:nfc_smart_attendance/public_components/theme_spinner.dart';

import 'package:nfc_smart_attendance/screens/forgot_password/forgot_password_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/screens/navigation_drawer/navigation_drawer.dart';

import 'package:nfc_smart_attendance/screens/sign_up/sign_up_screen.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/sign-in-screen';
  const SignInScreen({super.key});
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kWhite,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/ic_launcher.png'),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "SMART CLASS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: kPrimaryColor,
                    ),
                  ),
                  const Text(
                    "ATTENDANCE",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: kPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: loginForm(context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginForm(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginFormBloc(),
      child: Builder(builder: (context) {
        final LoginFormBloc formBloc = BlocProvider.of<LoginFormBloc>(context);

        return FormBlocListener<LoginFormBloc, UserModel, UserResponseModel>(
          // On submit
          onSubmitting: (context, state) {
            // Remove focus from input field
            FocusScope.of(context).unfocus();
            // Set loading true
            setState(() {
              _isLoading = true;
            });
          },
          onSuccess: (context, state) {
            // Set loading false
            setState(() {
              _isLoading = false;
            });

            // Declare notifier
            final UserDataNotifier userDataNotifier =
                Provider.of<UserDataNotifier>(context, listen: false);
            // Set to the notifier
            userDataNotifier.setUserData(state.successResponse!);
            // Navigate to home page screen
            print("navigate to home page");
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (context) => NavigationDrawerScreen()),
                (Route<dynamic> route) => false);
          },
          // Validation failed
          onSubmissionFailed: (context, state) {
            // Set loading false
            setState(() {
              _isLoading = false;
            });
          },
          onFailure: (context, state) {
            // Set loading to false
            setState(() {
              _isLoading = false;
            });
            // If failed not null
            if (state.failureResponse != null) {
              if (state.failureResponse!.statusCode !=
                  HttpResponse.HTTP_UNAUTHORIZED) {
                //Set data
                UserModel userModel = new UserModel();
                userModel.email = formBloc.email.value;
                // Hide current snackbar
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                // Email is not verified yet
                if (state.failureResponse!.statusCode ==
                    HttpResponse.HTTP_FORBIDDEN) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          state.failureResponse?.message ?? "Server error"),
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: "Verify Now",
                        onPressed: () {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          navigateTo(
                              context,
                              SignUpScreen(
                                activeStepper: 2,
                                userModel: userModel,
                              ));
                        },
                      ),
                    ),
                  );

                  return;
                  // If payment required
                }
              }
            }

            ThemeSnackBar.showSnackBar(
                context, state.failureResponse?.message ?? "Server error");
            return;
          },
          child: Column(
            children: [
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.email,
                cursorColor: kPrimaryColor,
                textCapitalization: TextCapitalization.none,
                inputFormatters: [
                  LowerCaseTextFormatter(),
                ],
                decoration: textFieldInputDecoration(
                  "Email",
                  hintText: "ex: example@uitm.com",
                  prefixIcon: const Icon(
                    Iconsax.sms,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              //Password
              TextFieldBlocBuilder(
                textFieldBloc: formBloc.password,
                suffixButton: SuffixButton.obscureText,
                obscureTextTrueIcon: Icon(Iconsax.eye_slash),
                obscureTextFalseIcon: Icon(Iconsax.eye),
                cursorColor: kPrimaryColor,
                decoration: textFieldInputDecoration(
                  "Password",
                  hintText: "Enter your password",
                  prefixIcon: const Icon(
                    Iconsax.unlock,
                    color: kPrimaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ScaleTap(
                onPressed: () {
                  navigateTo(context, ForgotPasswordScreen());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Forgot Password?",
                      style: TextStyle(color: kPrimaryColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              //Button Login
              ButtonPrimary(
                "Login",
                onPressed: formBloc.submit,
                isLoading: _isLoading,
                loadingText: "Signing you in...",
              ),

              // ButtonPrimary(
              //   "Login",
              //   onPressed: () {
              //     navigateTo(context, NavigationDrawerScreen());
              //   },
              //   isLoading: _isLoading,
              //   loadingText: "Signing you in...",
              // ),

              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // Navigator.push(context, route)
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    SizedBox(width: 0),
                    GestureDetector(
                        onTap: () {
                          print("navigate to sign up screen");
                          navigateTo(context, SignUpScreen());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, right: 20, top: 20, bottom: 20),
                          child: RichText(
                            text: const TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
