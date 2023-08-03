import 'package:flutter/cupertino.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:nfc_smart_attendance/screens/navigation_drawer/navigation_drawer.dart';
import 'package:nfc_smart_attendance/screens/sign_in/sign_in_screen.dart';
import 'package:nfc_smart_attendance/theme.dart';
import 'package:flutter/services.dart';
import 'package:nfc_smart_attendance/providers/user_data_notifier.dart';

import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  final Widget initialRoute;
  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
   @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => UserDataNotifier()),
          ],
          child: MaterialApp(
            // Providing a restorationScopeId allows the Navigator built by the
            // MaterialApp to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            restorationScopeId: 'app',
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return MediaQuery(
                data: getTextScaleFactor(context),
                child: ScrollConfiguration(
                    behavior: ScrollBehaviorModified(),
                    child: widget ?? Container()),
              );
            },
            theme: theme(),
            // Define a function to handle named routes in order to support
            // Flutter web url navigation and deep linking.
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SignInScreen.routeName:
                      return SignInScreen();
                    case NavigationDrawerScreen.routeName:
                      return NavigationDrawerScreen();
                    default:
                      return initialRoute; // change this for run first
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
   MediaQueryData getTextScaleFactor(BuildContext context) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);

    if (_mediaQuery.size.width >= 370) {
      return _mediaQuery.copyWith(textScaleFactor: 1.0);
    } else if (350 < _mediaQuery.size.width && _mediaQuery.size.width < 370) {
      return _mediaQuery.copyWith(textScaleFactor: 0.90);
    } else {
      return _mediaQuery.copyWith(textScaleFactor: 0.8);
    }
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}