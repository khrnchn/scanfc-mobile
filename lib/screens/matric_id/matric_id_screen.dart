import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/screens/register_matric_id/register_matric_id_screen.dart';
import 'package:nfc_smart_attendance/screens/register_matric_id/register_matric_id_screen2.dart';

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
      child: Column(
        children: [
          isRegisterNFC
              ? Text(
                  "NFC Registered, design card id, dalam tu ade logo uitm, nickname, matric id ")
              : Text("NFC not registered"),
          isRegisterNFC
              ? Space(1)
              : ButtonPrimary(
                  "Register Matric ID",
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
                ),
        ],
      ),
    );
  }
}
