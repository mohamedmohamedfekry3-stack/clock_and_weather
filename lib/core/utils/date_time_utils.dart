class DateTimeUtils {
  DateTimeUtils._();

  static const List<String> _weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  static String formatDate(DateTime dt) {
    final weekday = _weekdays[dt.weekday - 1];
    final month = _months[dt.month - 1];
    return '$weekday, $month ${dt.day}, ${dt.year}';
  }

  static String formatTime12H(DateTime dt, {bool showSeconds = true}) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final hourStr = hour.toString().padLeft(2, '0');
    final minuteStr = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';

    if (showSeconds) {
      final secondStr = dt.second.toString().padLeft(2, '0');
      return '$hourStr:$minuteStr:$secondStr $period';
    }
    return '$hourStr:$minuteStr $period';
  }

  static String getGreeting(DateTime dt) {
    final hour = dt.hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning ☀️';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon 🌤️';
    } else if (hour >= 17 && hour < 22) {
      return 'Good Evening ✨';
    } else {
      return 'Good Night 🌙';
    }
  }

  static String getGreetingSubtitle(DateTime dt) {
    final hour = dt.hour;
    if (hour >= 5 && hour < 12) {
      return 'BEGIN YOUR DAY WITH INTENTION';
    } else if (hour >= 12 && hour < 17) {
      return 'STAY MINDFUL AND PRODUCTIVE';
    } else if (hour >= 17 && hour < 22) {
      return 'TAKE A MOMENT FOR YOURSELF';
    } else {
      return 'PEACEFUL REST & RECHARGE';
    }
  }
}
