import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:nfc_smart_attendance/bloc/class_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/helpers/http_response.dart';
import 'package:nfc_smart_attendance/models/class_today/class_today_model.dart';
import 'package:nfc_smart_attendance/models/class_today/list_class_today_response_model.dart';
import 'package:nfc_smart_attendance/public_components/empty_list.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/status_badges.dart';
import 'package:nfc_smart_attendance/public_components/theme_spinner.dart';
import 'package:nfc_smart_attendance/screens/face_to_face_class/face_to_face_class_screen.dart';
import 'package:nfc_smart_attendance/screens/online_class/online_class_screen.dart';
import 'package:nfc_smart_attendance/theme.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ClassTodayScreen extends StatefulWidget {
  const ClassTodayScreen({super.key});

  @override
  State<ClassTodayScreen> createState() => _ClassTodayScreenState();
}

class _ClassTodayScreenState extends State<ClassTodayScreen> {
  ClassBloc classBloc = ClassBloc();
  static const _pageSize = 30;
  final PagingController<int, ClassTodayModel> _nursePagingController =
      PagingController(firstPageKey: 1);

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    _nursePagingController.refresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      //Call API
      final ListClassTodayResponseModel response =
          await classBloc.getListClassToday();

      // If success
      if (response.statusCode == HttpResponse.HTTP_OK) {
        List<ClassTodayModel> listClassTodayModel = response.data!;

        // Compare the lenght with the page size to know either already last page or not
        final isLastPage = listClassTodayModel.length < _pageSize;
        if (isLastPage) {
          _nursePagingController.appendLastPage(listClassTodayModel);
        } else {
          final nextPageKey = pageKey + listClassTodayModel.length;
          _nursePagingController.appendPage(listClassTodayModel, nextPageKey);
        }
      } else {
        _nursePagingController.error = response.message;
        print(response.message);
      }
    } catch (error) {
      _nursePagingController.error = "Server Error";
    }
  }

  int delayAnimationDuration = 100;
  String classMode = "Face to Face"; // change to Online

  bool isAttendanceSubmitted = false;

  void updateAttendance(bool submitted) {
    setState(() {
      isAttendanceSubmitted = submitted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      header: WaterDropMaterialHeader(
        backgroundColor: kPrimaryColor,
      ),
      onRefresh: _onRefresh,
      child: CustomScrollView(
        slivers: <Widget>[
          PagedSliverList<int, ClassTodayModel>(
            pagingController: _nursePagingController,
            builderDelegate: PagedChildBuilderDelegate<ClassTodayModel>(
                firstPageProgressIndicatorBuilder: (context) {
                  return ThemeSpinner.spinner();
                },
                newPageProgressIndicatorBuilder: (context) {
                  return ThemeSpinner.spinner();
                },
                noItemsFoundIndicatorBuilder: (context) => const EmptyList(
                      icon: Iconsax.people,
                      title: "No Nurse History ",
                      subtitle: "No new nurse history available",
                      query: '',
                    ),
                animateTransitions: true,
                itemBuilder: (context, classTodayModel, index) {
                  return classTodayItem(
                      context: context, classTodayModel: classTodayModel);
                },),
          )
        ],
      ),
    );
  }

  Widget classTodayItem(
      {required BuildContext context,
      required ClassTodayModel classTodayModel}) {
    return DelayedDisplay(
      delay: Duration(milliseconds: delayAnimationDuration),
      child: ScaleTap(
        onPressed: () async {
          print("navigate to scan nfc");
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return classMode != "Online"
                    ? OnlineClassScreen(
                        classMode: classMode,
                        isAttendanceSubmitted: isAttendanceSubmitted,
                        updateAttendance: updateAttendance,
                      )
                    : FaceToFaceClassScreen(
                        classMode: classMode,
                        isAttendanceSubmitted: isAttendanceSubmitted,
                        updateAttendance: updateAttendance,
                      );
              },
            ),
          );

          if (result != null && result is bool) {
            setState(() {
              isAttendanceSubmitted = result;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                profileShadow(
                  kPrimaryLight.withOpacity(0.2),
                ),
              ],
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        faceToFaceBadge(),
                        if (isAttendanceSubmitted)
                          attendanceSubmittedBadge()
                        else
                          attendanceNotSubmittedBadge(),
                      ],
                    ),
                    onlineClassBadge(),
                    Space(10),
                    Text(
                      "ISP641",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space(3),
                    Text(
                      "E Commerce Application",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space(10),
                    Text(
                      "26 March 2023 | 4.00pm",
                      style: TextStyle(
                        color: kPrimaryLight,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
