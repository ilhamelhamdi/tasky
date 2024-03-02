import 'package:hive_flutter/adapters.dart';
import 'package:tasky/models/task_model.dart';

Future<void> setupConfig() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(CategoryAdapter());

  await Hive.openBox<Task>('tasks');
}
