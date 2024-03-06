import 'package:flutter/material.dart';
import 'package:tasky/widgets/secondary_button.dart';

class TimePickerButton extends StatelessWidget {
  final TimeOfDay time;
  final void Function(TimeOfDay date) setTime;
  const TimePickerButton(
      {super.key, required this.time, required this.setTime});

  dateTimePickerWidget(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: time,
    );
    if (selectedTime != null) {
      setTime(selectedTime);
    }
  }

  String paddedTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
        onPressed: () {
          dateTimePickerWidget(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time),
            const SizedBox(width: 8.0),
            Text(paddedTime(time), style: const TextStyle(color: Colors.black)),
          ],
        ));
  }
}
