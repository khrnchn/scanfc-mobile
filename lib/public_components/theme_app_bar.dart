import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool previous;
  final Color color;
  final Widget? trailing;
  final Widget? leading;
  final Function()? onBackPressed;

  ThemeAppBar(
    this.title, {
    super.key,
    this.previous = true,
    this.color = Colors.transparent,
    this.trailing,
    this.leading,
    this.onBackPressed,
  }) : preferredSize = Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: previous
          ? IconButton(
              onPressed: onBackPressed ?? () => {Navigator.pop(context)},
              iconSize: 24,
              icon: Icon(
                Iconsax.arrow_left,
                color: Colors.black,
              ),
            )
          : null,
      actions: <Widget>[
        trailing ?? SizedBox(),
      ],
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),

      backgroundColor: kWhite,
      centerTitle: true,
      elevation: 0.0,
      // border: Border.symmetric(vertical: BorderSide.none),
      // middle: Text(
      //   "",
      //   style: TextStyle(
      //     fontFamily: 'Poppins',
      //     fontWeight: FontWeight.normal,
      //   ),
      // ),
    );
  }
}
