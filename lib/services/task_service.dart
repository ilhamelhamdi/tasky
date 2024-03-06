import 'package:tasky/models/task_model.dart';

abstract class TaskService {
  Future<List<Task>> getAll();
  Future<Task> getById(String id);
  Future<Task> create(Task task);
  Future<Task> update(String id, Task newTask);
  Future<void> delete(String id);
  Future<void> toggleChecked(String id);
  Future<List<Task>> filterByCategory(String category);
}
