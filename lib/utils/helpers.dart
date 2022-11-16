import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Format a number
/// 1234 => 1 234
String formatNumber(num value) {
  return NumberFormat().format(value);
}

Size getDeviceSize(BuildContext context) {
  return MediaQuery.of(context).size;
}




String to2Digits(int value) {
  return value.toString().padLeft(2, '0');
}

/// format the [date] using with the [pattern]
String formatDate(DateTime date, String pattern) {
  if (isToday(date)) return "Today";

  if (isYesterday(date)) return "Yesterday";

  return DateFormat(pattern).format(date);
}

bool isToday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day;
}

bool isYesterday(DateTime date) {
  final now = DateTime.now();
  return date.year == now.year &&
      date.month == now.month &&
      date.day == now.day - 1;
}

bool areTheSameDayDate(DateTime d1, DateTime d2) {
  final f1 = DateTime(d1.year, d1.month, d1.day);
  final f2 = DateTime(d2.year, d2.month, d2.day);

  return f1.difference(f2).inDays == 0;
}

DateTime formatToYMD(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}


String formatDuration(DateTime date) {
  // final Duration duration = DateTime.now().difference(notifDate);
  final Duration duration = DateTime.now().difference(date);
  final int totalHours = duration.inHours;
  final int totalMinutes = duration.inMinutes;
  final int totalSeconds = duration.inSeconds;
  final int totalDays = duration.inDays;
  // print(
  //     "durations: days, hours, minutes, seconds => $totalDays,  $totalHours, $totalMinutes, $totalSeconds");

  final int hours = duration.inHours.remainder(60);
  final int minutes = duration.inMinutes.remainder(60);
  // final int seconds = duration.inSeconds.remainder(60);
  // final int days = duration.inDays.remainder(24);

  // print(
  //     "durations remainder: hours, minutes, seconds =>  $hours, $minutes, $seconds");

  if (totalSeconds < 60) {
    return "Now";
  } else if (totalMinutes < 60) {
    return "$minutes min.";
  } else if (totalHours < 24) {
    return "$hours hr.";
  } else if (totalDays < 2) {
    return "Yesterday";
  } else {
    final String hour = to2Digits(date.hour);
    final String minute = to2Digits(date.minute);

    return "$hour:$minute";
  }
}