import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:tasky/widgets/secondary_button.dart';

class DateTimeButton extends StatelessWidget {
  final DateTime date;
  final void Function(DateTime date) setDate;
  const DateTimeButton({super.key, required this.date, required this.setDate});

  dateTimePickerWidget(BuildContext context) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(2000),
      maxDateTime: DateTime(3000),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectdate = dateTime;
        setDate(selectdate);
      },
    );
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
            Text(DateFormat('dd MMM yyyy | kk:mm').format(date),
                style: const TextStyle(color: Colors.black)),
          ],
        ));
  }
}
