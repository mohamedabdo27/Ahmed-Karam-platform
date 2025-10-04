import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTime(TimeOfDay timePicker) {
  final now = DateTime.now();
  final dateTime = DateTime(
      now.year, now.month, now.day, timePicker.hour, timePicker.minute);

  // Format the time using DateFormat
  final formattedTime = DateFormat.jm().format(dateTime);
  // int hour = timePicker.hourOfPeriod;
  // String period = timePicker.period == DayPeriod.am ? "AM" : "PM";

  // String formattedTime =
  //     "${hour == 0 ? 12 : hour}:${timePicker.minute.toString().padLeft(2, '0')} $period";

  return formattedTime;
}
