import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/pages/detail_task_page.dart';
import 'package:tasky/pages/profile_page.dart';
import 'package:tasky/service_locator.dart';
import 'package:tasky/services/task_service.dart';
import 'package:tasky/widgets/primary_button.dart';
import 'package:tasky/widgets/task_card.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static const String routeName = "/";

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TaskService taskService = getIt();

  late Future<List<Task>> _tasks;
  late String _currentDate;

  @override
  void initState() {
    super.initState();
    _tasks = getAllTasks();
    _currentDate = DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now());
  }

  Future<List<Task>> getAllTasks() async {
    return await taskService.getAll();
  }

  Future<Task> updateTask(String id, Task newTask) async {
    return await taskService.update(id, newTask);
  }

  Future<void> toggleCheckedTask(String id) async {
    await taskService.toggleChecked(id);
    setState(() {
      _tasks = getAllTasks();
    });
  }

  void addTask() {
    Navigator.pushNamed(context, "/add-task").then((value) => setState(() {
          _tasks = getAllTasks();
        }));
  }

  void navigateToDetailTask(String id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailTaskPage(taskId: id);
    })).then((value) => setState(() {
          _tasks = getAllTasks();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_currentDate),
              const SizedBox(height: 32.0),
              Text(
                "Welcome ${ProfileData.nickname}",
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                "Have a nice day!",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Daily Task",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      )),
                  PrimaryButton(
                      onPressed: addTask, child: const Text("+ Add task")),
                ],
              ),
              const SizedBox(height: 16.0),
              FutureBuilder(
                  future: _tasks,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.data!.isEmpty) {
                      return const Text("Nothing to do here :)");
                    } else {
                      var children = snapshot.data!
                          .map((task) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TaskCard(
                                  task: task,
                                  toggleCheck: () {
                                    toggleCheckedTask(task.id);
                                  },
                                  onPressed: () {
                                    navigateToDetailTask(task.id);
                                  },
                                ),
                              ))
                          .toList();
                      return Column(children: children);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
