import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/theme_app_bar.dart';

class AttendanceHistoryDetailsScreen extends StatefulWidget {
  final String title;
  const AttendanceHistoryDetailsScreen({super.key, required this.title});

  @override
  State<AttendanceHistoryDetailsScreen> createState() =>
      _AttendanceHistoryDetailsScreenState();
}

class _AttendanceHistoryDetailsScreenState
    extends State<AttendanceHistoryDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.title,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Subject:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "English For Professional",
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Section:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "09P",
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Lecturer Name:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "Ts. Azma Binti Abdullah",
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "Start at:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "26 March 2023 | 4.00pm",
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Expanded(
                    flex: 2,
                    child: Text(
                      "End at:",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      "26 March 2023 | 6.00pm",
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                    ),
                  )
                ],
              ),
              Space(10),
            ],
          ),
        ),
      ),
    );
  }
}
