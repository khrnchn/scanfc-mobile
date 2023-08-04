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
  final PagingController<int, ClassTodayModel> _classTodayPagingController =
      PagingController(firstPageKey: 1);

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    _classTodayPagingController.refresh();
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
          _classTodayPagingController.appendLastPage(listClassTodayModel);
        } else {
          final nextPageKey = pageKey + listClassTodayModel.length;
          _classTodayPagingController.appendPage(
              listClassTodayModel, nextPageKey);
        }
      } else {
        _classTodayPagingController.error = response.message;
        print(response.message);
      }
    } catch (error) {
      _classTodayPagingController.error = "Server Error";
    }
  }

  @override
  void initState() {
    super.initState();
    _classTodayPagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  int delayAnimationDuration = 100;
  int classMode = ClassTodayType.physical; // change to Online

  bool isAttendanceSubmitted = false;

  void updateAttendance() {
    _onRefresh();
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
            pagingController: _classTodayPagingController,
            builderDelegate: PagedChildBuilderDelegate<ClassTodayModel>(
              firstPageProgressIndicatorBuilder: (context) {
                return ThemeSpinner.spinner();
              },
              newPageProgressIndicatorBuilder: (context) {
                return ThemeSpinner.spinner();
              },
              noItemsFoundIndicatorBuilder: (context) => const EmptyList(
                icon: Icons.menu_book,
                title: "No Class Today ",
                subtitle: "Today have no class",
                query: '',
              ),
              animateTransitions: true,
              itemBuilder: (context, classTodayModel, index) {
                return classTodayItem(
                    context: context, classTodayModel: classTodayModel);
              },
            ),
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
                if (classTodayModel.classroomType == ClassTodayType.online) {
                  return OnlineClassScreen(
                    classroomsId: classTodayModel.id!,
                    className:
                        "${classTodayModel.section!.subject!.code} (${classTodayModel.classroomName})",
                    isAttendanceSubmitted: isAttendanceSubmitted,
                    updateAttendance: updateAttendance,
                  );
                } else if (classTodayModel.classroomType ==
                    ClassTodayType.physical) {
                  return FaceToFaceClassScreen(
                    classroomsId: classTodayModel.id!,
                    className:
                        "${classTodayModel.section!.subject!.code} (${classTodayModel.classroomName})",
                    isAttendanceSubmitted: isAttendanceSubmitted,
                    updateAttendance: updateAttendance,
                  );
                } else {
                  throw ArgumentError(
                      "Invalid class type: ${classTodayModel.classroomType}");
                }
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
                        classTodayModel.classroomType == ClassTodayType.physical
                            ? faceToFaceBadge()
                            : (classTodayModel.classroomType ==
                                    ClassTodayType.online
                                ? onlineClassBadge()
                                : SizedBox()),
                        classTodayModel.attendanceStatus ==
                                AttendanceStatus.present
                            ? attendanceSubmittedBadge()
                            : (classTodayModel.attendanceStatus ==
                                    AttendanceStatus.absent
                                ? attendanceNotSubmittedBadge()
                                : SizedBox()),
                      ],
                    ),
                    Space(10),
                    Text(
                      "${classTodayModel.section!.subject!.code} (${classTodayModel.classroomName})",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space(3),
                    Text(
                      classTodayModel.section!.subjectName!,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space(3),
                    Text(
                      classTodayModel.venueName!,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space(3),
                    Text(
                      classTodayModel.sectionName!,
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space(3),
                    Text(
                      "Lecturer: ${classTodayModel.section!.lecturerName!}",
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Space(10),
                    Text(
                      "Start at : ${formatDate(classTodayModel.startAt!)}",
                      style: TextStyle(
                        color: kPrimaryLight,
                        fontSize: 11,
                      ),
                    ),
                    Text(
                      "End at   : ${formatDate(classTodayModel.endAt!)}",
                      style: TextStyle(
                        color: kPrimaryLight,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);

    String day = dateTime.day.toString();
    String month = getMonthName(dateTime.month);
    String year = dateTime.year.toString();

    String hour = (dateTime.hour % 12).toString();
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String amPm = dateTime.hour < 12 ? 'am' : 'pm';

    return '$day $month $year | $hour.$minute$amPm';
  }

  String getMonthName(int month) {
    List<String> monthNames = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month];
  }
}
