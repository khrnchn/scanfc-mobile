import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/form_bloc/change_password_form_bloc.dart';
import 'package:nfc_smart_attendance/helpers/secure_storage_api.dart';
import 'package:nfc_smart_attendance/models/user/validate_password_response_model.dart';
import 'package:nfc_smart_attendance/providers/user_data_notifier.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/custom_dialog.dart';
import 'package:nfc_smart_attendance/public_components/input_decoration.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/theme_snack_bar.dart';
import 'package:nfc_smart_attendance/screens/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _isLoading = false;
  int delayAnimationDuration = 200;
  ChangePasswordFormBloc formBloc = ChangePasswordFormBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocProvider(
          create: (context) => ChangePasswordFormBloc(),
          child: Builder(
            builder: (context) {
              final ChangePasswordFormBloc formBloc =
                  BlocProvider.of<ChangePasswordFormBloc>(context);
              return FormBlocListener<ChangePasswordFormBloc, String,
                  ValidatePasswordErrorsModel>(
                // On submit
                onSubmitting: (context, state) {
                  // Remove focus from input field
                  FocusScope.of(context).unfocus();
                  // Set loading true
                  setState(() {
                    _isLoading = true;
                  });
                },
                onSuccess: (context, state) async {
                  // Set loading false
                  setState(() {
                    _isLoading = false;
                  });

                  CustomDialog.show(
                    context,
                    isDissmissable: false,
                    icon: Iconsax.tick_circle,
                    title: "Successfully change password",
                    btnOkText: "OK",
                    btnOkOnPress: () async {
                      // Declare notifier
                      final UserDataNotifier userDataNotifier =
                          Provider.of<UserDataNotifier>(context, listen: false);

                      await GetIt.instance.reset();
                      await SecureStorageApi.delete(key: "access_token");

                      // Navigate to Sign In Screen
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => SignInScreen()),
                          (Route<dynamic> route) => false);

                      ThemeSnackBar.showSnackBar(context, "You're logged out.");
                    },
                  );
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

                  // ThemeSnackBar.showSnackBar(context,
                  //     state.failureResponse?.message ?? "Server error");
                  return;
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Space(20),
                    DelayedDisplay(
                      delay: Duration(milliseconds: delayAnimationDuration),
                      child: TextFieldBlocBuilder(
                        suffixButton: SuffixButton.obscureText,
                        obscureTextFalseIcon: const Icon(
                          Iconsax.eye,
                          color: kGrey,
                        ),
                        obscureTextTrueIcon: const Icon(
                          Iconsax.eye_slash,
                          color: kGrey,
                        ),
                        textFieldBloc: formBloc.currentPassword,
                        keyboardType: TextInputType.name,
                        cursorColor: kPrimaryColor,
                        decoration: textFieldInputDecoration(
                          "Current Password",
                          hintText: "Enter your current password",
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
                        suffixButton: SuffixButton.obscureText,
                        obscureTextFalseIcon: const Icon(
                          Iconsax.eye,
                          color: kGrey,
                        ),
                        obscureTextTrueIcon: const Icon(
                          Iconsax.eye_slash,
                          color: kGrey,
                        ),
                        textFieldBloc: formBloc.newPassword,
                        keyboardType: TextInputType.name,
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
                    SizedBox(height: 10),
                    DelayedDisplay(
                      delay: Duration(milliseconds: delayAnimationDuration),
                      child: const Text(
                        "You'll be automatically log out after change your password",
                        style: TextStyle(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    DelayedDisplay(
                      delay: Duration(milliseconds: delayAnimationDuration),
                      child: ButtonPrimary(
                        "Update", onPressed: () => formBloc.submit(),
                        loadingText: "Updating...",
                        isLoading: _isLoading,
                        //Navigator.pop(context);
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
