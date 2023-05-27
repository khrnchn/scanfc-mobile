class TimeDifference {
  //"today" fake date based on design.
  static DateTime today = DateTime(2022, 10, 23);
  // static DateTime today = DateTime.now();

  // The following function calculate duration between [today] and passed [value] in "n days n hours"
  static String inDaysHours(DateTime value) {
    Duration duration = value.difference(today);
    int dayCount = duration.inDays.abs();
    int hourCount = duration.inHours.remainder(24).abs();

    if (hourCount != 0) {
      return "$dayCount days $hourCount hours";
    } else {
      return "$dayCount days";
    }
  }

  // The following function calculate duration between [today] and passed [value] in "n days"
  static String inDays(DateTime value) {
    int count = value.difference(today).inDays.abs();
    return "$count days";
  }
}
