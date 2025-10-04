import 'package:ahmed_karam/core/utils/function/combinn_date_time.dart';
import 'package:ahmed_karam/core/utils/function/format_time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.title,
    required this.onSelectDateTime,
  });
  final String title;
  final Function(DateTime dateTime) onSelectDateTime;
  @override
  State<DatePicker> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime? date;
  TimeOfDay? time;
  bool isSelectDateTime = true;
  bool validate() {
    if (time != null && date != null) {
      isSelectDateTime = true;
      setState(() {});
      return true;
    } else {
      isSelectDateTime = false;
      setState(() {});
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // AddQuizCubit cubit=BlocProvider.of<AddQuizCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  isSelectDateTime
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.error,
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final datePicker = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),

                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 200)),
                      );
                      setState(() {
                        date = datePicker;
                      });

                      if (date != null && time != null) {
                        DateTime dateTime = combineDateTime(
                          date: date!,
                          time: time!,
                        );
                        widget.onSelectDateTime(dateTime);
                      }
                    },

                    child: Icon(
                      Icons.date_range_outlined,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 70),
                  Text(
                    date == null ? "" : DateFormat('yyyy-MM-dd').format(date!),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                height: 1.5,
                color: Theme.of(context).colorScheme.secondary,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      final timePicker = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      setState(() {
                        time = timePicker;
                      });
                      if (date != null && time != null) {
                        DateTime dateTime = combineDateTime(
                          date: date!,
                          time: time!,
                        );
                        widget.onSelectDateTime(dateTime);
                      }
                    },

                    child: Icon(
                      Icons.timer_outlined,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: 32,
                    ),
                  ),
                  SizedBox(width: 70),
                  Text(
                    time == null ? "" : formatTime(time!),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 5),

        if (!isSelectDateTime)
          Text(
            "Please select ${widget.title.toLowerCase()} and time",
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
              fontSize: 12,
            ),
          ),
      ],
    );
  }
}
