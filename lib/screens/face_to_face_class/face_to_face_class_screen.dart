import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:im_animations/im_animations.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/screens/request_exemption/request_exemption_screen.dart';

class FaceToFaceClassScreen extends StatefulWidget {
  final String classMode;
  const FaceToFaceClassScreen({super.key, required this.classMode});

  @override
  State<FaceToFaceClassScreen> createState() => _FaceToFaceClassScreenState();
}

class _FaceToFaceClassScreenState extends State<FaceToFaceClassScreen>
    with SingleTickerProviderStateMixin {
  int delayAnimationDuration = 200;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.2), // Start slightly below the origin position
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_controller);

    _startBlinking();
  }

  void _startBlinking() {
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Positioned(
                    top: MediaQuery.of(context).size.height / 7,
                    left: 100,
                    right: 100,
                    child: DelayedDisplay(
                      delay: Duration(milliseconds: delayAnimationDuration),
                      child: Center(
                        child: ColorSonar(
                          duration: Duration(milliseconds: 1200),
                          waveMotionEffect: Curves.easeInOut,
                          innerWaveColor: kPrimaryColor,
                          middleWaveColor: kPrimaryColor.withOpacity(0.5),
                          outerWaveColor: kPrimaryColor.withOpacity(0.2),
                          contentAreaColor: kPrimaryColor,
                          contentAreaRadius: 100,
                          child: AnimatedSwitcherTranslation.bottom(
                              duration: const Duration(milliseconds: 1),
                              child: Container(
                                width: 150,
                                height: 100,
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kPrimaryLightColor,
                                  border: Border.all(
                                    color: kPrimaryColor,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Space(3),
                                        Text(
                                          "NFC Reader",
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 5),
                                    Icon(
                                      Icons.nfc_rounded,
                                      color: kPrimaryColor,
                                      // size: 30,
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height / 5,
                    right: 160,
                    left: 160,
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: DelayedDisplay(
                          delay: Duration(
                              milliseconds: delayAnimationDuration + 200),
                          child: Image.asset(
                            "assets/images/iphone.png",
                            fit: BoxFit.fitHeight,
                            scale: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Space(20),
            Expanded(
              flex: 3,
              child: DelayedDisplay(
                delay: Duration(milliseconds: delayAnimationDuration),
                child: Column(
                  children: [
                    Text(
                      "Scan Phone",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    Space(10),
                    Text(
                      "Scan your phone to the nfc reader\nat your lecturer table",
                      style: TextStyle(
                        color: kPrimaryLight,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Space(40),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
