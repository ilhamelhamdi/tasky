import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/config/custom_text_styles.dart';
import 'package:tasky/widgets/box_container.dart';

class DateTimeCard extends StatelessWidget {
  final String title;
  final DateTime dateTime;
  const DateTimeCard({super.key, required this.title, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: CustomTextStyle.title(context)),
        const SizedBox(height: 8.0),
        BoxContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.calendar_today_rounded,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 8.0),
              Text(DateFormat('dd MMM yyyy | kk:mm').format(dateTime)),
            ],
          ),
        )
      ],
    );
  }
}
