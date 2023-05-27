import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter/material.dart';

class CustomGradientAppBar extends SliverPersistentHeaderDelegate {
  const CustomGradientAppBar({
    required this.maxHeight,
    required this.minHeight,
    required this.child,
    this.leading = const SizedBox.shrink(),
    this.title = const SizedBox.shrink(),
    this.trailing = const SizedBox.shrink(),
    this.titleVisible = true,
  });

  final Widget child;
  final Widget leading;
  final Widget title;
  final Widget trailing;
  final double maxHeight;
  final double minHeight;
  final bool titleVisible;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        gradientBackground(context),
        Padding(
          padding: EdgeInsets.only(top: minHeight / 5, left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              leading,
              Expanded(
                child: titleVisible
                    ? title
                    : Opacity(
                        opacity: getTitleOpacity(shrinkOffset),
                        child: title,
                      ),
              ),
              trailing,
            ],
          ),
        ),
        Positioned(
          top: (maxHeight / 1.45) - shrinkOffset,
          width: MediaQuery.of(context).size.width,
          child: Opacity(
            opacity: getChildOpacity(shrinkOffset),
            child: Center(
              child: child,
            ),
          ),
        ),
      ],
    );
  }

  Container gradientBackground(BuildContext context) {
    return Container(
      height: minExtent,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(101, 152, 181, 1),
            kPrimaryColor,
          ],
        ),
      ),
    );
  }

  double getChildOpacity(double shrinkOffset) {
    double _opacity;
    _opacity = 1 - ((shrinkOffset * 4) / maxHeight);

    if (_opacity > 0) {
      return _opacity;
    } else {
      return 0;
    }
  }

  double getTitleOpacity(double shrinkOffset) {
    if ((shrinkOffset * 2) > maxExtent) {
      return (1 - (shrinkOffset / 4) / maxHeight);
    } else {
      return 0;
    }
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
