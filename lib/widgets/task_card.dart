import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/secondary_button.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final void Function()? toggleCheck;
  final void Function() onPressed;
  const TaskCard(
      {super.key,
      required this.task,
      required this.toggleCheck,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task.title,
                style: TextStyle(
                    fontSize: 16.0,
                    color: (task.isChecked
                        ? Theme.of(context).primaryColor
                        : Colors.black)),
              ),
              Checkbox(
                  value: task.isChecked,
                  side: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2.0),
                  onChanged: (bool? value) {
                    toggleCheck!();
                  })
            ],
          ),
        ));
  }
}
