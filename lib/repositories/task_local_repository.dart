import 'package:hive_flutter/adapters.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/repositories/local_repository.dart';

class TaskLocalRepository implements LocalRepository<Task> {
  late Box<Task> dataSource;

  TaskLocalRepository() {
    _initHive();
  }

  void _initHive() async {
    // await Hive.openBox('tasks');
    dataSource = Hive.box<Task>('tasks');
  }

  @override
  Future<Task> getById(String id) async {
    return dataSource.get(id) as Task;
  }

  @override
  Future<List<Task>> getAll() async {
    return dataSource.values.toList();
  }

  @override
  Future<Task> create(Task task) async {
    await dataSource.put(task.id, task);
    return task;
  }

  @override
  Future<Task> update(String id, Task newTask) async {
    await dataSource.put(id, newTask);
    return newTask;
  }

  @override
  Future<void> delete(String id) async {
    await dataSource.delete(id);
  }
}
