import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';

class RequestExemptionScreen extends StatefulWidget {
  const RequestExemptionScreen({super.key});

  @override
  State<RequestExemptionScreen> createState() => _RequestExemptionScreenState();
}

class _RequestExemptionScreenState extends State<RequestExemptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Request Exemption",
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: kPrimaryColor,
        ),
      ),
    );
  }
}