import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/bloc/user_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/secure_storage_api.dart';
import 'package:nfc_smart_attendance/models/user/user_model.dart';
import 'package:nfc_smart_attendance/models/user/user_response_model.dart';
import 'package:nfc_smart_attendance/providers/user_data_notifier.dart';
import 'package:nfc_smart_attendance/public_components/button_primary.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/theme_snack_bar.dart';
import 'package:nfc_smart_attendance/public_components/theme_spinner.dart';
import 'package:nfc_smart_attendance/resource/user_resource.dart';
import 'package:nfc_smart_attendance/screens/register_matric_id/register_matric_id_screen.dart';
import 'package:nfc_smart_attendance/screens/register_matric_id/register_matric_id_screen2.dart';
import 'package:nfc_smart_attendance/theme.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class MatricIDScreen extends StatefulWidget {
  const MatricIDScreen({
    super.key,
  });

  @override
  State<MatricIDScreen> createState() => _MatricIDScreenState();
}

class _MatricIDScreenState extends State<MatricIDScreen> {
  bool isRegisterNFC = false;

  late Future<UserModel?> _userModel;
  UserBloc userBloc = UserBloc();

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void updateNFC() {
    _onRefresh();
  }

  void _onRefresh() async {
    UserModel? user = await checkAuthenticated();

    if (user != null) {
      // Declare notifier
      final UserDataNotifier userDataNotifier =
          Provider.of<UserDataNotifier>(context, listen: false);
      // Set to the notifier
      userDataNotifier.setUserData(user);
    }
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<UserModel?> checkAuthenticated() async {
    //get data from secure storage
    try {
      final UserResponseModel userResponseModel = await userBloc.me(context);
      if (userResponseModel.data != null) {
        print(userResponseModel.message);
        //save in secured storage
        await SecureStorageApi.saveObject("user", userResponseModel.data!);
        //save in GetIt
        UserResource.setGetIt(userResponseModel.data!);

        return userResponseModel.data!;
      } else {
        ThemeSnackBar.showSnackBar(context, userResponseModel.message);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getUserDetails() async {
    //return this._memoizer.runOnce((user) async {
    // Means no argument passed to this interface, so current user profile
    // Get from getit current user data
    UserModel user = GetIt.instance.get<UserModel>();
    if (user.id != null) {
      return user;
    } else {
      return await checkAuthenticated();
    }
  }

  @override
  void initState() {
    super.initState();
    _userModel = getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropMaterialHeader(),
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        child: // Use the user data notifier
            Consumer<UserDataNotifier>(builder: (context, userDataNotifier, _) {
          // If the user data in the notifier is not null
          if (userDataNotifier.user != null) {
            // Show UI using the data in the notifier
            return body(
              context: context,
              userModel: userDataNotifier.user!,
            );
            // Else try o get the data from shared preferences the show the UI
          } else {
            return FutureBuilder(
                future: _userModel,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    // Set to the user data notifier
                    userDataNotifier.setUserData(snapshot.data);
                    // return UI
                    return body(
                      context: context,
                      userModel: snapshot.data!,
                    );
                  } else {
                    // Show loading
                    return Center(
                      child: ThemeSpinner.spinner(),
                    );
                  }
                });
          }
        }),
      ),
    );
  }

  Widget body({required BuildContext context, required UserModel userModel}) {
    return Padding(
        padding: const EdgeInsets.all(15),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              userModel.uuid != ""
                  ? matricAfterRegister(context, userModel)
                  : Column(
                      children: [
                        matricBeforeRegister(context, userModel),
                        Space(10),
                        const Text(
                          "Please register your Matric Card",
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
              profileInformation(
                title: "Full Name",
                icon: Icons.person,
                sub: userModel.name!,
              ),
              profileInformation(
                title: "Email",
                icon: Icons.email,
                sub: userModel.email!,
              ),
              profileInformation(
                title: "Phone No",
                icon: Icons.phone,
                sub: userModel.phoneNo!,
              ),
            ],
          ),
        ));
  }

  ScaleTap matricBeforeRegister(BuildContext context, UserModel userModel) {
    return ScaleTap(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return RegisterMatricIdScreen(
                userModel: userModel,
                isRegisterNFC: isRegisterNFC,
                updateNFC: updateNFC,
              );
            },
          ),
        );
        // if (result != null && result is bool) {
        //   setState(() {
        //     isRegisterNFC = result;
        //   });
        // }
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: MediaQuery.of(context).size.width / 2.4,
          height: MediaQuery.of(context).size.height / 3,
          decoration: BoxDecoration(
              color: kWhite,
              border: Border.all(
                color: kPrimaryLight,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                profileShadow(kPrimaryLight.withOpacity(0.15)),
              ]),
          child: const Center(
            child: Icon(
              Iconsax.add_circle,
              size: 30,
              color: kPrimaryColor,
            ),
          )),
    );
  }

  Widget matricAfterRegister(BuildContext context, UserModel userModel) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      width: MediaQuery.of(context).size.width / 2.4,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
          color: kWhite,
          border: Border.all(
            color: kPrimaryLight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            profileShadow(kPrimaryLight.withOpacity(0.15)),
          ]),
      child: Column(
        children: [
          Text(
            "UITM JASIN\nMELAKA",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Space(10),
          Image.asset(
            "assets/images/uitm_logo.png",
            width: 120,
            height: 120,
          ),
          Space(30),
          Text(
            "${getFirstTwoWords(userModel.name!)}",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          Space(20),
          Text(
            userModel.matrixId!,
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String getFirstTwoWords(String fullName) {
    List<String> words = fullName.split(' ');
    if (words.length <= 3) {
      return words[0];
    } else {
      return '${words[0]} ${words[1]}';
    }
  }

  Widget profileInformation(
      {required String title,
      required IconData icon,
      required String sub,
      String? relation,
      String? description}) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: kPrimary100Color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            profileShadow(kPrimary100Color),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Space(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Icon(
                icon,
                size: 20,
                color: kPrimaryColor,
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      relation != null ? "$sub ($relation)" : sub,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    Space(3),
                    description != null
                        ? Text(
                            description,
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 12,
                            ),
                          )
                        : Space(0),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
