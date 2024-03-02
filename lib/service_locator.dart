import 'package:get_it/get_it.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/repositories/local_repository.dart';
import 'package:tasky/repositories/task_local_repository.dart';
import 'package:tasky/services/task_service.dart';
import 'package:tasky/services/task_service_impl.dart';

final getIt = GetIt.instance;

void serviceLocator() {
  // Repositories
  getIt.registerSingleton<LocalRepository<Task>>(TaskLocalRepository());

  // Services
  getIt.registerSingleton<TaskService>(TaskServiceImpl(repository: getIt()));
}
