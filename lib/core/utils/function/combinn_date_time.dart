import 'package:flutter/material.dart';

DateTime combineDateTime({required DateTime date, required TimeOfDay time}) {
  DateTime combinedDateTime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
  return combinedDateTime;
  // Format as "yyyy-MM-ddTHH:mm:ss.SSS+00:00"
  // return "${combinedDateTime.toIso8601String()}+00:00";
}
