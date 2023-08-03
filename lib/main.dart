import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nfc_smart_attendance/app.dart';
import 'package:nfc_smart_attendance/helpers/secure_storage_api.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/resource/user_resource.dart';
import 'package:nfc_smart_attendance/screens/navigation_drawer/navigation_drawer.dart';
import 'package:nfc_smart_attendance/screens/sign_in/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetIt.instance.registerSingleton<UserModel>(UserModel());
    UserModel user = UserModel();

    //save in GetIt
  UserResource.setGetIt(user);

  bool isAuthenticated = false;
  String token = await SecureStorageApi.read(key: "access_token");
  // If access token != ""
  if (token != "") {
    // Already login
    isAuthenticated = true;
  }

    Future<Widget> checkAuth() async {
    // Initial route
    Widget routeName = SignInScreen();
    if (!isAuthenticated) {
      // Not login yet
      routeName = SignInScreen();
    } else {
      // Already login
      routeName = NavigationDrawerScreen();
    }
    return routeName;
  }

  Widget initialRoute = await checkAuth();
   runApp(MyApp(
    initialRoute: initialRoute,
  ));
}

