import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/config/custom_text_styles.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/service_locator.dart';
import 'package:tasky/services/task_service.dart';
import 'package:tasky/widgets/custom_text_field.dart';
import 'package:tasky/widgets/datetime_button.dart';
import 'package:tasky/widgets/primary_button.dart';
import 'package:tasky/widgets/secondary_button.dart';

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
  DateTime endDate = DateTime.now();
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
    final newTask = Task(
        title: titleController.text,
        startDate: startDate,
        endDate: endDate,
        isChecked: false,
        description: descriptionController.text,
        category: category);
    taskService.create(newTask);
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
                              DateTimeButton(
                                  date: startDate,
                                  setDate: (DateTime date) {
                                    setState(() {
                                      startDate = date;
                                    });
                                  })
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
                              DateTimeButton(
                                  date: endDate,
                                  setDate: (DateTime date) {
                                    setState(() {
                                      endDate = date;
                                    });
                                  })
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
