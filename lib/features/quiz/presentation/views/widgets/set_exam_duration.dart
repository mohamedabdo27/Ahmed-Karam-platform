import 'package:flutter/material.dart';

class SetExamDurationScreen extends StatefulWidget {
  const SetExamDurationScreen({
    super.key,
    required this.onHoursChange,
    required this.onMinutesChange,
  });
  final Function(int hours) onHoursChange;
  final Function(int minutes) onMinutesChange;
  @override
  State<SetExamDurationScreen> createState() => _SetExamDurationScreenState();
}

class _SetExamDurationScreenState extends State<SetExamDurationScreen> {
  int selectedHours = 0;
  int selectedMinutes = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Exam Duration"),
        const SizedBox(height: 5),

        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.secondary),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButton<int>(
                value: selectedHours,
                items:
                    List.generate(6, (index) => index)
                        .map(
                          (h) => DropdownMenuItem(
                            value: h,
                            child: Text("$h hours"),
                          ),
                        )
                        .toList(),
                onChanged: (val) {
                  setState(() {
                    if (val != null) {
                      selectedHours = val;
                      widget.onHoursChange(val);
                    }
                  });
                },
              ),
              const SizedBox(width: 20),

              DropdownButton<int>(
                value: selectedMinutes,
                items:
                    List.generate(60, (index) => index)
                        .map(
                          (m) => DropdownMenuItem(
                            value: m,
                            child: Text("$m minutes"),
                          ),
                        )
                        .toList(),
                onChanged: (val) {
                  setState(() {
                    if (val != null) {
                      selectedMinutes = val;
                      widget.onMinutesChange(val);
                    }
                  });
                },
              ),
            ],
          ),
        ),

        // const SizedBox(height: 16),
      ],
    );
  }
}
