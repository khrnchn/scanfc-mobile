import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/form_bloc/register_student_form_bloc.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/screens/sign_up/components/personal_information_step.dart';
import 'package:nfc_smart_attendance/screens/sign_up/components/verify_email_screen.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Body extends StatefulWidget {
  int activeStepper;
  final ValueSetter<int> callBackSetActiveStepper;
  final UserModel? userModel;
  final RegisterStudentFormBloc formBloc;
  final ValueChanged<bool> callBackSetIsLoading;

  Body(
      {super.key,
      required this.activeStepper,
      required this.callBackSetActiveStepper,
      this.userModel,
      required this.formBloc,
      required this.callBackSetIsLoading});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int totalStepperCount = 2;
  int delayAnimationDuration = 200;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step ${widget.activeStepper} of $totalStepperCount",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        fontFamily: "Poppins"),
                  ),
                ],
              ),
              Space(10),
              StepProgressIndicator(
                totalSteps: totalStepperCount,
                size: 6.0,
                currentStep: widget.activeStepper,
                selectedColor: kPrimaryColor,
                unselectedColor: kGrey.shade300,
                roundedEdges: const Radius.circular(20),
              ),
              Space(30),
            ],
          ),
          Expanded(child: componentSelector(widget.formBloc)),
        ],
      ),
    );
  }

  Widget componentSelector(RegisterStudentFormBloc formBloc) {
    if (widget.activeStepper == 1) {
      return PersonalInformationStep(formBloc: formBloc);
    } else if (widget.activeStepper == 2) {
      print("in email screen");
      return VerifyEmailScreen(
        activeStepper: widget.activeStepper,
        userModel: widget.userModel ?? UserModel(email: formBloc.email.value),
        // to change tab
        callBackSetActiveStepper: widget.callBackSetActiveStepper,
      );
    }
    return Space(0);
  }
}
