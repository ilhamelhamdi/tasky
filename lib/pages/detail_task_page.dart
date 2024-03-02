import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/config/custom_text_styles.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/pages/edit_task_page.dart';
import 'package:tasky/service_locator.dart';
import 'package:tasky/services/task_service.dart';
import 'package:tasky/widgets/base_button.dart';
import 'package:tasky/widgets/box_container.dart';
import 'package:tasky/widgets/datetime_card.dart';
import 'package:tasky/widgets/primary_button.dart';

class DetailTaskPage extends StatefulWidget {
  final String taskId;
  const DetailTaskPage({super.key, required this.taskId});

  static const String routeName = "/detail-task";

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  TaskService taskService = getIt<TaskService>();

  late Future<Task> _task;
  late AlertDialog deleteAlertDialog;

  @override
  void initState() {
    super.initState();
    _task = _getTask();
  }

  Future<Task> _getTask() async {
    return await taskService.getById(widget.taskId);
  }

  Future<void> _toggleCheckedTask() async {
    await taskService.toggleChecked(widget.taskId);
    setState(() {
      _task = _getTask();
    });
  }

  void _navigateToEditTask() async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditTaskPage(taskId: widget.taskId);
    }));
    setState(() {
      _task = _getTask();
    });
  }

  void _deleteTask() async {
    await taskService.delete(widget.taskId);
  }

  void _onDeleteButtonPressed() {
    showDialog(context: context, builder: (context) => deleteAlertDialog);
  }

  @override
  Widget build(BuildContext context) {
    deleteAlertDialog = AlertDialog(
      title: const Text("Delete Task"),
      content: const Text("Are you sure you want to delete this task?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel")),
        TextButton(
            onPressed: () {
              _deleteTask();
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Delete")),
      ],
    );

    return Scaffold(
        body: Stack(children: [
      Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
      ),
      CustomScrollView(
        slivers: [
          const SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Task Detail"),
              centerTitle: true,
              titlePadding: EdgeInsets.only(bottom: 16.0),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(36.0)),
            ),
            child: FutureBuilder(
                future: _task,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No data"),
                    );
                  }
                  return Column(children: [
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        IconButton(
                          onPressed: _toggleCheckedTask,
                          icon: Icon(
                              snapshot.data!.isChecked
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: snapshot.data!.isChecked
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).colorScheme.secondary,
                              size: 48),
                        ),
                        const SizedBox(width: 16.0),
                        Text(
                          snapshot.data!.title,
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: DateTimeCard(
                              title: "Start",
                              dateTime: snapshot.data!.startDate),
                        ),
                        const SizedBox(width: 16.0),
                        Flexible(
                          child: DateTimeCard(
                              title: "End", dateTime: snapshot.data!.endDate),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Category", style: CustomTextStyle.title(context)),
                        const SizedBox(height: 8.0),
                        BoxContainer(
                          child: Text(
                              "${toBeginningOfSentenceCase(snapshot.data!.category.name)} Task"),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Description",
                            style: CustomTextStyle.title(context)),
                        const SizedBox(height: 8.0),
                        BoxContainer(
                          child: Text(
                            snapshot.data!.description.isEmpty
                                ? "No description"
                                : snapshot.data!.description,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 32.0),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                          onPressed: _navigateToEditTask,
                          child: const Text(
                            "Edit Task",
                          )),
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: BaseButton(
                          onPressed: _onDeleteButtonPressed,
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.red.shade800,
                          borderColor: Colors.red.shade800,
                          child: const Text(
                            "Delete Task",
                          )),
                    ),
                  ]);
                }),
          ))
        ],
      ),
    ]));
  }
}
