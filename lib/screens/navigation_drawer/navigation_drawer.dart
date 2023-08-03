import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:nfc_smart_attendance/bloc/user_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/public_components/custom_dialog.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/theme_spinner.dart';
import 'package:nfc_smart_attendance/screens/attendance_history/attendance_history_screen.dart';
import 'package:nfc_smart_attendance/screens/change_password/change_password_screen.dart';
import 'package:nfc_smart_attendance/screens/class_today/class_today_screen.dart';
import 'package:nfc_smart_attendance/screens/matric_id/matric_id_screen.dart';
import 'package:nfc_smart_attendance/screens/navigation_drawer/components/appBars.dart';

class NavigationDrawerScreen extends StatefulWidget {
  static const routeName = '/navigation';
  const NavigationDrawerScreen({super.key});

  @override
  State<NavigationDrawerScreen> createState() => _NavigationDrawerScreenState();
}

class _NavigationDrawerScreenState extends State<NavigationDrawerScreen> {
  // auto navigate to class today screen
  int _selectedIndex = 1;
  final pageController = PageController();
  UserModel _userModel = UserModel();

  @override
  void initState() {
    super.initState();
  }

  void _selectDrawerItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        //callback function when back button is pressed
        return showExitAppPopup(context);
      },
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: _builtAppBar(),
        drawer: _builtDrawer(context),
        body: _bodyScreen(),
      ),
    );
  }

  Drawer _builtDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: kWhite,
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScaleTap(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.close,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Space(10),
            ScaleTap(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  setState(() {
                    _selectedIndex == 0;
                  });
                  _selectDrawerItem(0);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 0
                      ? kPrimary100Color
                      : Colors.transparent,
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 0 ? kPrimaryColor : kWhite,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: _selectedIndex == 0 ? 13 : 15),
                    Icon(
                      Icons.badge_outlined,
                      color: _selectedIndex == 0 ? kPrimaryColor : kGrey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Matric ID",
                      style: TextStyle(
                        color: _selectedIndex == 0 ? kPrimaryColor : kGrey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ScaleTap(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  setState(() {
                    _selectedIndex == 1;
                  });
                  _selectDrawerItem(1);
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 1
                      ? kPrimary100Color
                      : Colors.transparent,
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 1 ? kPrimaryColor : kWhite,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: _selectedIndex == 1 ? 13 : 15),
                    Icon(
                      Icons.class_outlined,
                      color: _selectedIndex == 1 ? kPrimaryColor : kGrey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Class Today",
                      style: TextStyle(
                        color: _selectedIndex == 1 ? kPrimaryColor : kGrey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ScaleTap(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex == 2;
                });
                _selectDrawerItem(2);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 2
                      ? kPrimary100Color
                      : Colors.transparent,
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 2 ? kPrimaryColor : kWhite,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    SizedBox(width: _selectedIndex == 2 ? 13 : 15),
                    Icon(
                      Icons.history_edu,
                      color: _selectedIndex == 2 ? kPrimaryColor : kGrey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Attendance History",
                      style: TextStyle(
                        color: _selectedIndex == 2 ? kPrimaryColor : kGrey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ScaleTap(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex == 3;
                });
                _selectDrawerItem(3);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 3
                      ? kPrimary100Color
                      : Colors.transparent,
                ),
                width: double.infinity,
                child: Row(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 25),
                      decoration: BoxDecoration(
                        color: _selectedIndex == 3 ? kPrimaryColor : kWhite,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    SizedBox(width: _selectedIndex == 3 ? 13 : 15),
                    Icon(
                      Icons.password_outlined,
                      color: _selectedIndex == 3 ? kPrimaryColor : kGrey,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Change Password",
                      style: TextStyle(
                        color: _selectedIndex == 3 ? kPrimaryColor : kGrey,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            const Divider(
              color: kPrimary100Color,
              thickness: 1,
            ),
            ScaleTap(
              onPressed: () async {
                // Navigator.pop(context);
                print("logout");
                UserBloc userBloc = UserBloc();
                CustomDialog.show(context,
                    dismissOnTouchOutside: false,
                    description: "Logging you out...",
                    center: ThemeSpinner.spinner());
                await userBloc.signOut(context);
              },
              child: Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.logout_outlined,
                      color: kPrimaryColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Logout",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar _builtAppBar() {
    switch (_selectedIndex) {
      case 0:
        return appBarMatrixId();
      case 1:
        return appBarClassToday();
      case 2:
        return appBarAttendanceHistory();
      case 3:
        return appBarChangePassword();
      default:
        return AppBar();
    }
  }

  Widget _bodyScreen() {
    switch (_selectedIndex) {
      case 0:
        return MatricIDScreen(
         
        );
      case 1:
        return ClassTodayScreen();
      case 2:
        return AttendanceHistoryScreen();
      case 3:
        return ChangePasswordScreen();
      default:
        return Placeholder();
    }
  }
}
