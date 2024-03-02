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
    titleController.text = task.title;
    startDate = task.startDate;
    endDate = task.endDate;
    descriptionController.text = task.description;
    category = task.category;
  }

  @override
  void onSubmit() {
    _updateTask();
    Navigator.pop(context);
  }

  void _updateTask() {
    task.title = titleController.text;
    task.startDate = startDate;
    task.endDate = endDate;
    task.description = descriptionController.text;
    task.category = category;

    taskService.update(task.id, task);
  }
}
