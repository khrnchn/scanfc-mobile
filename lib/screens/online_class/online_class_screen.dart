import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';

class OnlineClassScreen extends StatefulWidget {
  final String classMode;
  const OnlineClassScreen({super.key, required this.classMode});

  @override
  State<OnlineClassScreen> createState() => _OnlineClassScreenState();
}

class _OnlineClassScreenState extends State<OnlineClassScreen> {
  int delayAnimationDuration = 200;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.classMode,
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
