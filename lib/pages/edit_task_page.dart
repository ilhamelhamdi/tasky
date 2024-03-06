import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/pages/add_task_page.dart';

class EditTaskPage extends AddTaskPage {
  final String taskId;
  const EditTaskPage({super.key, required this.taskId});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends AddTaskPageState<EditTaskPage> {
  @override
  String get title {
    return "Edit Task";
  }

  late Task task;

  @override
  void initState() {
    super.initState();
    getTask();
  }

  void getTask() async {
    task = await taskService.getById(widget.taskId);
    setState(() {
      titleController.text = task.title;
      startDate = task.startDate;
      endDate = task.endDate;
      startTime = TimeOfDay.fromDateTime(startDate);
      endTime = TimeOfDay.fromDateTime(endDate);
      descriptionController.text = task.description;
      category = task.category;
    });
  }

  @override
  void onSubmit() {
    _updateTask();
    Navigator.pop(context);
  }

  void _updateTask() {
    var startDateTime = DateTime(startDate.year, startDate.month, startDate.day,
        startTime.hour, startTime.minute);
    var endDateTime = DateTime(
        endDate.year, endDate.month, endDate.day, endTime.hour, endTime.minute);

    task.title = titleController.text;
    task.startDate = startDateTime;
    task.endDate = endDateTime;
    task.description = descriptionController.text;
    task.category = category;

    taskService.update(task.id, task);
  }
}
