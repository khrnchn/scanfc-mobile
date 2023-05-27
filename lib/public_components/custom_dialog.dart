import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';

class CustomDialog extends StatefulBuilder {
  CustomDialog({required super.builder});

  static Future<bool?> show(BuildContext context,
      {StateSetter? stateSetter,
      bool dismissOnTouchOutside = true,
      Widget? center,
      // Widget? top,
      IconData? icon,
      String? title,
      String? description,
      int dialogType = DialogType.info,
      String? btnOkText,
      String? btnCancelText,
      bool isDissmissable = true,
      Function()? btnCancelOnPress,
      Function()? btnOkOnPress}) async {
    return await showDialog<bool>(
        barrierDismissible: isDissmissable,
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setter) {
            stateSetter = setter;
            return WillPopScope(
              onWillPop: () async => isDissmissable,
              child: Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      icon != null
                          ? Container(
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: getBgColor(dialogType),
                              ),
                              child: Center(
                                child: Icon(
                                  icon,
                                  color: getTextColor(dialogType),
                                  size: 30,
                                ),
                              ),
                            )
                          : Space(0),
                      // top ?? Space(0),
                      icon != null ? Space(10) : Space(0),
                      Text(
                        title ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      title != null ? Space(10) : Space(0),
                      Text(
                        description ?? "",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: kTextGray),
                      ),
                      description != null ? Space(10) : Space(0),
                      center ?? SizedBox(height: 0),
                      center != null ? Space(10) : Space(0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          btnCancelText != null
                              ? Expanded(
                                  child: ScaleTap(
                                    onPressed: btnCancelOnPress,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: kPrimaryLightColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Center(
                                          child: Text(
                                            btnCancelText,
                                            style: TextStyle(color: kDarkGrey),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          btnCancelText != null && btnOkText != null
                              ? SizedBox(width: 10)
                              : SizedBox(width: 0),
                          btnOkText != null
                              ? Expanded(
                                  child: ScaleTap(
                                  onPressed: btnOkOnPress,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: getTextColor(dialogType),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Center(
                                          child: Text(
                                        btnOkText,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ))
                              : Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  static Color getTextColor(int dialogType) {
    if (dialogType == DialogType.success) {
      return kTextSuccess;
    } else if (dialogType == DialogType.danger) {
      return kTextDanger;
    } else if (dialogType == DialogType.warning) {
      return kTextWarning;
    } else {
      return kTextInfo;
    }
  }

  static Color getBgColor(int dialogType) {
    if (dialogType == DialogType.success) {
      return kBgSuccess;
    } else if (dialogType == DialogType.danger) {
      return kBgDanger;
    } else if (dialogType == DialogType.warning) {
      return kBgWarning;
    } else {
      return kBgInfo;
    }
  }
}
