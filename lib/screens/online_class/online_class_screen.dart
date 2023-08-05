import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/bloc/class_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/models/attend_online_class/attend_online_class_request_model.dart';
import 'package:nfc_smart_attendance/models/class_today/class_today_model.dart';
import 'package:nfc_smart_attendance/models/default_response_model.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/custom_dialog.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/screens/request_exemption/request_exemption_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';

class OnlineClassScreen extends StatefulWidget {
  final int classroomsId;
  final Function() updateAttendance;
  final String className;
  const OnlineClassScreen({
    super.key,
    required this.updateAttendance,
    required this.className,
    required this.classroomsId,
  });

  @override
  State<OnlineClassScreen> createState() => _OnlineClassScreenState();
}

class _OnlineClassScreenState extends State<OnlineClassScreen> {
  int delayAnimationDuration = 200;
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isAttendanceSubmitted = false;
  bool isLoading = false;

  void submitAttendance() {
    setState(() {
      isAttendanceSubmitted = true;
    });
    widget.updateAttendance();
    print("update Attendance");
    Navigator.pop(context);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: kPrimaryColor,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.classroomsId);
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  ClassBloc classBloc = ClassBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          widget.className,
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
      body: Column(
        children: <Widget>[
          Expanded(flex: 5, child: _buildQrView(context)),
          (result != null)
              ? Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Classroom ID: ${result!.code}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // widget.classtoomId = route
                      // result!.code = requestModel
                      (result!.code == widget.classroomsId.toString())
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ButtonPrimary(
                                "Attend Class",
                                isLoading: isLoading,
                                loadingText: "Please Wait...",
                                onPressed: () async {
                                  await attendOnlineClass(context);
                                },
                              ),
                            )
                          : Space(0),
                    ],
                  ),
                )
              : Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Space(10),
                      const Text(
                        "Please scan the Attendance QR Code that given by your lecturer",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Future<void> attendOnlineClass(BuildContext context) async {
    setState(() {
      isLoading = true;
    });
    DefaultResponseModel responseModel = await classBloc.attendOnlineClass(
      widget.classroomsId,
      AttendOnlineClassRequestModel(classroomId: result!.code!),
    );

    setState(() {
      isLoading = false;
    });

    if (responseModel.isSuccess == true && responseModel.errors == null) {
      if (mounted) {
        CustomDialog.show(
          context,
          isDissmissable: false,
          icon: Iconsax.tick_circle,
          title: responseModel.message,
          btnOkText: "OK",
          btnOkOnPress: () {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.updateAttendance();
          },
        );
      }
    } else if (responseModel.isSuccess == false &&
        responseModel.errors == null) {
      if (mounted) {
        CustomDialog.show(
          context,
          isDissmissable: false,
          icon: Iconsax.tick_circle,
          title: responseModel.message,
          btnOkText: "OK",
          btnOkOnPress: () {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.updateAttendance();
          },
        );
      }
    } else {
      if (mounted) {
        CustomDialog.show(
          context,
          isDissmissable: false,
          icon: Iconsax.tick_circle,
          title: responseModel.message,
          btnOkText: "OK",
          btnOkOnPress: () {
            Navigator.pop(context);
            Navigator.pop(context);
            widget.updateAttendance();
          },
        );
      }
    }
  }
}
