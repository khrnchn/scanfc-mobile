import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter/material.dart';

class H1 extends StatelessWidget {
  final String title;

  H1({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: kPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 30,
        fontFamily: 'Poppins',
      ),
    );
  }
}
