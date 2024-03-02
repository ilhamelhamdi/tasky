import 'package:tasky/models/task_model.dart';
import 'package:tasky/repositories/local_repository.dart';
import 'package:tasky/services/task_service.dart';

class TaskServiceImpl implements TaskService {
  LocalRepository<Task> repository;

  TaskServiceImpl({required this.repository});

  @override
  Future<List<Task>> getAll() async {
    return await repository.getAll();
  }

  @override
  Future<Task> getById(String id) async {
    return await repository.getById(id);
  }

  @override
  Future<Task> create(Task task) async {
    return await repository.create(task);
  }

  @override
  Future<Task> update(String id, Task newTask) async {
    return await repository.update(id, newTask);
  }

  @override
  Future<void> delete(String id) async {
    await repository.delete(id);
  }

  @override
  Future<void> toggleChecked(String id) async {
    Task task = await repository.getById(id);
    task.isChecked = !task.isChecked;
    await repository.update(id, task);
  }
}
