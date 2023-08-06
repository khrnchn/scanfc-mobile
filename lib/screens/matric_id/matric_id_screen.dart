import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/screens/register_matric_id/register_matric_id_screen.dart';
import 'package:nfc_smart_attendance/screens/register_matric_id/register_matric_id_screen2.dart';
import 'package:nfc_smart_attendance/theme.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class MatricIDScreen extends StatefulWidget {
  final UserModel userModel;
  const MatricIDScreen({super.key, required this.userModel});

  @override
  State<MatricIDScreen> createState() => _MatricIDScreenState();
}

class _MatricIDScreenState extends State<MatricIDScreen> {
  bool isRegisterNFC = false;

  void updateNFC(bool registered) {
    setState(() {
      isRegisterNFC = registered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              isRegisterNFC
                  ? matricAfterRegister(context)
                  : Column(
                      children: [
                        matricBeforeRegister(context),
                        Space(10),
                        const Text(
                          "Please register your Matric Card",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              profileInformation(
                title: "Full Name",
                icon: Icons.person,
                sub: "Abdullah Abid Gonzalez Zikry",
              ),
              profileInformation(
                title: "Email",
                icon: Icons.email,
                sub: "abidCutie@uitm.edu.my",
              ),
              profileInformation(
                title: "Phone No",
                icon: Icons.phone,
                sub: "0123456789",
              ),
            ],
          ),
        ));
  }

  ScaleTap matricBeforeRegister(BuildContext context) {
    return ScaleTap(
      onPressed: () async {
        var result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return RegisterMatricIdScreen(
                userModel: widget.userModel,
                isRegisterNFC: isRegisterNFC,
                updateNFC: updateNFC,
              );
            },
          ),
        );
        if (result != null && result is bool) {
          setState(() {
            isRegisterNFC = result;
          });
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: MediaQuery.of(context).size.width / 2.4,
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              color: kWhite,
              border: Border.all(
                color: kPrimaryLight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                profileShadow(kPrimaryLight.withOpacity(0.15)),
              ]),
          child: const Center(
            child: Icon(
              Iconsax.add_circle,
              size: 30,
              color: kPrimaryColor,
            ),
          )),
    );
  }

  Widget matricAfterRegister(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width / 2.4,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
          color: kWhite,
          border: Border.all(
            color: kPrimaryLight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            profileShadow(kPrimaryLight.withOpacity(0.15)),
          ]),
      child: Column(
        children: [
          Text(
            "UITM JASIN\nMELAKA",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Space(10),
          Image.asset(
            "assets/images/uitm_logo.png",
            width: 120,
            height: 120,
          ),
          Space(30),
          Text(
            "MUHD IZHAM",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Space(20),
          Text(
            "2020365467",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget profileInformation(
      {required String title,
      required IconData icon,
      required String sub,
      String? relation,
      String? description}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimary100Color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            profileShadow(kPrimary100Color),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Space(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Icon(
                icon,
                size: 20,
                color: kPrimaryColor,
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      relation != null ? "$sub ($relation)" : sub,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Space(3),
                    description != null
                        ? Text(
                            description,
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 12,
                            ),
                          )
                        : Space(0),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
