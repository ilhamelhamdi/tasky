import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/config/custom_text_styles.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/service_locator.dart';
import 'package:tasky/services/task_service.dart';
import 'package:tasky/widgets/custom_text_field.dart';
import 'package:tasky/widgets/date_picker_button.dart';
import 'package:tasky/widgets/primary_button.dart';
import 'package:tasky/widgets/secondary_button.dart';
import 'package:tasky/widgets/time_picker_button.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  static const String routeName = "/add-task";

  @override
  State<AddTaskPage> createState() => AddTaskPageState();
}

class AddTaskPageState<T extends AddTaskPage> extends State<T> {
  String get title {
    return "Add Task";
  }

  TaskService taskService = getIt<TaskService>();

  DateTime startDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  DateTime endDate = DateTime.now();
  TimeOfDay endTime = TimeOfDay.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Category category = Category.priority;

  void setCategory(Category newCategory) {
    setState(() {
      category = newCategory;
    });
  }

  void onSubmit() {
    _createTask();
    Navigator.pop(context);
  }

  void _createTask() {
    DateTime startDateTime = DateTime(startDate.year, startDate.month,
        startDate.day, startTime.hour, startTime.minute);
    DateTime endDateTime = DateTime(
        endDate.year, endDate.month, endDate.day, endTime.hour, endTime.minute);
    final newTask = Task(
        title: titleController.text,
        startDate: startDateTime,
        endDate: endDateTime,
        isChecked: false,
        description: descriptionController.text,
        category: category);
    taskService.create(newTask);
  }

  void _setStartDate(DateTime date) {
    setState(() {
      startDate = date;
    });
    if (date.isAfter(endDate)) {
      setState(() {
        endDate = date;
      });
    }
  }

  void _setEndDate(DateTime date) {
    setState(() {
      endDate = date;
    });
    if (date.isBefore(startDate)) {
      setState(() {
        startDate = date;
      });
    }
  }

  void _setStartTime(TimeOfDay time) {
    setState(() {
      startTime = time;
    });
    if (_isStartTimeAfterEndTime(time, endTime)) {
      setState(() {
        endTime = time;
      });
    }
  }

  void _setEndTime(TimeOfDay time) {
    setState(() {
      endTime = time;
    });
    if (_isStartTimeAfterEndTime(startTime, time)) {
      setState(() {
        startTime = time;
      });
    }
  }

  bool _isStartTimeAfterEndTime(TimeOfDay startTime, TimeOfDay endTime) {
    DateTime startDateTime = DateTime(startDate.year, startDate.month,
        startDate.day, startTime.hour, startTime.minute);
    DateTime endDateTime = DateTime(
        endDate.year, endDate.month, endDate.day, endTime.hour, endTime.minute);
    return startDateTime.isAfter(endDateTime);
  }

  @override
  Widget build(BuildContext context) {
    Widget buidCategoryButton(Category thisCategory) {
      var child = Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text('${toBeginningOfSentenceCase(thisCategory.name)} Task'),
      );
      late Widget button;
      if (thisCategory == category) {
        button = PrimaryButton(
            onPressed: () {
              setCategory(thisCategory);
            },
            child: child);
      } else {
        button = SecondaryButton(
            onPressed: () {
              setCategory(thisCategory);
            },
            child: child);
      }
      return Expanded(child: button);
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(title),
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(bottom: 16.0),
                ),
                pinned: true,
                stretch: true,
                expandedHeight: 200,
                collapsedHeight: 80,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                surfaceTintColor: Colors.transparent,
              ),
              SliverToBoxAdapter(
                  child: Container(
                padding: const EdgeInsets.all(16.0),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 160,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(36.0)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16.0),
                    Text("Title", style: CustomTextStyle.title(context)),
                    CustomTextField(
                      controller: titleController,
                      hintText: "Enter task title",
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Start",
                                  style: CustomTextStyle.title(context)),
                              DatePickerButton(
                                  date: startDate, setDate: _setStartDate),
                              const SizedBox(height: 8.0),
                              TimePickerButton(
                                  time: startTime, setTime: _setStartTime)
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("End",
                                  style: CustomTextStyle.title(context)),
                              DatePickerButton(
                                  date: endDate, setDate: _setEndDate),
                              const SizedBox(height: 8.0),
                              TimePickerButton(
                                  time: endTime, setTime: _setEndTime)
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text("Category", style: CustomTextStyle.title(context)),
                    Builder(builder: (context) {
                      var categoryButtons =
                          Category.values.map(buidCategoryButton).toList();
                      List<Widget> rowItems = [];
                      for (var element in categoryButtons) {
                        rowItems.add(element);
                        rowItems.add(const SizedBox(width: 16.0));
                      }
                      rowItems.removeLast();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: rowItems,
                      );
                    }),
                    const SizedBox(height: 16.0),
                    Text("Description", style: CustomTextStyle.title(context)),
                    CustomTextField(
                      controller: descriptionController,
                      minLines: 5,
                      hintText: "Enter task description",
                    ),
                    const SizedBox(height: 32.0),
                    SizedBox(
                        width: double.infinity,
                        child: PrimaryButton(
                            onPressed: onSubmit, child: const Text("Submit")))
                  ],
                ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
