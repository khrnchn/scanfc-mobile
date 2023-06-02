import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'dart:typed_data';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/public_components/custom_dialog.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:im_animations/im_animations.dart';
import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:iconsax/iconsax.dart';

class RegisterMatricIdScreen extends StatefulWidget {
  final UserModel userModel;
  final bool isRegisterNFC;
  final Function(bool) updateNFC;
  const RegisterMatricIdScreen(
      {super.key,
      required this.userModel,
      required this.isRegisterNFC,
      required this.updateNFC});

  @override
  State<RegisterMatricIdScreen> createState() => _RegisterMatricIdScreenState();
}

class _RegisterMatricIdScreenState extends State<RegisterMatricIdScreen>
    with SingleTickerProviderStateMixin {
  ValueNotifier<dynamic> result = ValueNotifier(null);
  int delayAnimationDuration = 200;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _offsetAnimation;
  String uid = '';
  bool isNFCUpdated = false;

  void _updateNFC() {
    setState(() {
      isNFCUpdated = true;
    });
    widget.updateNFC(true);
    print("update NFC");
    Navigator.pop(context, isNFCUpdated);
  }

  @override
  void initState() {
    super.initState();

    _registerNFC();

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

  // void _tagRead() {
  //   NfcManager.instance.startSession(
  //     onDiscovered: (NfcTag tag) async {
  //       try {
  //         Ndef? ndef = Ndef.from(tag);
  //         await ndef!.read();
  //         NdefMessage? message = await ndef.cachedMessage;
  //         if (message != null) {
  //           result.value = message.records[0].payload;
  //         } else {
  //           result.value = 'Tag is empty or not NDEF formatted';
  //         }
  //       } catch (e) {
  //         result.value = 'Error reading tag: $e';
  //       } finally {
  //         NfcManager.instance.stopSession();
  //       }
  //     },
  //   );
  // }

  void registerMatricCard() async {
    // Start an NFC session
    NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        try {
          // Read the NDEF message from the tag
          NdefMessage message = await Ndef.from(tag)!.read();

          // Perform the registration process here...
          // Add your logic to handle the registration of the NFC card as a matric card

          // Show a dialog box when registration is complete
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Registration Complete'),
              content:
                  Text('The NFC card has been registered as a matric card.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } catch (e) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Error'),
              content: Text('Error during registration: $e'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        } finally {
          NfcManager.instance.stopSession();
        }
      },
    );
  }

  void _registerNFC() {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var mytag = tag.data["mifareultralight"]["identifier"]
          .map((e) => e.toRadixString(16).padLeft(2, '0'))
          .join('');

      result.value = mytag;
      uid = result.value;
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('Muhd Izhamm'),
        NdefRecord.createUri(Uri.parse('email@email.com')),
        NdefRecord.createMime(
            'Matric No', Uint8List.fromList('2020365456'.codeUnits)),
        // NdefRecord.createExternal(
        //     'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
        //todo panggil API untuk masukkan card uid ke db sebelum panggil custom dialogue
        if (mounted) {}
        CustomDialog.show(
          context,
          isDissmissable: false,
          icon: Iconsax.tick_circle,
          title: "Success register Matric ID",
          btnOkText: "OK",
          btnOkOnPress: () {
            Navigator.pop(context);
            widget.isRegisterNFC ? null : _updateNFC();
          },
        );
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }

  // void _ndefWriteLock() {
  //   NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
  //     var ndef = Ndef.from(tag);
  //     if (ndef == null) {
  //       result.value = 'Tag is not ndef';
  //       NfcManager.instance.stopSession(errorMessage: result.value.toString());
  //       return;
  //     }

  //     try {
  //       await ndef.writeLock();
  //       result.value = 'Success to "Ndef Write Lock"';
  //       NfcManager.instance.stopSession();
  //     } catch (e) {
  //       result.value = e;
  //       NfcManager.instance.stopSession(errorMessage: result.value.toString());
  //       return;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Register Matric Id",
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
        child: FutureBuilder<bool>(
          future: NfcManager.instance.isAvailable(),
          builder: (context, ss) => ss.data != true
              ? Center(child: Text('NFC functionality is not available on your device.'))
              : Column(
                  children: [
                    Expanded(
                      flex: 3,
                      child: scanCircle(context),
                    ),
                    Space(50),
                    Expanded(
                      flex: 3,
                      child: DelayedDisplay(
                        delay: Duration(milliseconds: delayAnimationDuration),
                        child: Column(
                          children: [
                            const Text(
                              "Scan Matric ID",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                            Space(10),
                            const Text(
                              "Scan your matric ID\nto your phone to register matric card",
                              style: TextStyle(
                                color: kPrimaryLight,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            ValueListenableBuilder<dynamic>(
                              valueListenable: result,
                              builder: (context, value, _) {
                                print("Card UID: $uid");
                                print("NDEF status: $value");
                                // return Text('$uid ${value ?? ''}');
                                return Text('');
                              },
                            ),
                            Space(40),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget scanCircle(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height / 7,
          left: 100,
          right: 100,
          bottom: 20,
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
                      width: 80,
                      height: 140,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: kPrimaryLightColor,
                        border: Border.all(
                          color: kPrimaryLight,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Matric ID",
                            style: TextStyle(
                              color: kPrimaryLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Space(10),
                          const Icon(
                            Icons.badge,
                            color: kPrimaryLight,
                            size: 40,
                          ),
                          Space(5),
                          const Text(
                            "******",
                            style: TextStyle(
                              color: kPrimaryLight,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
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
          right: 100,
          left: 100,
          bottom: 1,
          child: SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: DelayedDisplay(
                delay: Duration(milliseconds: delayAnimationDuration + 200),
                child: Image.asset(
                  "assets/images/iphone.png",
                  fit: BoxFit.fitHeight,
                  scale: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
