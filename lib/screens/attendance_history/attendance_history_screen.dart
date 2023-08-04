import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nfc_smart_attendance/bloc/class_bloc.dart';
import 'package:nfc_smart_attendance/constant.dart';
import 'package:nfc_smart_attendance/helpers/general_method.dart';
import 'package:nfc_smart_attendance/helpers/http_response.dart';
import 'package:nfc_smart_attendance/models/attendance_history/attendance_history_model.dart';
import 'package:nfc_smart_attendance/models/attendance_history/list_attendance_history_response_model.dart';
import 'package:nfc_smart_attendance/public_components/empty_list.dart';
import 'package:nfc_smart_attendance/public_components/space.dart';
import 'package:nfc_smart_attendance/public_components/theme_spinner.dart';
import 'package:nfc_smart_attendance/screens/attendance_history/attendance_history_details_screen.dart';
import 'package:nfc_smart_attendance/theme.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../public_components/status_badges.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({super.key});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  ClassBloc classBloc = ClassBloc();
  static const _pageSize = 30;
  final PagingController<int, AttendanceHistoryModel>
      _attendanceHistoryPagingController = PagingController(firstPageKey: 1);

  // For refresher
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    _attendanceHistoryPagingController.refresh();
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      //Call API
      final ListAttendanceHistoryResponseModel response =
          await classBloc.getListAttendanceHistory();

      // If success
      if (response.statusCode == HttpResponse.HTTP_OK) {
        List<AttendanceHistoryModel> listAttendanceHistoryModel =
            response.data!;

        // Compare the lenght with the page size to know either already last page or not
        final isLastPage = listAttendanceHistoryModel.length < _pageSize;
        if (isLastPage) {
          _attendanceHistoryPagingController
              .appendLastPage(listAttendanceHistoryModel);
        } else {
          final nextPageKey = pageKey + listAttendanceHistoryModel.length;
          _attendanceHistoryPagingController.appendPage(
              listAttendanceHistoryModel, nextPageKey);
        }
      } else {
        _attendanceHistoryPagingController.error = response.message;
        print(response.message);
      }
    } catch (error) {
      _attendanceHistoryPagingController.error = "Server Error";
    }
  }

  @override
  void initState() {
    super.initState();
    _attendanceHistoryPagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  int delayAnimationDuration = 100;
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
          PagedSliverList<int, AttendanceHistoryModel>(
            pagingController: _attendanceHistoryPagingController,
            builderDelegate: PagedChildBuilderDelegate<AttendanceHistoryModel>(
              firstPageProgressIndicatorBuilder: (context) {
                return ThemeSpinner.spinner();
              },
              newPageProgressIndicatorBuilder: (context) {
                return ThemeSpinner.spinner();
              },
              noItemsFoundIndicatorBuilder: (context) => const EmptyList(
                icon: Icons.menu_book,
                title: "No Attendance History ",
                subtitle: "Submit your attendance to view attendance history",
                query: '',
              ),
              animateTransitions: true,
              itemBuilder: (context, attendanceHistoryModel, index) {
                return attendanceHistoryItem(
                  context: context,
                  attendanceHistoryModel: attendanceHistoryModel,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget attendanceHistoryItem({
    required BuildContext context,
    required AttendanceHistoryModel attendanceHistoryModel,
  }) {
    return DelayedDisplay(
      delay: Duration(milliseconds: delayAnimationDuration),
      child: ScaleTap(
        onPressed: () {
          navigateTo(
            context,
            AttendanceHistoryDetailsScreen(
                attendanceHistoryModel: attendanceHistoryModel),
          );
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
                profileShadow(kGrey.withOpacity(0.3)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          attendanceHistoryModel.attendanceStatus ==
                                  AttendanceStatus.present
                              ? presentBadge()
                              : (attendanceHistoryModel.attendanceStatus ==
                                      AttendanceStatus.absent
                                  ? absentBadge()
                                  : SizedBox()),

                          // if absent, show exemption. Else no exemption needed
                          attendanceHistoryModel.attendanceStatus ==
                                  AttendanceStatus.absent
                              ? attendanceHistoryModel.exemptionStatus ==
                                      ExemptionStatus.needed
                                  ? exemptionNeededBadge()
                                  : attendanceHistoryModel.exemptionStatus ==
                                          ExemptionStatus.submitted
                                      ? exemptionSubmittedBadge()
                                      : SizedBox()
                              : noExemptionNeededBadge(),
                        ],
                      ),
                      Space(10),
                      Text(
                        "${attendanceHistoryModel.classroom!.section!.subject!.code!} (${attendanceHistoryModel.classroom!.classroomName})",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Space(3),
                      Text(
                        attendanceHistoryModel.classroom!.section!.subjectName!,
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Space(3),
                      // Text(
                      //   attendanceHistoryModel.classroom!.venueName!,
                      //   style: TextStyle(
                      //     color: kPrimaryColor,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Space(3),
                      // Text(
                      //   attendanceHistoryModel.classroom!.sectionName!,
                      //   style: TextStyle(
                      //     color: kPrimaryColor,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // Space(3),
                      // Text(
                      //   "Lecturer: ${attendanceHistoryModel.classroom!.section!.lecturerName!}",
                      //   style: TextStyle(
                      //     color: kPrimaryColor,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      Space(10),
                      Text(
                        "Start at : ${formatDate(attendanceHistoryModel.classroom!.startAt!)}",
                        style: TextStyle(
                          color: kPrimaryLight,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        "End at   : ${formatDate(attendanceHistoryModel.classroom!.endAt!)}",
                        style: TextStyle(
                          color: kPrimaryLight,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
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
