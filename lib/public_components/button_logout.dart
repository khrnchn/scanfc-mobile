import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ButtonLogout extends StatefulWidget {
  final IconData? icon;
  final String title;
  final bool isLoading;
  final String loadingText;
  final bool isDisabled;
  final Color? primaryColor;

  final Function() onPressed;

  const ButtonLogout(
    this.title, {
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.loadingText = "",
    this.primaryColor = kPrimaryColor,
    this.icon = Icons.logout_outlined,
  });

  @override
  _ButtonLogoutState createState() => _ButtonLogoutState();
}

class _ButtonLogoutState extends State<ButtonLogout> {
  final spinner = SizedBox(
    height: 24,
    width: 24,
    child: SpinKitDoubleBounce(
      color: kPrimaryColor,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      // If is disabled, enable feedback false
      enableFeedback: widget.isDisabled ? false : true,
      onPressed:
          // If disabled or is loading, null on press
          widget.isDisabled || widget.isLoading ? null : widget.onPressed,
      scaleMinValue: 0.95,
      scaleCurve: CurveSpring(),
      opacityMinValue: 0.90,
      opacityCurve: Curves.ease,
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10),
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              // If disabled or is loading, disabled background color
              color: widget.isDisabled || widget.isLoading
                  ? kDisabledBg
                  : widget.primaryColor,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(15),
                right: Radius.circular(15),
              )),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.isLoading
                  ? Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: spinner),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    )
                  : Text(''),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    widget.isLoading ? widget.loadingText : widget.title,
                    style: TextStyle(
                      color: widget.isLoading ? kDisabledText : Colors.white,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
