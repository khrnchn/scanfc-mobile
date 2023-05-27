import 'package:nfc_smart_attendance/constant.dart';

import 'package:nfc_smart_attendance/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    this.onTap,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    required this.index,
  });

  final Function? onTap;
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 100),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: ScaleTap(
              onPressed: onTap != null
                  ? () {
                      return onTap!();
                    }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    itemShadow(),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      getLeading(),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title,
                            subtitle ?? const SizedBox.shrink(),
                          ],
                        ),
                      ),
                      trailing ?? const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getLeading() {
    if (leading != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 10),
        child: leading!,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
