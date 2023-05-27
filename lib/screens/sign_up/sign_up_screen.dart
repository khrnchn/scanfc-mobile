import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/form_bloc/register_student_form_bloc.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/theme_app_bar.dart';
import 'package:nfc_smart_attendance/public_components/theme_snack_bar.dart';
import 'package:nfc_smart_attendance/screens/sign_up/components/body.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatefulWidget {
  int activeStepper;
  final UserModel? userModel;
  SignUpScreen({super.key, this.activeStepper = 1, this.userModel});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _controller;
  RegisterStudentFormBloc? formBloc;
  bool _isLoading = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showCancelRegistrationPopup(context);
      },
      child: Scaffold(
        backgroundColor: kWhite,
        key: scaffoldKey,
        appBar: ThemeAppBar(
          "Registration",
          onBackPressed: () async {
            //callback function when back button is pressed
            if (await showCancelRegistrationPopup(context)) {
              Navigator.of(context).pop();
            }
          },
          color: Colors.transparent,
        ),
        body: BlocProvider(
          create: (context) => RegisterStudentFormBloc(),
          child: Builder(builder: (context) {
            // if formbloc null the initialize
            formBloc ??= BlocProvider.of<RegisterStudentFormBloc>(context);

            return FormBlocListener<RegisterStudentFormBloc, String, String>(
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
                  // _isLoading = false;
                  // widget.activeStepper = 4;
                });
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

                ThemeSnackBar.showSnackBar(
                    context, state.failureResponse ?? "");
                return;
              },
              child: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Body(
                    activeStepper: widget.activeStepper,
                    callBackSetActiveStepper: (int value) {
                      // Change tab
                      setState(() {
                        widget.activeStepper = value;
                      });
                    },
                    formBloc: formBloc!,
                    callBackSetIsLoading: (bool value) {
                      // Change loading state
                      setState(() {
                        _isLoading = value;
                      });
                    },
                  ),
                ),
              ),
            );
          }),
        ),
        bottomNavigationBar: widget.activeStepper != 2
            ? Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                child: Row(
                  children: [
                    //  prefixButtonWidget(),
                    Expanded(
                      child: ButtonPrimary(
                        getButtonText(),
                        onPressed: () {
                          handleButtonOnPressed.call();
                        },
                        isLoading: _isLoading,
                        loadingText: getLoadingText(),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
  //TODO: how to validate XFILE

  handleButtonOnPressed() async {
    if (widget.activeStepper == 1) {
      // validate all inputs here
      if (await formBloc!.name.validate() &&
          await formBloc!.email.validate() &&
          await formBloc!.password.validate() &&
          await formBloc!.matrixId.validate() &&
          await formBloc!.phoneNo.validate()) {
        setState(() {
          widget.activeStepper = 2;
          print(widget.activeStepper);
        });
        //return formBloc!.submit();
      }
    }
  }

  // Widget prefixButtonWidget() {
  //   if (widget.activeStepper == 2 || widget.activeStepper == 3) {
  //     return Container(
  //       width: 60,
  //       child: ScaleTap(
  //         onPressed: () {
  //           setState(() {
  //             widget.activeStepper--;
  //           });
  //         },
  //         child: const Padding(
  //           padding: EdgeInsets.all(10.0),
  //           child: Icon(
  //             Iconsax.undo,
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return Space(0);
  // }

  String getButtonText() {
    if (widget.activeStepper == 1) {
      return "Register";
    }
    return "";
  }

  getLoadingText() {
    if (widget.activeStepper == 1) {
      return "Registering...";
    }
    return "";
  }
}
