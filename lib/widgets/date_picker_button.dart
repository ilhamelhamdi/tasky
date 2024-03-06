import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/widgets/secondary_button.dart';

class DatePickerButton extends StatelessWidget {
  final DateTime date;
  final void Function(DateTime date) setDate;
  const DatePickerButton(
      {super.key, required this.date, required this.setDate});

  dateTimePickerWidget(BuildContext context) async {
    return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    ).then((value) {
      if (value != null) {
        setDate(value);
      }
    });
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
            const Icon(Icons.date_range),
            const SizedBox(width: 8.0),
            Text(DateFormat('dd MMM yyyy').format(date),
                style: const TextStyle(color: Colors.black)),
          ],
        ));
  }
}
